import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/mock_database_service.dart';

/// 用户资产状态
/// 现在只是 MockDatabaseService 的一个只读视图 + 简单的代理操作
/// 任何修改都会先写入 MockDB，然后通过 _syncFromDb 刷新状态
class UserState {
  final int stardust;
  final int availablePacks;
  final int streakDays;

  const UserState({
    this.stardust = 0,
    this.availablePacks = 0,
    this.streakDays = 0,
  });

  UserState copyWith({
    int? stardust,
    int? availablePacks,
    int? streakDays,
  }) {
    return UserState(
      stardust: stardust ?? this.stardust,
      availablePacks: availablePacks ?? this.availablePacks,
      streakDays: streakDays ?? this.streakDays,
    );
  }
}

/// 用户状态 Provider
class UserNotifier extends StateNotifier<UserState> {
  final MockDatabaseService _db;
  
  UserNotifier(this._db) : super(const UserState()) {
      _syncFromDb();
  }
  
  void _syncFromDb() {
      state = UserState(
          stardust: _db.stardust,
          availablePacks: _db.packCount,
          streakDays: _db.daysStreak,
      );
  }
  
  /// (Deprecated: Use MockDB methods directly if possible, or keep as proxy)
  /// 增加星尘 proxy
  void addStardust(int amount) {
    _db.addStardust(amount);
    _syncFromDb();
  }

  /// 增加卡包 proxy
  void addPacks(int amount) {
    _db.packCount += amount;
    _syncFromDb();
  }

  /// 刷新数据 (UI 会调用这个或使用定时器)
  void refresh() {
      _syncFromDb();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final db = MockDatabaseService();
  db.init();
  return UserNotifier(db);
});
