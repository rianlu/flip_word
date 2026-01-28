import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/models.dart' as models;
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/cards/cards.dart';
import '../../../../core/services/sound_service.dart';
import '../providers/review_provider.dart';
import '../widgets/quiz_challenge_card.dart';

/// 复习页面 Scaffold
class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听复习状态
    final reviewState = ref.watch(reviewSessionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('今日复习'),
        centerTitle: true,
      ),
      body: reviewState.when(
        // 1. 加载中
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        
        // 2. 错误
        error: (err, stack) => Center(
          child: Text('出错了: $err'),
        ),
        
        // 3. 数据就绪
        data: (session) {
          // 如果会话已完成
          if (session.isSessionComplete) {
            return const _SessionCompleteView();
          }

          final currentItem = session.currentItem;
          if (currentItem == null) return const SizedBox();

          return Column(
            children: [
              // 顶部进度条
              LinearProgressIndicator(
                value: session.progress,
                backgroundColor: AppColors.rarityCommon.withOpacity(0.2),
                color: AppColors.primaryOrange,
                minHeight: 6,
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  session.progressText,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ),

              const Spacer(),

              // 卡片区域
              // 使用 ValueKey 确保切换单词时完全重置卡片状态
              Center(
                child: SizedBox(
                   width: 320,
                   height: 500, // Slightly taller to accommodate quiz grid
                   child: currentItem.mode == ReviewMode.quiz
                       ? QuizChallengeCard(
                           key: ValueKey('quiz_${currentItem.word.id}'),
                           word: currentItem.word,
                           options: currentItem.options,
                           onCorrect: () {
                             ref.read(reviewSessionProvider.notifier).gradeCard(3);
                           },
                         )
                       : _ReviewCardSection(
                           key: ValueKey('flash_${currentItem.word.id}'), 
                           word: currentItem.word,
                         ),
                ),
              ),

              const Spacer(),
            ],
          );
        },
      ),
    );
  }
}

/// 卡片交互区域（包含卡片和底部按钮）
/// 单独提取出来是为了管理"由于翻转而显示按钮"的局部状态
class _ReviewCardSection extends ConsumerStatefulWidget {
  final models.Word word; 

  const _ReviewCardSection({
    super.key,
    required this.word,
  });

  @override
  ConsumerState<_ReviewCardSection> createState() => _ReviewCardSectionState();
}

class _ReviewCardSectionState extends ConsumerState<_ReviewCardSection> {
  bool _showActions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 卡片
        Expanded(
          child: FlipCard(
            word: widget.word,
            onFlip: () {
              // 翻转时显示操作按钮
              if (!_showActions) {
                // 延迟一点显示，让用户先看背面
                Future.delayed(const Duration(milliseconds: 300), () {
                  if (mounted) {
                    setState(() {
                      _showActions = true;
                    });
                  }
                });
              }
            },
          ),
        ),

        const SizedBox(height: 32),

        // 底部操作栏 (固定高度，防止跳动)
        SizedBox(
          height: 80,
          child: AnimatedOpacity(
            opacity: _showActions ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: _showActions
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ReviewActionButton(
                        label: '忘记',
                        color: AppColors.error,
                        icon: Icons.close_rounded,
                        onTap: () => _handleGrade(1),
                      ),
                      _ReviewActionButton(
                        label: '模糊',
                        color: AppColors.warning,
                        icon: Icons.help_outline_rounded,
                        onTap: () => _handleGrade(2),
                      ),
                      _ReviewActionButton(
                        label: '记得',
                        color: AppColors.success,
                        icon: Icons.check_rounded,
                        onTap: () => _handleGrade(3),
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      '点击卡片查看答案',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  void _handleGrade(int score) {
    if (score >= 3) {
      SoundService().playSuccess();
    }
    // 调用 Provider 评分
    ref.read(reviewSessionProvider.notifier).gradeCard(score);
  }
}

/// 评分按钮组件
class _ReviewActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _ReviewActionButton({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color, width: 2),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/// 复习完成页面
class _SessionCompleteView extends StatelessWidget {
  const _SessionCompleteView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 80, color: AppColors.success),
          const SizedBox(height: 24),
          Text(
            '今日复习完成！',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Text(
            '你已完成了所有计划中的单词。',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () {
              // 返回首页
              Navigator.of(context).pop();
            },
            child: const Text('返回首页'),
          ),
        ],
      ),
    );
  }
}
