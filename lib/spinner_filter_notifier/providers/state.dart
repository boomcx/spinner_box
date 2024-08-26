import 'entity.dart';

/// list / wrap 实际内容的配置
class SpinnerFilterState {
  /// 是否单选
  final bool singleConditionAndSingleSelect;

  /// 完成条件筛选
  final bool isCompleted;

  /// 仅关闭筛选弹窗
  final bool onlyClosed;

  /// 数据源
  final List<SpinnerEntity> items;

  const SpinnerFilterState({
    this.singleConditionAndSingleSelect = false,
    this.isCompleted = false,
    this.onlyClosed = false,
    this.items = const [],
  });

  SpinnerFilterState copyWith({
    bool? singleConditionAndSingleSelect,
    bool? isCompleted,
    bool? onlyClosed,
    List<SpinnerEntity>? items,
  }) =>
      SpinnerFilterState(
        singleConditionAndSingleSelect: singleConditionAndSingleSelect ??
            this.singleConditionAndSingleSelect,
        isCompleted: isCompleted ?? this.isCompleted,
        items: items ?? this.items,
        onlyClosed: onlyClosed ?? this.onlyClosed,
      );
}

/// 栅栏筛选配置
class SpinnerFenceState {
  /// 是否为单选
  final bool singleConditionAndSingleSelect;

  /// 是否完成筛选
  final bool isCompleted;

  /// 仅关闭筛选弹窗
  final bool onlyClosed;

  /// 每一列，选中项的索引
  final List<int> idxList;

  /// 筛选数据
  final SpinnerEntity data;

  const SpinnerFenceState({
    this.singleConditionAndSingleSelect = false,
    this.isCompleted = false,
    this.onlyClosed = false,
    this.data = const SpinnerEntity(key: '-'),
    this.idxList = const [],
  });

  SpinnerFenceState copyWith({
    bool? singleConditionAndSingleSelect,
    bool? isCompleted,
    bool? onlyClosed,
    List<int>? idxList,
    SpinnerEntity? data,
  }) =>
      SpinnerFenceState(
        singleConditionAndSingleSelect: singleConditionAndSingleSelect ??
            this.singleConditionAndSingleSelect,
        isCompleted: isCompleted ?? this.isCompleted,
        data: data ?? this.data,
        idxList: idxList ?? this.idxList,
        onlyClosed: onlyClosed ?? this.onlyClosed,
      );
}
