import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
  /// 所有选中的集合
  List<SpinnerItem> results,

  /// 所有选中名称的集合
  List<String> names,

  /// 当前通过选择操作的数据
  SpinnerEntity data,
);

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
      singleConditionAndSingleSelect: singleSelect,
      // items: data.map((e) => EntityNotifier(e)).toList(),
      // 解决 `List.of(data)` - `ChangeNotifier` 无法重建的问题
      data: res,
      idxList: defaultIndexList(res.items),
    );
  }

  /// 获取默认选中展示
  static List<int> defaultIndexList(List<SpinnerItem> list) {
    final idxList = <int>[];
    final count = list.tier;

    runLoop(List<SpinnerItem> list) {
      for (var i = 0; i < list.length; i++) {
        final item = list[i];
        if (item.selected) {
          idxList.add(i);
          if (idxList.length < count) {
            runLoop(item.items);
          }
          break;
        }
      }
    }

    runLoop(list);

    final length = idxList.length;
    for (var i = 0; i < count - length; i++) {
      idxList.add(0);
    }

    return idxList;
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
      // e.highlighted = e.isMutex;
    }

    value = value.copyWith(idxList: value.idxList.map((e) => 0).toList());

    // notifyListeners();

    onReseted?.call();
  }

  /// 获取选择的结果
  Tuple2<List<SpinnerItem>, List<String>> getResult() {
    if (value.singleConditionAndSingleSelect) {
      final lastList = getColumn(value.idxList.length - 1);
      final item = lastList[value.idxList.last];
      return Tuple2([item], [item.name]);
    }

    final resluts = <SpinnerItem>[];
    final reslutNames = <String>[];

    for (var element in value.data.items) {
      if (element.selected) {
        resluts.add(element);
        reslutNames.add(element.name);
      }
    }

    return Tuple2(resluts, reslutNames);
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
      // element.highlighted = false;
      if (element.items.isNotEmpty) {
        chidrenSelected(element.items, state);
      }
    }
  }

  /// 点击按钮选项
  /// `tuple` 包含当前点击的分组数据 和 分组下标
  /// `index` 按钮下标
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

    // 切换选中项
    itemOnHightlighted(index, column);
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
      chidrenSelected(value.data.items, false);

      // 设置当前及子集选中
      item.selected = !item.selected;

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

      // 结束选择
      completed();
    }
  }
}
