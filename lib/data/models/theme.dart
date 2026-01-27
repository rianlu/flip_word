import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';
part 'theme.g.dart';

/// 主题模型
/// 对应 Supabase `themes` 表
/// 例如："水果乐园 🍎"、"动物世界 🦁"
@freezed
class Theme with _$Theme {
  const factory Theme({
    /// 主题 ID（自增主键）
    required int id,

    /// 主题名称（可选）
    /// 例如："水果乐园"
    String? name,

    /// 主题 Emoji（可选）
    /// 例如："🍎"
    String? emoji,
  }) = _Theme;

  factory Theme.fromJson(Map<String, dynamic> json) => _$ThemeFromJson(json);
}

/// 预定义主题常量（示例）
class ThemeConstants {
  ThemeConstants._();

  static const List<Map<String, String>> defaultThemes = [
    {'name': '水果乐园', 'emoji': '🍎'},
    {'name': '动物世界', 'emoji': '🦁'},
    {'name': '颜色缤纷', 'emoji': '🌈'},
    {'name': '数字王国', 'emoji': '🔢'},
    {'name': '日常用语', 'emoji': '💬'},
    {'name': '校园生活', 'emoji': '🏫'},
    {'name': '运动健身', 'emoji': '⚽'},
    {'name': '美食天地', 'emoji': '🍕'},
  ];
}
