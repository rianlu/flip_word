import 'package:freezed_annotation/freezed_annotation.dart';
import 'word.dart';

part 'pack.freezed.dart';
part 'pack.g.dart';

/// 卡包模型
/// 用于开包结果和卡包展示
/// 注意：这不是数据库表，而是前端业务模型
@freezed
class Pack with _$Pack {
  const factory Pack({
    /// 卡包 ID（前端生成，用于追踪）
    required String id,

    /// 卡包主题 ID（可选）
    int? themeId,

    /// 卡包类型（普通包、主题包等）
    @Default(PackType.normal) PackType type,

    /// 卡包状态（未开/已开）
    @Default(PackStatus.unopened) PackStatus status,

    /// 卡包内的单词列表（开包后填充）
    @Default([]) List<Word> cards,

    /// 获得时间
    DateTime? obtainedAt,
  }) = _Pack;

  factory Pack.fromJson(Map<String, dynamic> json) => _$PackFromJson(json);
}

/// 卡包类型枚举
enum PackType {
  @JsonValue('normal')
  normal,

  @JsonValue('theme')
  theme,

  @JsonValue('premium')
  premium;

  /// 获取中文名称
  String get displayName {
    switch (this) {
      case PackType.normal:
        return '普通卡包';
      case PackType.theme:
        return '主题卡包';
      case PackType.premium:
        return '高级卡包';
    }
  }

  /// 获取卡包颜色（用于 UI 显示）
  String get colorHex {
    switch (this) {
      case PackType.normal:
        return '#BDC3C7'; // 灰色
      case PackType.theme:
        return '#3498DB'; // 蓝色
      case PackType.premium:
        return '#F39C12'; // 金色
    }
  }
}

/// 卡包状态枚举
enum PackStatus {
  @JsonValue('unopened')
  unopened,

  @JsonValue('opened')
  opened;

  /// 获取中文名称
  String get displayName {
    switch (this) {
      case PackStatus.unopened:
        return '未开启';
      case PackStatus.opened:
        return '已开启';
    }
  }
}

/// 卡包配置常量
class PackConfig {
  PackConfig._();

  /// 每个卡包包含的卡片数量
  static const int cardsPerPack = 5;

  /// 免费用户每日卡包上限
  static const int freeUserDailyLimit = 5;

  /// 订阅用户每日卡包上限
  static const int premiumUserDailyLimit = 8;

  /// 每复习多少个单词获得一个卡包
  static const int reviewsPerPack = 10;
}
