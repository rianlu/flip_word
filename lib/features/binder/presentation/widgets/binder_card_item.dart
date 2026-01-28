import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/models.dart';
import '../../../../shared/cards/cards.dart';

class BinderCardItem extends StatelessWidget {
  final Word word;
  final bool isCollected;

  const BinderCardItem({
    super.key,
    required this.word,
    required this.isCollected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isCollected) {
          _showCardDetail(context);
        } else {
          // 未解锁提示
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('该卡片尚未解锁，快去复习或开包吧！'),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      child: isCollected ? _buildCollectedCard() : _buildLockedCard(),
    );
  }

  /// 构建已收集的卡片（彩色）
  Widget _buildCollectedCard() {
    final rarity = word.rarity ?? 'common';
    final partOfSpeech = word.partOfSpeech ?? '';
    final rarityColor = AppColors.getRarityColor(rarity);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: rarityColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: rarityColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 单词
          Text(
            word.text,
            style: AppTextStyles.cardWord().copyWith(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          // 音标
          if (word.phonetic != null)
            Text(
              word.phonetic!,
              style: AppTextStyles.phonetic().copyWith(fontSize: 12),
            ),
          const SizedBox(height: 8),
          // 词性标签
          if (partOfSpeech.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.getPartOfSpeechColor(partOfSpeech).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              partOfSpeech,
              style: TextStyle(
                color: AppColors.getPartOfSpeechColor(partOfSpeech),
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建未收集的卡片（锁定状态）
  Widget _buildLockedCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 模糊的文字（隐约可见）
          Opacity(
            opacity: 0.1,
            child: Text(
              word.text,
              style: AppTextStyles.cardWord().copyWith(fontSize: 18, color: Colors.black),
            ),
          ),
          // 锁图标
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.lock_rounded, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }

  /// 显示卡片详情弹窗
  void _showCardDetail(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 320,
          height: 460, // 稍微高一点以容纳FlipCard
          child: FlipCard(word: word),
        ),
      ),
    );
  }
}
