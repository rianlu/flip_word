import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// 用户档案模型
/// 对应 Supabase `profiles` 表
@freezed
class Profile with _$Profile {
  const factory Profile({
    /// 用户 ID（UUID，关联 auth.users）
    required String id,

    /// 用户昵称（可选）
    String? nickname,

    /// 星尘数量（默认 0）
    @Default(0) int stardust,

    /// 账户创建时间
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);
}
