import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:flip_word/features/review/presentation/screens/review_screen.dart';
import 'package:flip_word/features/pack_opening/presentation/screens/pack_opening_screen.dart';
import 'package:flip_word/features/pack_opening/presentation/screens/pack_selection_screen.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听用户数据
    final userState = ref.watch(userProvider);
    
    // TODO: 在这里预加载任务数据，或者依赖 MainScreen 来做
    // 这里为了演示，我们假设 TaskProvider 已经被初始化
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // 1. 顶部状态栏
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 连续打卡
                  Row(
                    children: [
                      const Icon(Icons.local_fire_department_rounded, 
                        color: AppColors.primaryOrange, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        'Day ${userState.streakDays}', // 动态数据
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  // 星尘数量
                  Row(
                    children: [
                      const Icon(Icons.diamond_rounded, 
                        color: AppColors.flipBlue, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        '${userState.stardust} Stardust', // 动态数据
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),

            // 2. 核心行动区：复习入口 (Hero Card)
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ReviewScreen()),
                ).then((_) {
                  // 返回时刷新数据
                   ref.read(userProvider.notifier).refresh();
                });
              },
              child: Container(
                width: 300,
                height: 420,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFF9966), // 橙色渐变
                      Color(0xFFFF5E62),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryOrange.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // 装饰性背景图案
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Icon(
                        Icons.school_rounded,
                        size: 200,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    
                    // 内容
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'DAILY REVIEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            '5 Words',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w800,
                              height: 1,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ready to spark?',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Center(
                              child: Text(
                                'START',
                                style: TextStyle(
                                  color: AppColors.primaryOrange,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const Spacer(),

            // 3. 卡包入口 (Pack Slot)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PackSelectionScreen(),
                    ),
                  ).then((_) {
                      ref.read(userProvider.notifier).refresh();
                  });
                },
                child: Container(
                  height: 100,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                    ),
                  ),
                  child: Row(
                    children: [
                      // 卡包图标占位
                      Container(
                        width: 60,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4AC29A), Color(0xFFBDFFF3)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.inventory_2_rounded, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Open Pack',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            '${userState.availablePacks} Packs available',
                            style: TextStyle(
                              color: userState.availablePacks > 0 
                                  ? AppColors.primaryOrange 
                                  : Colors.grey,
                              fontSize: 12,
                              fontWeight: userState.availablePacks > 0 
                                  ? FontWeight.bold 
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
