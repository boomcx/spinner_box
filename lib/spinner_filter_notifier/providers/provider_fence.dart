import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import 'entity.dart';
import 'state.dart';

class SpinnerFenceNotifier extends ValueNotifier<SpinnerFenceState> {
  SpinnerFenceNotifier(
    SpinnerFenceState state,
    this.onReseted,
    this.onItemIntercept,
  ) : super(state);

  /// 构造方法
  factory SpinnerFenceNotifier.init(
    SpinnerEntity data,
    VoidCallback? onReseted,
    SpinnerItemIntercept? onItemIntercept,
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
  final SpinnerItemIntercept? onItemIntercept;

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
      singleConditionAndSingleSelect: singleSelect,
      // items: data.map((e) => EntityNotifier(e)).toList(),
      //  解决 `List.of(data)` - `ChangeNotifier` 无法重建的问题
      data: res,
      idxList: List.generate(res.items.tier, (index) => 0),
    );
  }

  /// 完成筛选
  void completed() {
    value = value.copyWith(isCompleted: true);
  }

  /// 重置
  /// `key` 当前组的字段
  void reset([String? key]) {
    // 按钮重置
    var items = value.data.items;

    chidrenSelected(items, false);

    for (var e in items) {
      e.selected = e.isMutex;
      e.highlighted = e.isMutex;
    }

    notifyListeners();

    onReseted?.call();
  }

  /// 获取选择的结果
  Tuple2<Map<String, List<dynamic>>, String> getResult() {
    // final items = value.items;
    final reslut = <String, List>{};
    final reslutNames = [];

    // for (var group in items) {
    //   final key = group.key;
    //   var resGroup = {key: []};

    //   // 如果有拼接组件，则先从自定义组件中寻找是否选定结果
    //   if (attachment.isNotEmpty) {
    //     for (var element in attachment) {
    //       if (element.groupKey == key && element.extraData != null) {
    //         final res = element.getResult();
    //         resGroup = res.item1;
    //         if (res.item2.isNotEmpty) {
    //           reslutNames.add(res.item2);
    //         }
    //         break;
    //       }
    //     }
    //   }

    //   // 如果自定义组件没有选择，则检索筛选项是否选中
    //   if (resGroup[key]?.isEmpty == true) {
    //     final list = group.items;
    //     for (var item in list) {
    //       if (item.selected) {
    //         resGroup[key]!.add(item.result);
    //         reslutNames.add(item.name);
    //       }
    //     }
    //   }

    //   reslut.addAll(resGroup);
    // }

    return Tuple2(reslut, reslutNames.join('/'));
  }

  /// 判断子集是否有选中
  bool chidrenSelectedStatus(List<SpinnerItem> list) {
    for (var element in list) {
      if (element.selected) {
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
  chidrenSelected(List<SpinnerItem> list, bool state) {
    for (var element in list) {
      element.selected = state;
      element.highlighted = false;
      if (element.items.isNotEmpty) {
        chidrenSelected(element.items, state);
      }
    }
  }

  /// 设置子集选中
  superSelected(List<SpinnerItem> list) {
    for (var element in list) {
      if (element.items.isNotEmpty) {
        element.selected = chidrenSelectedStatus(element.items);
      }
    }
  }

  /// 点击按钮选项
  /// `tuple` 包含当前点击的分组数据 和 分组下标
  /// `index` 按钮下标
  void itemOnSelected(int index, int column,
      [bool isHighlighted = true]) async {
    if (onItemIntercept != null) {
      final isIntercept = await onItemIntercept!.call(value.data, index);
      if (isIntercept == true) {
        return;
      }
    }

    final single = value.data.isRadio;

    final items = getColumn(column);
    final item = items[index];

    // 处理互斥选项
    for (var e in items) {
      // 如果当前为全选，则清空其他选项
      if (item.isMutex) {
        if (e.name != item.name) {
          e.selected = false;
          chidrenSelected(e.items, false);
        }
      } else {
        if (e.isMutex) {
          e.selected = false;
          chidrenSelected(e.items, false);
        }
      }
    }

    // 设置当前及子集选中
    item.selected = !item.selected;
    chidrenSelected(item.items, item.selected);

    for (var i = 0; i < value.idxList.length; i++) {
      if (i >= column) {
        break;
      }
      final idx = value.idxList[i];
      final list = getColumn(i);
      if (list[idx].items.isNotEmpty) {
        list[idx].selected = chidrenSelectedStatus(list[idx].items);
      }
    }

    itemOnHightlighted(index, column);

    if (value.singleConditionAndSingleSelect) {
      // 完成条件
      completed();
    }
  }

  /// 获取对应列的数据列表
  List<SpinnerItem> getColumn(int index) {
    final fenceList = value.data.items;
    if (index == 0) {
      return fenceList;
    }
    List<SpinnerItem> list = fenceList;

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
    final items = getColumn(column);

    /// 如果当前点击`item`为最末子集（它的`items`为空）
    /// 直接设置选中状态
    // if (items[index].items.isEmpty) {
    //   itemOnSelected(index, column, false);
    // }

    for (var k = 0; k < items.length; k++) {
      // 单选
      if (items[k].items.isNotEmpty || column == 0) {
        items[k].highlighted = index == k;
      }
    }

    /// 单选
    if (value.data.isRadio && column == value.idxList.length - 1) {
      // itemOnSelected(index, column, false);
      final items = getColumn(column);
      final item = items[index];

      // 处理互斥选项
      for (var e in items) {
        // 如果当前为全选，则清空其他选项
        if (item.isMutex) {
          if (e.name != item.name) {
            e.selected = false;
            chidrenSelected(e.items, false);
          }
        } else {
          if (e.isMutex) {
            e.selected = false;
            chidrenSelected(e.items, false);
          }
        }
      }

      // 设置当前及子集选中
      item.selected = !item.selected;
      chidrenSelected(item.items, item.selected);
    }

    /// 获取子集数据列表
    var list = List.of(value.idxList);
    list.replaceRange(column, column + 1, [index]);
    value = value.copyWith(idxList: list);
  }
}
