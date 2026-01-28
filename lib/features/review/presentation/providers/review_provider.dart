import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../data/models/models.dart';
import '../../../../core/services/mock_database_service.dart';
import 'package:flip_word/features/profile/presentation/providers/profile_provider.dart';

part 'review_provider.g.dart';

/// 复习会话状态
class ReviewSessionState {
  final List<Word> words;
  final int currentIndex;
  final bool isSessionComplete;

  const ReviewSessionState({
    required this.words,
    this.currentIndex = 0,
    this.isSessionComplete = false,
  });

  /// 获取当前单词
  Word? get currentWord {
    if (words.isEmpty || currentIndex >= words.length) return null;
    return words[currentIndex];
  }

  /// 进度 (0.0 - 1.0)
  double get progress {
    if (words.isEmpty) return 0.0;
    return (currentIndex) / words.length;
  }

  /// 格式化进度文本 (e.g. "1/5")
  String get progressText {
    return '${currentIndex + 1}/${words.length}';
  }
  
  ReviewSessionState copyWith({
    List<Word>? words,
    int? currentIndex,
    bool? isSessionComplete,
  }) {
    return ReviewSessionState(
      words: words ?? this.words,
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
    _db.init();
    
    // 1. 获取复习数据
    final words = _db.getReviewSession();
    
    // 2. 初始化状态
    return ReviewSessionState(words: words);
  }

  /// 评分当前卡片并移动到下一张
  /// [score] 1: Forgot, 2: Hard, 3: Good
  Future<void> gradeCard(int score) async {
    final currentState = state.value;
    if (currentState == null || currentState.isSessionComplete) return;

    final currentWord = currentState.currentWord;
    if (currentWord == null) return;
    
    // 假设：每次复习好评(3分)，奖励 5 星尘
    if (score == 3) {
        _db.addStardust(5);
        // 刷新 Profile UI
        // 注意：build中 ref 可用，这里用 ref.read
        ref.read(profileProvider.notifier).refresh();
    }
    
    // 2. 移动到下一张
    _nextCard();
  }

  void _nextCard() {
    state = AsyncValue.data(
      state.value!.copyWith(
        currentIndex: state.value!.currentIndex + 1,
        isSessionComplete: state.value!.currentIndex + 1 >= state.value!.words.length,
      ),
    );
  }
}
