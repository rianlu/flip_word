// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_word.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserWordImpl _$$UserWordImplFromJson(Map<String, dynamic> json) =>
    _$UserWordImpl(
      userId: json['user_id'] as String,
      wordId: (json['word_id'] as num).toInt(),
      isCollected: json['is_collected'] as bool? ?? false,
      starLevel: (json['star_level'] as num?)?.toInt() ?? 1,
      nextReviewAt: json['next_review_at'] == null
          ? null
          : DateTime.parse(json['next_review_at'] as String),
      interval: (json['interval'] as num?)?.toInt() ?? 0,
      easeFactor: (json['ease_factor'] as num?)?.toDouble() ?? 2.5,
    );

Map<String, dynamic> _$$UserWordImplToJson(_$UserWordImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'word_id': instance.wordId,
      'is_collected': instance.isCollected,
      'star_level': instance.starLevel,
      'next_review_at': instance.nextReviewAt?.toIso8601String(),
      'interval': instance.interval,
      'ease_factor': instance.easeFactor,
    };
