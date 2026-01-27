// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PackImpl _$$PackImplFromJson(Map<String, dynamic> json) => _$PackImpl(
  id: json['id'] as String,
  themeId: (json['themeId'] as num?)?.toInt(),
  type: $enumDecodeNullable(_$PackTypeEnumMap, json['type']) ?? PackType.normal,
  status:
      $enumDecodeNullable(_$PackStatusEnumMap, json['status']) ??
      PackStatus.unopened,
  cards:
      (json['cards'] as List<dynamic>?)
          ?.map((e) => Word.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  obtainedAt: json['obtainedAt'] == null
      ? null
      : DateTime.parse(json['obtainedAt'] as String),
);

Map<String, dynamic> _$$PackImplToJson(_$PackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'themeId': instance.themeId,
      'type': _$PackTypeEnumMap[instance.type]!,
      'status': _$PackStatusEnumMap[instance.status]!,
      'cards': instance.cards,
      'obtainedAt': instance.obtainedAt?.toIso8601String(),
    };

const _$PackTypeEnumMap = {
  PackType.normal: 'normal',
  PackType.theme: 'theme',
  PackType.premium: 'premium',
};

const _$PackStatusEnumMap = {
  PackStatus.unopened: 'unopened',
  PackStatus.opened: 'opened',
};
