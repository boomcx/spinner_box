// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SpinnerFilterState {
  /// 是否单选模式
  /// 是否只有一个条件且只能单选 （判断显示底部按钮）(没有额外输入的筛选项-待定)
  /// `true` 点击按钮就要关闭弹框
  /// `false` 只有点击确认才关闭
  bool get singleConditionAndSingleSelect => throw _privateConstructorUsedError;

  /// 是否完成选择
  bool get isCompleted => throw _privateConstructorUsedError;

  /// 原始数据
  List<EntityNotifier> get items => throw _privateConstructorUsedError;

  /// 选中数据
  bool get isInit => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SpinnerFilterStateCopyWith<SpinnerFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpinnerFilterStateCopyWith<$Res> {
  factory $SpinnerFilterStateCopyWith(
          SpinnerFilterState value, $Res Function(SpinnerFilterState) then) =
      _$SpinnerFilterStateCopyWithImpl<$Res, SpinnerFilterState>;
  @useResult
  $Res call(
      {bool singleConditionAndSingleSelect,
      bool isCompleted,
      List<EntityNotifier> items,
      bool isInit});
}

/// @nodoc
class _$SpinnerFilterStateCopyWithImpl<$Res, $Val extends SpinnerFilterState>
    implements $SpinnerFilterStateCopyWith<$Res> {
  _$SpinnerFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? singleConditionAndSingleSelect = null,
    Object? isCompleted = null,
    Object? items = null,
    Object? isInit = null,
  }) {
    return _then(_value.copyWith(
      singleConditionAndSingleSelect: null == singleConditionAndSingleSelect
          ? _value.singleConditionAndSingleSelect
          : singleConditionAndSingleSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EntityNotifier>,
      isInit: null == isInit
          ? _value.isInit
          : isInit // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SpinnerFilterStateCopyWith<$Res>
    implements $SpinnerFilterStateCopyWith<$Res> {
  factory _$$_SpinnerFilterStateCopyWith(_$_SpinnerFilterState value,
          $Res Function(_$_SpinnerFilterState) then) =
      __$$_SpinnerFilterStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool singleConditionAndSingleSelect,
      bool isCompleted,
      List<EntityNotifier> items,
      bool isInit});
}

/// @nodoc
class __$$_SpinnerFilterStateCopyWithImpl<$Res>
    extends _$SpinnerFilterStateCopyWithImpl<$Res, _$_SpinnerFilterState>
    implements _$$_SpinnerFilterStateCopyWith<$Res> {
  __$$_SpinnerFilterStateCopyWithImpl(
      _$_SpinnerFilterState _value, $Res Function(_$_SpinnerFilterState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? singleConditionAndSingleSelect = null,
    Object? isCompleted = null,
    Object? items = null,
    Object? isInit = null,
  }) {
    return _then(_$_SpinnerFilterState(
      singleConditionAndSingleSelect: null == singleConditionAndSingleSelect
          ? _value.singleConditionAndSingleSelect
          : singleConditionAndSingleSelect // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<EntityNotifier>,
      isInit: null == isInit
          ? _value.isInit
          : isInit // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_SpinnerFilterState implements _SpinnerFilterState {
  const _$_SpinnerFilterState(
      {this.singleConditionAndSingleSelect = false,
      this.isCompleted = false,
      final List<EntityNotifier> items = const [],
      this.isInit = false})
      : _items = items;

  /// 是否单选模式
  /// 是否只有一个条件且只能单选 （判断显示底部按钮）(没有额外输入的筛选项-待定)
  /// `true` 点击按钮就要关闭弹框
  /// `false` 只有点击确认才关闭
  @override
  @JsonKey()
  final bool singleConditionAndSingleSelect;

  /// 是否完成选择
  @override
  @JsonKey()
  final bool isCompleted;

  /// 原始数据
  final List<EntityNotifier> _items;

  /// 原始数据
  @override
  @JsonKey()
  List<EntityNotifier> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// 选中数据
  @override
  @JsonKey()
  final bool isInit;

  @override
  String toString() {
    return 'SpinnerFilterState(singleConditionAndSingleSelect: $singleConditionAndSingleSelect, isCompleted: $isCompleted, items: $items, isInit: $isInit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SpinnerFilterState &&
            (identical(other.singleConditionAndSingleSelect,
                    singleConditionAndSingleSelect) ||
                other.singleConditionAndSingleSelect ==
                    singleConditionAndSingleSelect) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.isInit, isInit) || other.isInit == isInit));
  }

  @override
  int get hashCode => Object.hash(runtimeType, singleConditionAndSingleSelect,
      isCompleted, const DeepCollectionEquality().hash(_items), isInit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SpinnerFilterStateCopyWith<_$_SpinnerFilterState> get copyWith =>
      __$$_SpinnerFilterStateCopyWithImpl<_$_SpinnerFilterState>(
          this, _$identity);
}

abstract class _SpinnerFilterState implements SpinnerFilterState {
  const factory _SpinnerFilterState(
      {final bool singleConditionAndSingleSelect,
      final bool isCompleted,
      final List<EntityNotifier> items,
      final bool isInit}) = _$_SpinnerFilterState;

  @override

  /// 是否单选模式
  /// 是否只有一个条件且只能单选 （判断显示底部按钮）(没有额外输入的筛选项-待定)
  /// `true` 点击按钮就要关闭弹框
  /// `false` 只有点击确认才关闭
  bool get singleConditionAndSingleSelect;
  @override

  /// 是否完成选择
  bool get isCompleted;
  @override

  /// 原始数据
  List<EntityNotifier> get items;
  @override

  /// 选中数据
  bool get isInit;
  @override
  @JsonKey(ignore: true)
  _$$_SpinnerFilterStateCopyWith<_$_SpinnerFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}
