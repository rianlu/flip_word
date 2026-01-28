import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/word.dart';

/// 单词卡片 - 正面
/// 显示单词、音标、稀有度边框
class CardFront extends StatelessWidget {
  final Word word;

  const CardFront({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    // 获取稀有度颜色
    final rarityColor = word.rarity != null
        ? AppColors.getRarityColor(word.rarity!)
        : AppColors.rarityCommon;

    // 获取词性颜色（用于装饰）
    final posColor = word.partOfSpeech != null
        ? AppColors.getPartOfSpeechColor(word.partOfSpeech!)
        : AppColors.rarityCommon;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: rarityColor,
          width: 3, // 稀有度边框宽度
        ),
        boxShadow: [
          BoxShadow(
            color: rarityColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // 右上角稀有度标记
          Positioned(
            top: 12,
            right: 12,
            child: _RarityBadge(rarity: word.rarity ?? 'common'),
          ),

          // 左上角词性标签
          if (word.partOfSpeech != null)
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: posColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: posColor, width: 1),
                ),
                child: Text(
                  word.partOfSpeech!,
                  style: AppTextStyles.partOfSpeech(color: posColor),
                ),
              ),
            ),

          // 中央内容区域
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 单词本体（超大粗体）
                  Text(
                    word.text,
                    style: AppTextStyles.cardWord(color: posColor),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 16),

                  // 音标
                  if (word.phonetic != null) ...[
                    Text(
                      word.phonetic!,
                      style: AppTextStyles.phonetic(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),

          // 底部微光效果（稀有度越高越明显）
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    rarityColor.withOpacity(0.0),
                    rarityColor.withOpacity(_getRarityGlowIntensity(word.rarity)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 根据稀有度获取发光强度
  double _getRarityGlowIntensity(String? rarity) {
    switch (rarity?.toLowerCase()) {
      case 'legend':
        return 0.3;
      case 'epic':
        return 0.2;
      case 'rare':
        return 0.1;
      case 'common':
      default:
        return 0.05;
    }
  }
}

/// 稀有度徽章组件
class _RarityBadge extends StatelessWidget {
  final String rarity;

  const _RarityBadge({required this.rarity});

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getRarityColor(rarity);
    final rarityName = _getRarityName(rarity);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        rarityName,
        style: AppTextStyles.rarityBadge(),
      ),
    );
  }

  String _getRarityName(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        return '普通';
      case 'rare':
        return '稀有';
      case 'epic':
        return '史诗';
      case 'legend':
        return '传说';
      default:
        return '普通';
    }
  }
}
