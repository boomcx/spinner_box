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
