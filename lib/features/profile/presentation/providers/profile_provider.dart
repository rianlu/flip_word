import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/models/models.dart';
import '../../../../core/services/mock_database_service.dart';

part 'profile_provider.freezed.dart';

/// 档案页面状态
/// 包含数据库各表聚合的数据（Profile + 统计数据）
@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required Profile profile,
    @Default(0) int daysStreak,
    @Default(0) int wordsCollected,
    @Default(false) bool isLoading,
  }) = _ProfileState;
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  // 注入 Mock Service
  final MockDatabaseService _db;

  ProfileNotifier(this._db)
      : super(
          ProfileState(
            profile: _db.currentUser,
            daysStreak: _db.daysStreak,
            wordsCollected: _db.getWordsCollectedCount(),
          ),
        );

  /// 消费星尘
  bool spendStardust(int amount) {
    // 1. 调用 DB 尝试消费
    final success = _db.consumeStardust(amount);
    
    // 2. 如果成功，更新本地状态以刷新 UI
    if (success) {
      refresh();
    }
    return success;
  }
  
  // 刷新最新数据（从 Mock DB 同步）
  void refresh() {
      state = state.copyWith(
          profile: _db.currentUser,
          daysStreak: _db.daysStreak,
          wordsCollected: _db.getWordsCollectedCount(),
      );
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  // 获取单例
  final db = MockDatabaseService();
  // db.init(); // 已经在 main.dart 中全异步初始化
  return ProfileNotifier(db);
});
