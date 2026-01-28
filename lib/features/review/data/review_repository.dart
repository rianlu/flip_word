import '../../../data/models/models.dart';

/// 复习仓储
/// 负责获取和更新复习数据
class ReviewRepository {
  // 单例模式（可选，方便 Mock 和测试）
  static final ReviewRepository _instance = ReviewRepository._();
  static ReviewRepository get instance => _instance;
  ReviewRepository._();

  /// 获取复习会话数据
  /// 
  /// 暂时返回 Mock 数据
  Future<List<Word>> fetchReviewSession() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));

    return [
      const Word(
        id: 1,
        text: 'Apple',
        phonetic: '/ˈæpəl/',
        definition: 'n. 苹果',
        partOfSpeech: 'n.',
        rarity: 'common',
        themeId: 'theme_fruit',
        forms: {'plural': 'apples'},
      ),
      const Word(
        id: 2,
        text: 'Banana',
        phonetic: '/bəˈnænə/',
        definition: 'n. 香蕉',
        partOfSpeech: 'n.',
        rarity: 'common',
        themeId: 'theme_fruit',
        forms: {'plural': 'bananas'},
      ),
      const Word(
        id: 3,
        text: 'Cat',
        phonetic: '/kæt/',
        definition: 'n. 猫',
        partOfSpeech: 'n.',
        rarity: 'rare',
        themeId: 'theme_animals',
        forms: {'plural': 'cats'},
      ),
      const Word(
        id: 4,
        text: 'Dog',
        phonetic: '/dɔːɡ/',
        definition: 'n. 狗',
        partOfSpeech: 'n.',
        rarity: 'rare',
        themeId: 'theme_animals',
        forms: {'plural': 'dogs'},
      ),
      const Word(
        id: 5,
        text: 'Elephant',
        phonetic: '/ˈelɪfənt/',
        definition: 'n. 大象',
        partOfSpeech: 'n.',
        rarity: 'epic',
        themeId: 'theme_animals',
        forms: {'plural': 'elephants'},
      ),
    ];
  }

  /// 提交卡片评分
  /// 
  /// [wordId] 单词 ID
  /// [score] 评分 (1: Forgot, 2: Hard, 3: Good)
  Future<void> submitReview({required int wordId, required int score}) async {
    // 模拟网络请求
    await Future.delayed(const Duration(milliseconds: 300));
    print('📝 Submitted review for Word ID: $wordId, Score: $score');
  }
}
