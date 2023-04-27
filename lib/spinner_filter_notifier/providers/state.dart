import 'package:flutter/widgets.dart';

import 'entity.dart';

// import 'package:freezed_annotation/freezed_annotation.dart';
// part 'state.freezed.dart';
// @freezed
// class SpinnerFilterState with _$SpinnerFilterState {
//   const factory SpinnerFilterState({
//     /// 是否单选模式
//     /// 是否只有一个条件且只能单选 （判断显示底部按钮）(没有额外输入的筛选项-待定)
//     /// `true` 点击按钮就要关闭弹框
//     /// `false` 只有点击确认才关闭
//     @Default(false) bool singleConditionAndSingleSelect,

//     /// 是否完成选择
//     @Default(false) bool isCompleted,

//     /// 原始数据
//     @Default([]) List<EntityNotifier> items,

//     /// 选中数据
//     @Default(false) bool isInit,
//   }) = _SpinnerFilterState;
// }

class SpinnerFilterState {
  final bool singleConditionAndSingleSelect;
  final bool isCompleted;
  final bool isInit;
  final List<EntityNotifier> items;

  const SpinnerFilterState({
    this.singleConditionAndSingleSelect = false,
    this.isCompleted = false,
    this.items = const [],
    this.isInit = false,
  });

  SpinnerFilterState copyWith({
    bool? singleConditionAndSingleSelect,
    bool? isCompleted,
    bool? isInit,
    List<EntityNotifier>? items,
  }) =>
      SpinnerFilterState(
        singleConditionAndSingleSelect: singleConditionAndSingleSelect ??
            this.singleConditionAndSingleSelect,
        isCompleted: isCompleted ?? this.isCompleted,
        items: items ?? this.items,
        isInit: isInit ?? this.isInit,
      );
}

class EntityNotifier {
  EntityNotifier(this.entity) {
    changeList = entity.items.map((e) {
      final option = OptionsNotifier(e);
      option.selected = e.selected;
      return option;
    }).toList();
  }
  SpinnerFilterEntity entity;

  /// 可监听选中变化的数据
  late List<OptionsNotifier<SpinnerFilterItem>> changeList;

  /// 清空保存的额外输入内容
  cleanExtra() {
    entity = entity.copyWith(extraData: null);
  }
}

class OptionsNotifier<T> extends ValueNotifier {
  OptionsNotifier(this.data) : super(data);
  final T data;

  bool _selected = false;
  bool get selected => _selected;
  set selected(bool value) {
    if (_selected != value) {
      _selected = value;
      notifyListeners();
    }
  }
}
