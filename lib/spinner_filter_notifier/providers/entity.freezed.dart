// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SpinnerFilterEntity _$SpinnerFilterEntityFromJson(Map<String, dynamic> json) {
  return _MoreFilterEntity.fromJson(json);
}

/// @nodoc
mixin _$SpinnerFilterEntity {
  /// 服务器字段
  String get key => throw _privateConstructorUsedError;

  /// 是否单选
  bool get isRadio => throw _privateConstructorUsedError;

  /// 标题，空不显示
  String get title => throw _privateConstructorUsedError;

  /// 每组内容的显示风格
  MoreContentType get type => throw _privateConstructorUsedError;

  /// 问号描述，点击显示内容
  String get desc => throw _privateConstructorUsedError;

  /// 是否 vip 逻辑处理 待补充
  bool get isVip => throw _privateConstructorUsedError;

  /// 是否显示 vip 按钮
  bool get isVipIcon => throw _privateConstructorUsedError;

  /// 选项集
  List<SpinnerFilterItem> get items => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpinnerFilterEntityCopyWith<SpinnerFilterEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpinnerFilterEntityCopyWith<$Res> {
  factory $SpinnerFilterEntityCopyWith(
          SpinnerFilterEntity value, $Res Function(SpinnerFilterEntity) then) =
      _$SpinnerFilterEntityCopyWithImpl<$Res, SpinnerFilterEntity>;
  @useResult
  $Res call(
      {String key,
      bool isRadio,
      String title,
      MoreContentType type,
      String desc,
      bool isVip,
      bool isVipIcon,
      List<SpinnerFilterItem> items});
}

/// @nodoc
class _$SpinnerFilterEntityCopyWithImpl<$Res, $Val extends SpinnerFilterEntity>
    implements $SpinnerFilterEntityCopyWith<$Res> {
  _$SpinnerFilterEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? isRadio = null,
    Object? title = null,
    Object? type = null,
    Object? desc = null,
    Object? isVip = null,
    Object? isVipIcon = null,
    Object? items = null,
  }) {
    return _then(_value.copyWith(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      isRadio: null == isRadio
          ? _value.isRadio
          : isRadio // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MoreContentType,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as bool,
      isVipIcon: null == isVipIcon
          ? _value.isVipIcon
          : isVipIcon // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SpinnerFilterItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoreFilterEntityCopyWith<$Res>
    implements $SpinnerFilterEntityCopyWith<$Res> {
  factory _$$_MoreFilterEntityCopyWith(
          _$_MoreFilterEntity value, $Res Function(_$_MoreFilterEntity) then) =
      __$$_MoreFilterEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String key,
      bool isRadio,
      String title,
      MoreContentType type,
      String desc,
      bool isVip,
      bool isVipIcon,
      List<SpinnerFilterItem> items});
}

/// @nodoc
class __$$_MoreFilterEntityCopyWithImpl<$Res>
    extends _$SpinnerFilterEntityCopyWithImpl<$Res, _$_MoreFilterEntity>
    implements _$$_MoreFilterEntityCopyWith<$Res> {
  __$$_MoreFilterEntityCopyWithImpl(
      _$_MoreFilterEntity _value, $Res Function(_$_MoreFilterEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? key = null,
    Object? isRadio = null,
    Object? title = null,
    Object? type = null,
    Object? desc = null,
    Object? isVip = null,
    Object? isVipIcon = null,
    Object? items = null,
  }) {
    return _then(_$_MoreFilterEntity(
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      isRadio: null == isRadio
          ? _value.isRadio
          : isRadio // ignore: cast_nullable_to_non_nullable
              as bool,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MoreContentType,
      desc: null == desc
          ? _value.desc
          : desc // ignore: cast_nullable_to_non_nullable
              as String,
      isVip: null == isVip
          ? _value.isVip
          : isVip // ignore: cast_nullable_to_non_nullable
              as bool,
      isVipIcon: null == isVipIcon
          ? _value.isVipIcon
          : isVipIcon // ignore: cast_nullable_to_non_nullable
              as bool,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SpinnerFilterItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoreFilterEntity
    with DiagnosticableTreeMixin
    implements _MoreFilterEntity {
  const _$_MoreFilterEntity(
      {required this.key,
      this.isRadio = true,
      this.title = '',
      this.type = MoreContentType.groupBtn,
      this.desc = '',
      this.isVip = false,
      this.isVipIcon = false,
      final List<SpinnerFilterItem> items = const []})
      : _items = items;

  factory _$_MoreFilterEntity.fromJson(Map<String, dynamic> json) =>
      _$$_MoreFilterEntityFromJson(json);

  /// 服务器字段
  @override
  final String key;

  /// 是否单选
  @override
  @JsonKey()
  final bool isRadio;

  /// 标题，空不显示
  @override
  @JsonKey()
  final String title;

  /// 每组内容的显示风格
  @override
  @JsonKey()
  final MoreContentType type;

  /// 问号描述，点击显示内容
  @override
  @JsonKey()
  final String desc;

  /// 是否 vip 逻辑处理 待补充
  @override
  @JsonKey()
  final bool isVip;

  /// 是否显示 vip 按钮
  @override
  @JsonKey()
  final bool isVipIcon;

  /// 选项集
  final List<SpinnerFilterItem> _items;

  /// 选项集
  @override
  @JsonKey()
  List<SpinnerFilterItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SpinnerFilterEntity(key: $key, isRadio: $isRadio, title: $title, type: $type, desc: $desc, isVip: $isVip, isVipIcon: $isVipIcon, items: $items)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SpinnerFilterEntity'))
      ..add(DiagnosticsProperty('key', key))
      ..add(DiagnosticsProperty('isRadio', isRadio))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('desc', desc))
      ..add(DiagnosticsProperty('isVip', isVip))
      ..add(DiagnosticsProperty('isVipIcon', isVipIcon))
      ..add(DiagnosticsProperty('items', items));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoreFilterEntity &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.isRadio, isRadio) || other.isRadio == isRadio) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.desc, desc) || other.desc == desc) &&
            (identical(other.isVip, isVip) || other.isVip == isVip) &&
            (identical(other.isVipIcon, isVipIcon) ||
                other.isVipIcon == isVipIcon) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, key, isRadio, title, type, desc,
      isVip, isVipIcon, const DeepCollectionEquality().hash(_items));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoreFilterEntityCopyWith<_$_MoreFilterEntity> get copyWith =>
      __$$_MoreFilterEntityCopyWithImpl<_$_MoreFilterEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoreFilterEntityToJson(
      this,
    );
  }
}

abstract class _MoreFilterEntity implements SpinnerFilterEntity {
  const factory _MoreFilterEntity(
      {required final String key,
      final bool isRadio,
      final String title,
      final MoreContentType type,
      final String desc,
      final bool isVip,
      final bool isVipIcon,
      final List<SpinnerFilterItem> items}) = _$_MoreFilterEntity;

  factory _MoreFilterEntity.fromJson(Map<String, dynamic> json) =
      _$_MoreFilterEntity.fromJson;

  @override

  /// 服务器字段
  String get key;
  @override

  /// 是否单选
  bool get isRadio;
  @override

  /// 标题，空不显示
  String get title;
  @override

  /// 每组内容的显示风格
  MoreContentType get type;
  @override

  /// 问号描述，点击显示内容
  String get desc;
  @override

  /// 是否 vip 逻辑处理 待补充
  bool get isVip;
  @override

  /// 是否显示 vip 按钮
  bool get isVipIcon;
  @override

  /// 选项集
  List<SpinnerFilterItem> get items;
  @override
  @JsonKey(ignore: true)
  _$$_MoreFilterEntityCopyWith<_$_MoreFilterEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

SpinnerFilterItem _$SpinnerFilterItemFromJson(Map<String, dynamic> json) {
  return _MoreFilterItem.fromJson(json);
}

/// @nodoc
mixin _$SpinnerFilterItem {
  /// 显示名称
  String get name => throw _privateConstructorUsedError;

  /// 选中项的数据值 (原样输入输出)
  dynamic get value => throw _privateConstructorUsedError;

  /// 是否选中
  bool get selected => throw _privateConstructorUsedError;

  /// 是否选互斥（选中时清空当前其他选中项，一般用于 `全部` `不限` 等合并条件项）
  bool get isMutex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SpinnerFilterItemCopyWith<SpinnerFilterItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpinnerFilterItemCopyWith<$Res> {
  factory $SpinnerFilterItemCopyWith(
          SpinnerFilterItem value, $Res Function(SpinnerFilterItem) then) =
      _$SpinnerFilterItemCopyWithImpl<$Res, SpinnerFilterItem>;
  @useResult
  $Res call({String name, dynamic value, bool selected, bool isMutex});
}

/// @nodoc
class _$SpinnerFilterItemCopyWithImpl<$Res, $Val extends SpinnerFilterItem>
    implements $SpinnerFilterItemCopyWith<$Res> {
  _$SpinnerFilterItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = freezed,
    Object? selected = null,
    Object? isMutex = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      isMutex: null == isMutex
          ? _value.isMutex
          : isMutex // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MoreFilterItemCopyWith<$Res>
    implements $SpinnerFilterItemCopyWith<$Res> {
  factory _$$_MoreFilterItemCopyWith(
          _$_MoreFilterItem value, $Res Function(_$_MoreFilterItem) then) =
      __$$_MoreFilterItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, dynamic value, bool selected, bool isMutex});
}

/// @nodoc
class __$$_MoreFilterItemCopyWithImpl<$Res>
    extends _$SpinnerFilterItemCopyWithImpl<$Res, _$_MoreFilterItem>
    implements _$$_MoreFilterItemCopyWith<$Res> {
  __$$_MoreFilterItemCopyWithImpl(
      _$_MoreFilterItem _value, $Res Function(_$_MoreFilterItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? value = freezed,
    Object? selected = null,
    Object? isMutex = null,
  }) {
    return _then(_$_MoreFilterItem(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as dynamic,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as bool,
      isMutex: null == isMutex
          ? _value.isMutex
          : isMutex // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MoreFilterItem
    with DiagnosticableTreeMixin
    implements _MoreFilterItem {
  const _$_MoreFilterItem(
      {required this.name,
      this.value,
      this.selected = false,
      this.isMutex = false});

  factory _$_MoreFilterItem.fromJson(Map<String, dynamic> json) =>
      _$$_MoreFilterItemFromJson(json);

  /// 显示名称
  @override
  final String name;

  /// 选中项的数据值 (原样输入输出)
  @override
  final dynamic value;

  /// 是否选中
  @override
  @JsonKey()
  final bool selected;

  /// 是否选互斥（选中时清空当前其他选中项，一般用于 `全部` `不限` 等合并条件项）
  @override
  @JsonKey()
  final bool isMutex;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SpinnerFilterItem(name: $name, value: $value, selected: $selected, isMutex: $isMutex)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SpinnerFilterItem'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('value', value))
      ..add(DiagnosticsProperty('selected', selected))
      ..add(DiagnosticsProperty('isMutex', isMutex));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MoreFilterItem &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.isMutex, isMutex) || other.isMutex == isMutex));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name,
      const DeepCollectionEquality().hash(value), selected, isMutex);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MoreFilterItemCopyWith<_$_MoreFilterItem> get copyWith =>
      __$$_MoreFilterItemCopyWithImpl<_$_MoreFilterItem>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MoreFilterItemToJson(
      this,
    );
  }
}

abstract class _MoreFilterItem implements SpinnerFilterItem {
  const factory _MoreFilterItem(
      {required final String name,
      final dynamic value,
      final bool selected,
      final bool isMutex}) = _$_MoreFilterItem;

  factory _MoreFilterItem.fromJson(Map<String, dynamic> json) =
      _$_MoreFilterItem.fromJson;

  @override

  /// 显示名称
  String get name;
  @override

  /// 选中项的数据值 (原样输入输出)
  dynamic get value;
  @override

  /// 是否选中
  bool get selected;
  @override

  /// 是否选互斥（选中时清空当前其他选中项，一般用于 `全部` `不限` 等合并条件项）
  bool get isMutex;
  @override
  @JsonKey(ignore: true)
  _$$_MoreFilterItemCopyWith<_$_MoreFilterItem> get copyWith =>
      throw _privateConstructorUsedError;
}
