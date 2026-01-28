import 'package:freezed_annotation/freezed_annotation.dart';

part 'task.freezed.dart';
part 'task.g.dart';

/// 奖励类型
enum RewardType {
  @JsonValue('pack')
  pack,
  
  @JsonValue('stardust')
  stardust,
}

/// 任务模型
@freezed
class Task with _$Task {
  const factory Task({
     required String id,
     required String title,
     required String description,
     
     /// 奖励类型 (pack, stardust)
     required RewardType rewardType,
     
     /// 奖励数量
     required int rewardAmount,
     
     /// 当前进度
     @Default(0) int progress,
     
     /// 目标值
     required int target,
     
     /// 是否已领取
     @Default(false) bool isClaimed,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

extension TaskX on Task {
  /// 是否已完成
  bool get isCompleted => progress >= target;
  
  /// 进度百分比 (0.0 - 1.0)
  double get progressPercent => (progress / target).clamp(0.0, 1.0);
}
