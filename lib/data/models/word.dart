import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
part 'word.g.dart';

/// 单词模型
/// 对应 Supabase `words` 表（静态数据）
@freezed
class Word with _$Word {
  const factory Word({
    /// 单词 ID（自增主键）
    required int id,

    /// 单词拼写（必填）
    required String text,

    /// 音标（可选）
    String? phonetic,

    /// 中文释义（可选）
    String? definition,

    /// 词性 (n., v., adj., adv.)（可选）
    @JsonKey(name: 'part_of_speech') String? partOfSpeech,

    /// 稀有度 (common, rare, epic, legend)（可选）
    String? rarity,

    /// 主题 ID（可选）
    @JsonKey(name: 'theme_id') String? themeId,

    /// 词形变化（JSON 格式）
    /// 例如：{"past": "ran", "plural": "runs", "present_participle": "running"}
    Map<String, dynamic>? forms,
  }) = _Word;

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);
}

/// 稀有度枚举
enum Rarity {
  @JsonValue('common')
  common,

  @JsonValue('rare')
  rare,

  @JsonValue('epic')
  epic,

  @JsonValue('legend')
  legend;

  /// 获取中文名称
  String get displayName {
    switch (this) {
      case Rarity.common:
        return '普通';
      case Rarity.rare:
        return '稀有';
      case Rarity.epic:
        return '史诗';
      case Rarity.legend:
        return '传说';
    }
  }

  /// 从字符串解析
  static Rarity fromString(String value) {
    switch (value.toLowerCase()) {
      case 'common':
        return Rarity.common;
      case 'rare':
        return Rarity.rare;
      case 'epic':
        return Rarity.epic;
      case 'legend':
      case 'legendary':
        return Rarity.legend;
      default:
        return Rarity.common;
    }
  }
}

/// 词性枚举
enum PartOfSpeech {
  @JsonValue('n.')
  noun,

  @JsonValue('v.')
  verb,

  @JsonValue('adj.')
  adjective,

  @JsonValue('adv.')
  adverb,

  @JsonValue('prep.')
  preposition,

  @JsonValue('conj.')
  conjunction,

  @JsonValue('pron.')
  pronoun,

  @JsonValue('interj.')
  interjection;

  /// 获取缩写
  String get abbreviation {
    switch (this) {
      case PartOfSpeech.noun:
        return 'n.';
      case PartOfSpeech.verb:
        return 'v.';
      case PartOfSpeech.adjective:
        return 'adj.';
      case PartOfSpeech.adverb:
        return 'adv.';
      case PartOfSpeech.preposition:
        return 'prep.';
      case PartOfSpeech.conjunction:
        return 'conj.';
      case PartOfSpeech.pronoun:
        return 'pron.';
      case PartOfSpeech.interjection:
        return 'interj.';
    }
  }

  /// 获取中文名称
  String get displayName {
    switch (this) {
      case PartOfSpeech.noun:
        return '名词';
      case PartOfSpeech.verb:
        return '动词';
      case PartOfSpeech.adjective:
        return '形容词';
      case PartOfSpeech.adverb:
        return '副词';
      case PartOfSpeech.preposition:
        return '介词';
      case PartOfSpeech.conjunction:
        return '连词';
      case PartOfSpeech.pronoun:
        return '代词';
      case PartOfSpeech.interjection:
        return '感叹词';
    }
  }

  /// 从字符串解析
  static PartOfSpeech? fromString(String? value) {
    if (value == null) return null;
    
    switch (value.toLowerCase().trim()) {
      case 'n':
      case 'n.':
      case 'noun':
        return PartOfSpeech.noun;
      case 'v':
      case 'v.':
      case 'verb':
        return PartOfSpeech.verb;
      case 'adj':
      case 'adj.':
      case 'adjective':
        return PartOfSpeech.adjective;
      case 'adv':
      case 'adv.':
      case 'adverb':
        return PartOfSpeech.adverb;
      case 'prep':
      case 'prep.':
      case 'preposition':
        return PartOfSpeech.preposition;
      case 'conj':
      case 'conj.':
      case 'conjunction':
        return PartOfSpeech.conjunction;
      case 'pron':
      case 'pron.':
      case 'pronoun':
        return PartOfSpeech.pronoun;
      case 'interj':
      case 'interj.':
      case 'interjection':
        return PartOfSpeech.interjection;
      default:
        return null;
    }
  }
}
