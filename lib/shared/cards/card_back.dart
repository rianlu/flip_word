import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/word.dart';

/// 单词卡片 - 背面
/// 显示释义、例句、词形变化
class CardBack extends StatelessWidget {
  final Word word;

  const CardBack({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    // 获取稀有度颜色
    final rarityColor = word.rarity != null
        ? AppColors.getRarityColor(word.rarity!)
        : AppColors.rarityCommon;

    return Container(
      decoration: BoxDecoration(
        // 背面使用渐变背景
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            rarityColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rarityColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: rarityColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 顶部：单词拼写（小号）
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  word.text,
                  style: AppTextStyles.headlineLarge(
                    color: rarityColor,
                  ),
                ),
                // 词性标签
                if (word.partOfSpeech != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.getPartOfSpeechColor(word.partOfSpeech!)
                          .withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      word.partOfSpeech!,
                      style: AppTextStyles.partOfSpeech(
                        color: AppColors.getPartOfSpeechColor(
                          word.partOfSpeech!,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            // 音标
            if (word.phonetic != null) ...[
              Text(
                word.phonetic!,
                style: AppTextStyles.phonetic(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 16),
            ],

            const Divider(height: 32),

            // 释义部分
            if (word.definition != null) ...[
              Text(
                '释义',
                style: AppTextStyles.labelLarge(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                word.definition!,
                style: AppTextStyles.definition(
                  color: AppColors.textPrimaryLight,
                ),
              ),
              const SizedBox(height: 16),
            ],

            // 词形变化
            if (word.forms != null && word.forms!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                '词形变化',
                style: AppTextStyles.labelLarge(
                  color: AppColors.textSecondaryLight,
                ),
              ),
              const SizedBox(height: 8),
              _WordFormsDisplay(forms: word.forms!),
            ],

            const Spacer(),

            // 底部提示
            Center(
              child: Text(
                '点击翻转卡片',
                style: AppTextStyles.labelSmall(
                  color: AppColors.textSecondaryLight.withOpacity(0.6),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 词形变化显示组件
class _WordFormsDisplay extends StatelessWidget {
  final Map<String, dynamic> forms;

  const _WordFormsDisplay({required this.forms});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: forms.entries.map((entry) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.flipBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.flipBlue.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${_getFormLabel(entry.key)}: ',
                  style: AppTextStyles.labelSmall(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
                TextSpan(
                  text: entry.value.toString(),
                  style: AppTextStyles.labelMedium(
                    color: AppColors.flipBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  /// 将英文键名转为中文标签
  String _getFormLabel(String key) {
    switch (key.toLowerCase()) {
      case 'past':
        return '过去式';
      case 'past_participle':
        return '过去分词';
      case 'present_participle':
      case 'ing':
        return '现在分词';
      case 'plural':
        return '复数';
      case 'comparative':
        return '比较级';
      case 'superlative':
        return '最高级';
      case 'third_person':
        return '第三人称';
      default:
        return key;
    }
  }
}
