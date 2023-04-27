import 'package:flutter/widgets.dart';

import 'entity.dart';

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
  final SpinnerFilterEntity entity;

  /// 可监听选中变化的数据
  late List<OptionsNotifier<SpinnerFilterItem>> changeList;
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
