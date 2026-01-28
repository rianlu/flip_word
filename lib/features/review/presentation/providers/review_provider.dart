import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/models/models.dart';
import '../../../../core/services/mock_database_service.dart';
import 'package:flip_word/features/profile/presentation/providers/profile_provider.dart';

part 'review_provider.g.dart';

enum ReviewMode { flashcard, quiz }

class ReviewItem {
  final Word word;
  final ReviewMode mode;
  final List<String> options;

  ReviewItem({
    required this.word,
    required this.mode,
    this.options = const [],
  });
}

/// 复习会话状态
class ReviewSessionState {
  final List<ReviewItem> items;
  final int currentIndex;
  final bool isSessionComplete;

  const ReviewSessionState({
    required this.items,
    this.currentIndex = 0,
    this.isSessionComplete = false,
  });

  /// 获取当前项目
  ReviewItem? get currentItem {
    if (items.isEmpty || currentIndex >= items.length) return null;
    return items[currentIndex];
  }
  
  // Backward compatibility helper if needed, but better to use currentItem
  Word? get currentWord => currentItem?.word;

  /// 进度 (0.0 - 1.0)
  double get progress {
    if (items.isEmpty) return 0.0;
    return (currentIndex) / items.length;
  }

  /// 格式化进度文本 (e.g. "1/5")
  String get progressText {
    return '${currentIndex + 1}/${items.length}';
  }
  
  ReviewSessionState copyWith({
    List<ReviewItem>? items,
    int? currentIndex,
    bool? isSessionComplete,
  }) {
    return ReviewSessionState(
      items: items ?? this.items,
      currentIndex: currentIndex ?? this.currentIndex,
      isSessionComplete: isSessionComplete ?? this.isSessionComplete,
    );
  }
}

/// 复习会话 Provider
/// 管理复习流程逻辑
@riverpod
class ReviewSession extends _$ReviewSession {
  final _db = MockDatabaseService();

  @override
  Future<ReviewSessionState> build() async {
    // 确保初始化
    await _db.init();
    
    // 1. 获取复习单词
    final sessionWords = _db.getReviewSession();
    final allWords = _db.allWords; // Used for distractors
    
    // 2. 生成 Review Items (Mixed Mode)
    final items = _generateItems(sessionWords, allWords);
    
    // 3. 初始化状态
    return ReviewSessionState(items: items);
  }
  
  List<ReviewItem> _generateItems(List<Word> words, List<Word> pool) {
     final random = Random();
     return words.map((word) {
        // 50% chance for Quiz, but fallback to Flashcard if no definitions available
        bool useQuiz = random.nextBool();
        List<String> options = [];
        
        if (useQuiz) {
           final possibleDistractors = pool
               .where((w) => w.id != word.id && (w.definition?.isNotEmpty ?? false))
               .map((w) => w.definition!)
               .toList();
               
           if (possibleDistractors.length >= 3 && (word.definition?.isNotEmpty ?? false)) {
              possibleDistractors.shuffle(random);
              options = possibleDistractors.take(3).toList();
              options.add(word.definition!);
              options.shuffle(random);
           } else {
              useQuiz = false; // Not enough data for quiz
           }
        }
        
        return ReviewItem(
           word: word,
           mode: useQuiz ? ReviewMode.quiz : ReviewMode.flashcard,
           options: options
        );
     }).toList();
  }

  /// 评分当前卡片并移动到下一张
  /// [score] 1: Forgot, 2: Hard, 3: Good
  Future<void> gradeCard(int score) async {
    final currentState = state.value;
    if (currentState == null || currentState.isSessionComplete) return;

    final item = currentState.currentItem;
    if (item == null) return;
    
    // 假设：每次复习好评(3分)，奖励 5 星尘
    if (score == 3) {
        _db.addStardust(5);
        // 刷新 Profile UI
        ref.read(profileProvider.notifier).refresh();
    }
    
    // 2. 移动到下一张
    _nextCard();
  }

  void _nextCard() {
    state = AsyncValue.data(
      state.value!.copyWith(
        currentIndex: state.value!.currentIndex + 1,
        isSessionComplete: state.value!.currentIndex + 1 >= state.value!.items.length,
      ),
    );
  }
}
