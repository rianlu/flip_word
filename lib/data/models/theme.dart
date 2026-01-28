import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';
part 'theme.g.dart';

/// 主题模型
/// 对应 Supabase `themes` 表
/// 例如："水果乐园 🍎"、"动物世界 🦁"
@freezed
class ThemeModel with _$ThemeModel {
  const factory ThemeModel({
    /// 主题 ID (String)
    required String id,

    /// 主题名称（可选）
    String? name,

    /// 主题 Emoji（可选）
    String? emoji,
    
    /// 描述 (Description)
    String? description,

    /// 分类 (Category)
    String? category,

    /// 颜色 (Color Hex String)
    String? color,
  }) = _Theme;

  factory ThemeModel.fromJson(Map<String, dynamic> json) => _$ThemeModelFromJson(json);
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
