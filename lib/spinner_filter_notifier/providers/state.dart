import 'entity.dart';

class SpinnerFilterState {
  final bool singleConditionAndSingleSelect;
  final bool isCompleted;
  final bool isInit;
  final List<SpinnerEntity> items;

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
    List<SpinnerEntity>? items,
  }) =>
      SpinnerFilterState(
        singleConditionAndSingleSelect: singleConditionAndSingleSelect ??
            this.singleConditionAndSingleSelect,
        isCompleted: isCompleted ?? this.isCompleted,
        items: items ?? this.items,
        isInit: isInit ?? this.isInit,
      );
}

class SpinnerFenceState {
  final bool singleConditionAndSingleSelect;
  final bool isCompleted;
  final List<int> idxList;
  final SpinnerEntity data;

  const SpinnerFenceState({
    this.singleConditionAndSingleSelect = false,
    this.isCompleted = false,
    this.data = const SpinnerEntity(key: '-'),
    this.idxList = const [],
  });

  SpinnerFenceState copyWith({
    bool? singleConditionAndSingleSelect,
    bool? isCompleted,
    List<int>? idxList,
    SpinnerEntity? data,
  }) =>
      SpinnerFenceState(
        singleConditionAndSingleSelect: singleConditionAndSingleSelect ??
            this.singleConditionAndSingleSelect,
        isCompleted: isCompleted ?? this.isCompleted,
        data: data ?? this.data,
        idxList: idxList ?? this.idxList,
      );
}
