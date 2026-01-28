import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/task.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/task_provider.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Daily Goals'),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          // 1. 倒计时 Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            color: Colors.white,
            child: Row(
              children: [
                Icon(Icons.timer_outlined, color: Colors.grey[600], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Resets in 12h 30m', // Mock countdown
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),

          // 2. 任务列表
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: tasks.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _TaskItem(task: tasks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends ConsumerWidget {
  final Task task;

  const _TaskItem({required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // 左侧图标
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getTaskIcon(task.title),
              color: AppColors.primaryOrange,
            ),
          ),
          
          const SizedBox(width: 16),
          
          // 中间文本
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  task.description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                
                // 进度条（如果进行中）
                if (!task.isCompleted)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: task.progressPercent,
                          backgroundColor: Colors.grey[200],
                          color: AppColors.primaryOrange,
                          minHeight: 6,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${task.progress}/${task.target}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 10,
                        ),
                      ),
                    ],
                  )
                else
                  // 奖励显示
                  Row(
                    children: [
                      Icon(
                        task.rewardType == RewardType.pack 
                            ? Icons.inventory_2_outlined 
                            : Icons.diamond_outlined,
                        size: 14,
                        color: AppColors.primaryOrange,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '+${task.rewardAmount} ${task.rewardType == RewardType.pack ? "Pack" : "Stardust"}',
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          
          const SizedBox(width: 12),
          
          // 右侧按钮
          _buildActionButton(context, ref),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, WidgetRef ref) {
    if (task.isClaimed) {
      // 已领取
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.grey[400], size: 16),
            const SizedBox(width: 4),
            Text(
              'Done',
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      );
    } else if (task.isCompleted) {
      // 可领取
      return ElevatedButton(
        onPressed: () {
          ref.read(taskProvider.notifier).claimReward(task.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Received ${task.rewardAmount} ${task.rewardType == RewardType.pack ? "Packs" : "Stardust"}!'),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 1),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryOrange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          minimumSize: const Size(0, 32),
        ),
        child: const Text('Claim'),
      );
    } else {
      // 进行中 (Go 按钮)
      return OutlinedButton(
        onPressed: () {
          // 在实际应用中，这里应该跳转到相应页面
          // 这里我们为了测试，点击按钮暂时模拟进度+1
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Go complete this task!')));
          
          // FOR DEMO ONLY: 点击按钮模拟任务进度增加，方便测试
          ref.read(taskProvider.notifier).incrementProgress(task.id);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryOrange,
          side: const BorderSide(color: AppColors.primaryOrange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          minimumSize: const Size(0, 32),
        ),
        child: const Text('Go'), // 改为 'Go'，点击其实是模拟进度
      );
    }
  }

  IconData _getTaskIcon(String title) {
    if (title.contains('Login')) return Icons.login;
    if (title.contains('Review')) return Icons.school;
    if (title.contains('New')) return Icons.auto_awesome;
    return Icons.task_alt;
  }
}
