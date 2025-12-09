import 'dart:async';

import 'package:flutter/material.dart';

import 'entity.dart';
import 'state.dart';

/// 点击拦截的回调
typedef SpinnerFenceIntercept = FutureOr<bool> Function(
  /// 当前点击的下标位置
  List<int> idxList,

  /// 当前通过选择操作的数据
  SpinnerEntity data,
);

/// 完成筛选的回调
typedef SpinnerFenceResponse = Function(
  /// 选中的集合,如果下级为全选中,则只返回当前数据
  ///
  /// eg：地址选择中，选中北京全部区县，则返回北京。在半选状态下，返回当前选中的区县
  List<SpinnerItemData> results,

  /// 所有选中名称的集合
  String names,

  /// 当前通过选择操作的数据
  SpinnerEntity data,

  /// 判断是否仅关闭弹窗
  bool onlyClosed,
);

class SpinnerFenceNotifier extends ValueNotifier<SpinnerFenceState> {
  SpinnerFenceNotifier(
    super.state,
    this.onReseted,
    this.onItemIntercept,
  );

  /// 构造方法
  factory SpinnerFenceNotifier.init(
    SpinnerEntity data,
    VoidCallback? onReseted,
    SpinnerFenceIntercept? onItemIntercept,
  ) {
    if (data.items.isEmpty) {
      return SpinnerFenceNotifier(
          const SpinnerFenceState(), onReseted, onItemIntercept);
    }
    final instance =
        SpinnerFenceNotifier(_getState(data), onReseted, onItemIntercept);
    return instance;
  }

  /// 事件传递
  final VoidCallback? onReseted;

  /// 事件传递
  final SpinnerFenceIntercept? onItemIntercept;

  /// 需要返回至外部得数据，同步原数据筛选状态
  SpinnerEntity get outside => value.data;

  /// `didUpdateWidget` 时触发
  /// 更新当前state，用于异步显示筛选条件
  updateState(SpinnerEntity data) {
    value = _getState(data);
    notifyListeners();
  }

  /// 构建状态类型
  static SpinnerFenceState _getState(SpinnerEntity data) {
    final res = SpinnerEntity.fromJson(data.toJson());
    final singleSelect = data.isRadio == true;
    return SpinnerFenceState(
      singleConditionAndSingleSelect: data.isShowButtons ? false : singleSelect,
      // items: data.map((e) => EntityNotifier(e)).toList(),
      // 解决 `List.of(data)` - `ChangeNotifier` 无法重建的问题
      data: res,
      idxList: defaultIndexList(res),
    );
  }

  /// 获取默认选中展示
  static List<int> defaultIndexList(SpinnerEntity entity) {
    final idxList = <int>[];
    final count = entity.items.tier;

    runLoop(List<SpinnerItemData> list) {
      for (var i = 0; i < list.length; i++) {
        final item = list[i];
        if (item.selected == SCheckedStatus.checked ||
            item.selected == SCheckedStatus.semiChecked) {
          idxList.add(i);
          if (idxList.length < count) {
            runLoop(item.items);
          }
          break;
        }
      }
    }

    runLoop(entity.items);

    final length = idxList.length;
    for (var i = 0; i < count - length; i++) {
      idxList.add(0);
    }

    return idxList;
  }

  /// 完成筛选
  void completed([bool onlyClosed = false]) {
    value = value.copyWith(
      isCompleted: true,
      onlyClosed: onlyClosed,
    );
  }

  /// 重置
  /// `key` 当前组的字段
  /// `isMutex` 是否设置互斥
  void reset({
    String? key,
    bool isMutex = true,
  }) {
    // 按钮重置
    var items = value.data.items;

    chidrenSelected(items, SCheckedStatus.unchecked);

    if (isMutex) {
      for (var e in items) {
        e.selected =
            e.isMutex ? SCheckedStatus.checked : SCheckedStatus.unchecked;
      }
    }

    value = value.copyWith(idxList: value.idxList.map((e) => 0).toList());

    // notifyListeners();

    onReseted?.call();
  }

  /// 获取选择的结果
  (List<SpinnerItemData> selectedList, List<String> names) getResult() {
    if (value.singleConditionAndSingleSelect) {
      final lastList = getColumn(value.idxList.length - 1);
      final item = lastList[value.idxList.last];
      return ([item], [item.name]);
    }

    final resluts = <SpinnerItemData>[];
    final reslutNames = <String>[];

    deepForEach(List<SpinnerItemData> list) {
      for (var e in list) {
        if (e.selected == SCheckedStatus.checked) {
          resluts.add(e);
          reslutNames.add(e.name);
        } else if (e.selected == SCheckedStatus.semiChecked) {
          // jsonList.add(e.toJson());
          if (e.items.isNotEmpty) {
            deepForEach(e.items);
          }
        }
      }
    }

    deepForEach(value.data.items);

    return (resluts, reslutNames);
  }

  /// 判断子集是否有选中
  bool chidrenSelectedStatus(List<SpinnerItemData> list) {
    for (var element in list) {
      if (element.selected == SCheckedStatus.checked) {
        return true;
      }
      if (element.items.isNotEmpty) {
        if (chidrenSelectedStatus(element.items)) {
          return true;
        }
      }
    }
    return false;
  }

  /// 设置子集选中
  chidrenSelected(List<SpinnerItemData> list, SCheckedStatus state) {
    for (var element in list) {
      element.selected = state;
      // element.highlighted = false;
      if (element.items.isNotEmpty) {
        chidrenSelected(element.items, state);
      }
    }
  }

  /// 点击按钮选项
  ///
  ///
  /// `index` 按钮下标
  /// `column` 当前列
  void itemOnSelected(int index, int column,
      [bool isHighlighted = true]) async {
    if (onItemIntercept != null) {
      final isIntercept =
          await onItemIntercept!.call(value.idxList, value.data);
      if (isIntercept == true) {
        return;
      }
    }

    final items = getColumn(column);
    final item = items[index];

    // 处理互斥选项
    if (item.isMutex) {
      reset(isMutex: false);
    } else {
      for (var e in value.data.items) {
        if (e.isMutex) {
          e.selected = SCheckedStatus.unchecked;
          break;
        }
      }
    }

    // for (var e in items) {
    //   // 如果当前为全选，则清空其他选项
    //   if (item.isMutex) {
    //     if (e.name != item.name) {
    //       e.selected = SCheckedStatus.unchecked;
    //       chidrenSelected(e.items, SCheckedStatus.unchecked);
    //     }
    //   } else {
    //     if (e.isMutex) {
    //       e.selected = SCheckedStatus.unchecked;
    //       chidrenSelected(e.items, SCheckedStatus.unchecked);
    //     }
    //   }
    // }

    // 子集遍历选中
    var selected = SCheckedStatus.checked;
    if (item.selected == SCheckedStatus.checked ||
        item.selected == SCheckedStatus.semiChecked) {
      selected = SCheckedStatus.unchecked;
    }
    _itemCheckedAndChildren(item, (e) {
      e.selected = selected;
    });

    // 设置当前及子集选中
    // item.selected = item.selected == SCheckedStatus.unchecked
    //     ? SCheckedStatus.checked
    //     : SCheckedStatus.unchecked;
    // chidrenSelected(item.items, item.selected);

    // for (var i = 0; i < value.idxList.length; i++) {
    //   if (i >= column) {
    //     break;
    //   }
    //   final idx = value.idxList[i];
    //   final list = getColumn(i);
    //   if (list[idx].items.isNotEmpty) {
    //     list[idx].selected = chidrenSelectedStatus(list[idx].items)
    //         ? SCheckedStatus.checked
    //         : SCheckedStatus.unchecked;
    //   }
    // }

    // 父级遍历选中
    final firstItem = value.data.items[value.idxList.first];
    _fatherCheckedFormChildren(firstItem, (e) {
      e.selected = _isChildrenAllChecked(e);
    });

    // 切换选中项
    itemOnHightlighted(index, column);
  }

  /// 获取对应列的数据列表
  List<SpinnerItemData> getColumn(int index) {
    final fenceList = value.data.items;
    if (index == 0) {
      return fenceList;
    }
    List<SpinnerItemData> list = fenceList;

    for (var i = 0; i < index; i++) {
      final idx = value.idxList[i];
      if (list.length > idx) {
        list = list[idx].items;
      }
    }
    return list;
  }

  /// `fence` 模式下分组切换
  void itemOnHightlighted(int index, int column) async {
    // final items = getColumn(column);

    /// 如果当前点击`item`为最末子集（它的`items`为空）
    /// 直接设置选中状态
    // if (items[index].items.isEmpty) {
    //   itemOnSelected(index, column, false);
    // }

    // for (var k = 0; k < items.length; k++) {
    //   // 单选
    //   if (items[k].items.isNotEmpty || column == 0) {
    //     items[k].highlighted = index == k;
    //   }
    // }

    /// 获取子集数据列表
    var list = List.of(value.idxList);
    for (var i = column; i < value.idxList.length; i++) {
      list.replaceRange(i, i + 1, [i > column ? 0 : index]);
    }
    value = value.copyWith(idxList: list);

    /// 单选
    if (value.data.isRadio && column == value.idxList.length - 1) {
      // itemOnSelected(index, column, false);
      final items = getColumn(column);
      final item = items[index];

      // 清空之前选项
      chidrenSelected(value.data.items, SCheckedStatus.unchecked);

      // 设置当前及子集选中
      item.selected = item.selected == SCheckedStatus.unchecked
          ? SCheckedStatus.checked
          : SCheckedStatus.unchecked;

      for (var i = 0; i < value.idxList.length; i++) {
        if (i >= column) {
          break;
        }
        final idx = value.idxList[i];
        final list = getColumn(i);
        if (list[idx].items.isNotEmpty) {
          list[idx].selected = chidrenSelectedStatus(list[idx].items)
              ? SCheckedStatus.checked
              : SCheckedStatus.unchecked;
        }
      }

      // 结束选择
      completed();
    }
  }

  /// 关联当前item和子集的选中状态
  SCheckedStatus _isChildrenAllChecked(SpinnerItemData item) {
    if (item.items.isEmpty) {
      return item.selected;
    }
    int checkedCount = 0;
    for (var e in item.items) {
      // 有半选，上级一定是半选
      if (e.selected == SCheckedStatus.semiChecked) {
        return SCheckedStatus.semiChecked;
      } else if (e.selected == SCheckedStatus.checked) {
        checkedCount++;
      }
    }
    if (checkedCount == item.items.length) {
      return SCheckedStatus.checked;
    } else if (checkedCount > 0) {
      return SCheckedStatus.semiChecked;
    }
    return SCheckedStatus.unchecked;
  }

  /// 向上关联
  _fatherCheckedFormChildren(
      SpinnerItemData item, void Function(SpinnerItemData) elementOperate) {
    for (var e in item.items) {
      if (e.items.isNotEmpty) {
        _deepForEach(e.items, elementOperate);
      }
      elementOperate.call(e);
    }
    elementOperate.call(item);
  }

  /// 向下关联
  _itemCheckedAndChildren(
      SpinnerItemData item, void Function(SpinnerItemData) elementOperate) {
    elementOperate.call(item);
    for (var e in item.items) {
      elementOperate.call(e);
      // deep for
      if (e.items.isNotEmpty) {
        _deepForEach(e.items, elementOperate);
      }
    }
  }

  /// 深度遍历
  _deepForEach(List<SpinnerItemData> list,
      void Function(SpinnerItemData) elementOperate) {
    for (var e in list) {
      elementOperate.call(e);
      // deep for
      if (e.items.isNotEmpty) {
        _deepForEach(e.items, elementOperate);
      }
    }
  }
}
