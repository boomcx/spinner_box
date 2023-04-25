// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of 'entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MoreFilterEntity _$$_MoreFilterEntityFromJson(Map<String, dynamic> json) =>
    _$_MoreFilterEntity(
      key: json['key'] as String,
      isRadio: json['isRadio'] as bool? ?? true,
      title: json['title'] as String? ?? '',
      type: $enumDecodeNullable(_$MoreContentTypeEnumMap, json['type']) ??
          MoreContentType.groupBtn,
      desc: json['desc'] as String? ?? '',
      isVip: json['isVip'] as bool? ?? false,
      isVipIcon: json['isVipIcon'] as bool? ?? false,
      items: (json['items'] as List<dynamic>?)
              ?.map(
                  (e) => SpinnerFilterItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_MoreFilterEntityToJson(_$_MoreFilterEntity instance) =>
    <String, dynamic>{
      'key': instance.key,
      'isRadio': instance.isRadio,
      'title': instance.title,
      'type': _$MoreContentTypeEnumMap[instance.type]!,
      'desc': instance.desc,
      'isVip': instance.isVip,
      'isVipIcon': instance.isVipIcon,
      'items': instance.items,
    };

const _$MoreContentTypeEnumMap = {
  MoreContentType.groupBtn: 'groupBtn',
  MoreContentType.checkList: 'checkList',
};

_$_MoreFilterItem _$$_MoreFilterItemFromJson(Map<String, dynamic> json) =>
    _$_MoreFilterItem(
      name: json['name'] as String,
      value: json['value'],
      selected: json['selected'] as bool? ?? false,
      isMutex: json['isMutex'] as bool? ?? false,
    );

Map<String, dynamic> _$$_MoreFilterItemToJson(_$_MoreFilterItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'selected': instance.selected,
      'isMutex': instance.isMutex,
    };
