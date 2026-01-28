import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/mock_database_service.dart';
import '../../../../data/models/models.dart';
import '../providers/binder_provider.dart';
import '../widgets/binder_card_item.dart';
import 'theme_collection_screen.dart';

class BinderScreen extends ConsumerWidget {
  const BinderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We access themes from MockDatabaseService directly for the list
    // And use BinderProvider for progress stats
    final db = MockDatabaseService();
    final themes = db.themes;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('我的图鉴', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: themes.length,
        separatorBuilder: (c, i) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
           final theme = themes[index];
           return _ThemeBinderCard(theme: theme);
        },
      ),
    );
  }
}

class _ThemeBinderCard extends ConsumerWidget {
  final ThemeModel theme;

  const _ThemeBinderCard({required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get progress from provider
    final binderState = ref.watch(binderProvider);
    
    // Default 0/0
    int collected = 0;
    int total = 0;
    
    // Safely calc progress
    if (binderState.hasValue) {
       final stats = ref.read(binderProvider.notifier).getThemeProgress(theme.id);
       collected = stats['collected']!;
       total = stats['total']!;
    }

    final progress = total > 0 ? collected / total : 0.0;
    
    // Color logic
    Color themeColor;
    try {
       themeColor = Color(int.parse(theme.color ?? '0xFF888888'));
    } catch (_) {
       themeColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
         Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => ThemeCollectionScreen(theme: theme)),
         );
      },
      child: Container(
         height: 80,
         decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
               BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
            ],
         ),
         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
         child: Row(
            children: [
               // Icon / Cover
               Container(
                  width: 56, height: 56,
                  decoration: BoxDecoration(
                     color: themeColor.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(theme.emoji ?? '📦', style: const TextStyle(fontSize: 28)),
               ),
               const SizedBox(width: 16),
               
               // Info
               Expanded(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                          theme.name ?? 'Theme',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                       ),
                       const SizedBox(height: 4),
                       Row(
                          children: [
                             Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                   color: Colors.grey[100],
                                   borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                   theme.category?.toUpperCase() ?? 'BASIC',
                                   style: const TextStyle(fontSize: 10, color: Colors.grey),
                                ),
                             ),
                             const Spacer(),
                             Text(
                                '$collected/$total',
                                style: TextStyle(
                                   fontWeight: FontWeight.bold, 
                                   color: (collected == total && total > 0) ? Colors.green : Colors.grey
                                ),
                             ),
                          ],
                       ),
                    ],
                 ),
               ),
               
               const SizedBox(width: 12),
               
               // Circular Progress
               SizedBox(
                  width: 32, height: 32,
                  child: CircularProgressIndicator(
                     value: progress,
                     backgroundColor: Colors.grey[200],
                     color: themeColor,
                     strokeWidth: 4,
                  ),
               ),
            ],
         ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? color;

  const _FilterChip({
    required this.label,
    this.isSelected = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final chipColor = isSelected 
        ? AppColors.primaryOrange 
        : (color ?? Colors.grey[200]);
    
    final textColor = isSelected 
        ? Colors.white 
        : (color != null ? color : Colors.grey[700]);

    // 如果是有颜色的未选中状态，保持背景淡色，文字深色
    final bgColor = isSelected 
        ? AppColors.primaryOrange 
        : (color != null ? color!.withOpacity(0.1) : Colors.grey[200]);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? null : Border.all(
          color: color?.withOpacity(0.5) ?? Colors.transparent,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : (color ?? Colors.black87),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
