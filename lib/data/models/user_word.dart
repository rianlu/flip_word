import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_word.freezed.dart';
part 'user_word.g.dart';

/// 用户单词进度模型
/// 对应 Supabase `user_words` 表（核心存档数据）
/// 包含 SM-2 算法相关字段
@freezed
class UserWord with _$UserWord {
  const factory UserWord({
    /// 用户 ID（UUID）
    @JsonKey(name: 'user_id') required String userId,

    /// 单词 ID
    @JsonKey(name: 'word_id') required int wordId,

    /// 是否已收集（点亮图鉴）
    @JsonKey(name: 'is_collected') @Default(false) bool isCollected,

    /// 星级 (1-3)
    @JsonKey(name: 'star_level') @Default(1) int starLevel,

    // ==========================================
    // SM-2 算法参数
    // ==========================================

    /// 下次复习时间（可选，未复习过则为 null）
    @JsonKey(name: 'next_review_at') DateTime? nextReviewAt,

    /// 间隔天数（默认 0）
    @Default(0) int interval,

    /// 难度系数（SM-2 算法，默认 2.5）
    @JsonKey(name: 'ease_factor') @Default(2.5) double easeFactor,
  }) = _UserWord;

  factory UserWord.fromJson(Map<String, dynamic> json) =>
      _$UserWordFromJson(json);
}

/// SM-2 算法评分枚举
/// 用于用户对单词的掌握程度评分
enum SM2Rating {
  /// 完全忘记 (0分)
  again(value: 0, label: '再来'),

  /// 困难 (3分)
  hard(value: 3, label: '困难'),

  /// 良好 (4分)
  good(value: 4, label: '良好'),

  /// 轻松 (5分)
  easy(value: 5, label: '轻松');

  final int value;
  final String label;

  const SM2Rating({required this.value, required this.label});

  /// 根据数值获取评分
  static SM2Rating fromValue(int value) {
    switch (value) {
      case 0:
        return SM2Rating.again;
      case 3:
        return SM2Rating.hard;
      case 4:
        return SM2Rating.good;
      case 5:
        return SM2Rating.easy;
      default:
        return SM2Rating.again;
    }
  }
}

/// 星级枚举
enum StarLevel {
  /// 1 星 - 初学
  one(value: 1, label: '⭐'),

  /// 2 星 - 熟练
  two(value: 2, label: '⭐⭐'),

  /// 3 星 - 掌握
  three(value: 3, label: '⭐⭐⭐');

  final int value;
  final String label;

  const StarLevel({required this.value, required this.label});

  /// 根据数值获取星级
  static StarLevel fromValue(int value) {
    switch (value) {
      case 1:
        return StarLevel.one;
      case 2:
        return StarLevel.two;
      case 3:
        return StarLevel.three;
      default:
        return StarLevel.one;
    }
  }

  /// 获取描述
  String get description {
    switch (this) {
      case StarLevel.one:
        return '初学';
      case StarLevel.two:
        return '熟练';
      case StarLevel.three:
        return '掌握';
    }
  }
}
