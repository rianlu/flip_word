// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WordImpl _$$WordImplFromJson(Map<String, dynamic> json) => _$WordImpl(
  id: (json['id'] as num).toInt(),
  text: json['text'] as String,
  phonetic: json['phonetic'] as String?,
  definition: json['definition'] as String?,
  partOfSpeech: json['part_of_speech'] as String?,
  rarity: json['rarity'] as String?,
  themeId: (json['theme_id'] as num?)?.toInt(),
  forms: json['forms'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$$WordImplToJson(_$WordImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'phonetic': instance.phonetic,
      'definition': instance.definition,
      'part_of_speech': instance.partOfSpeech,
      'rarity': instance.rarity,
      'theme_id': instance.themeId,
      'forms': instance.forms,
    };
