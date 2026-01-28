// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  rewardType: $enumDecode(_$RewardTypeEnumMap, json['rewardType']),
  rewardAmount: (json['rewardAmount'] as num).toInt(),
  progress: (json['progress'] as num?)?.toInt() ?? 0,
  target: (json['target'] as num).toInt(),
  isClaimed: json['isClaimed'] as bool? ?? false,
);

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'rewardType': _$RewardTypeEnumMap[instance.rewardType]!,
      'rewardAmount': instance.rewardAmount,
      'progress': instance.progress,
      'target': instance.target,
      'isClaimed': instance.isClaimed,
    };

const _$RewardTypeEnumMap = {
  RewardType.pack: 'pack',
  RewardType.stardust: 'stardust',
};
