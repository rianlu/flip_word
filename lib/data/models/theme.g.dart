// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ThemeImpl _$$ThemeImplFromJson(Map<String, dynamic> json) => _$ThemeImpl(
  id: json['id'] as String,
  name: json['name'] as String?,
  emoji: json['emoji'] as String?,
  description: json['description'] as String?,
  category: json['category'] as String?,
  color: json['color'] as String?,
);

Map<String, dynamic> _$$ThemeImplToJson(_$ThemeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'emoji': instance.emoji,
      'description': instance.description,
      'category': instance.category,
      'color': instance.color,
    };
