import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/models.dart';
import '../../../../core/services/mock_database_service.dart';
import 'package:flip_word/features/profile/presentation/providers/profile_provider.dart';

/// 抽卡状态
sealed class PackState {
  const PackState();
}

class PackInitial extends PackState {
  const PackInitial();
}

class PackOpening extends PackState {
  const PackOpening();
}

class PackRevealed extends PackState {
  final List<Word> cards;
  const PackRevealed(this.cards);
}

/// 抽卡 Provider
class PackNotifier extends StateNotifier<PackState> {
  final MockDatabaseService _db;
  final Ref ref;

  PackNotifier(this._db, this.ref) : super(const PackInitial());
  
  final _random = Random();
  String _selectedThemeId = 'theme_fruit'; // Default

  void selectTheme(String themeId) {
      _selectedThemeId = themeId;
  }

  /// 开包 (使用选定主题)
  Future<void> openPack() async {

    // 检查是否有包
    if (!_db.consumePack()) {
       print('❌ Open Pack Failed: No packs available.');
       return;
    }
    
    // 1. 切换到开包中状态
    state = const PackOpening();

    // 2. 模拟网络请求和动画延迟 (Reduced to 500ms for responsiveness)
    await Future.delayed(const Duration(milliseconds: 500));

    // 3. 生成随机卡片
    // Filter words by theme
    final themeWords = _db.allWords.where((w) => w.themeId == _selectedThemeId).toList();
    
    // Fallback if theme has no words
    final pool = themeWords.isNotEmpty ? themeWords : _db.allWords; 
    
    final List<Word> newCards = List.generate(5, (index) {
        // 随机取词
       final template = pool[_random.nextInt(pool.length)];
       
       // 随机稀有度逻辑...
       final rarityRoll = _random.nextDouble();
	      String rarity;
	      if (rarityRoll < 0.6) rarity = 'common';
	      else if (rarityRoll < 0.9) rarity = 'rare';
	      else if (rarityRoll < 0.98) rarity = 'epic';
	      else rarity = 'legend';

        return template.copyWith(
            id: DateTime.now().millisecondsSinceEpoch + index,
            rarity: rarity,
        );
    });

    // 4. 处理数据：解锁图鉴并计算星尘
    int totalDust = 0;
    for (var card in newCards) {
        final originalWordId = _db.allWords.firstWhere((w) => w.text == card.text).id; 
        
        // Check if collected
        bool isAlreadyCollected = false;
        final index = _db.userWords.indexWhere((uw) => uw.wordId == originalWordId);
        if (index != -1 && _db.userWords[index].isCollected) {
            isAlreadyCollected = true;
        }

        if (isAlreadyCollected) {
             totalDust += 10;
        } else {
             _db.unlockWord(originalWordId);
        }
    }
    
    if (totalDust > 0) {
        _db.addStardust(totalDust);
        // 通知 Profile 更新
        ref.read(profileProvider.notifier).refresh();
    }

    // 5. 展示结果
    state = PackRevealed(newCards);
  }

  /// 重置状态（用于再次开包）
  void reset() {
    state = const PackInitial();
  }
}

/// 全局 Provider 定义
final packProvider = StateNotifierProvider<PackNotifier, PackState>((ref) {
  final db = MockDatabaseService();
  return PackNotifier(db, ref);
});
