import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/task.dart';
import '../../../../core/services/mock_database_service.dart';

/// 任务状态 Provider
class TaskNotifier extends StateNotifier<List<Task>> {
  final MockDatabaseService _db;
  
  TaskNotifier(this._db) : super([]) {
    _initTasks();
  }

  void _initTasks() {
    // 从 DB 加载
    state = _db.tasks;
  }

  /// 更新进度 (Mock: 只更新内存中的 Task)
  void incrementProgress(String taskId, {int amount = 1}) {
    // 简单逻辑：更新 state 并同步回 DB（省略复杂逻辑）
     state = [
      for (final task in state)
        if (task.id == taskId && !task.isCompleted)
          task.copyWith(progress: (task.progress + amount).clamp(0, task.target))
        else
          task
    ];
    // 同步
    _db.tasks = state;
  }

  /// 领取奖励
  void claimReward(String taskId) {
    // 1. 调用 DB 完成任务逻辑
    final success = _db.completeTask(taskId);
    
    // 2. 如果成功，发放奖励并刷新
    if (success) {
        state = _db.tasks; // 重新获取最新状态
        
        // 找到该任务查奖励类型
        final task = state.firstWhere((t) => t.id == taskId);
        
        if (task.rewardType == RewardType.pack) {
            // packCount ++ (MockDB 需要加个 addPack方法，暂时忽略细节)
             print('Simulated adding pack');
        } else {
             _db.addStardust(task.rewardAmount);
        }
    }
  }
}

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
   final db = MockDatabaseService();
   // 确保先初始化
   db.init();
   return TaskNotifier(db);
});
