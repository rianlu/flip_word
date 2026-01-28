import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../data/models/models.dart';
import '../../../../core/services/mock_database_service.dart';

/// 图鉴条目（用于 UI 展示）
class BinderEntry {
  final Word word;
  final bool isCollected;

  BinderEntry({required this.word, required this.isCollected});
}

/// 图鉴 Provider
class BinderNotifier extends StateNotifier<AsyncValue<List<BinderEntry>>> {
  BinderNotifier() : super(const AsyncValue.loading()) {
    loadBinderData();
  }

  final _db = MockDatabaseService();

  Future<void> loadBinderData() async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 300));

    // 使用 MockDatabaseService 数据
    final allWords = _db.allWords;
    final userWords = _db.userWords;

    final List<BinderEntry> entries = allWords.map((word) {
       final isCollected = userWords.any((uw) => uw.wordId == word.id && uw.isCollected);
       return BinderEntry(word: word, isCollected: isCollected);
    }).toList();

    state = AsyncValue.data(entries);
  }

  // 辅助方法：获取主题进度
  Map<String, int> getThemeProgress(String themeId) {
     final entries = state.value ?? [];
     final themeEntries = entries.where((e) => e.word.themeId == themeId).toList();
     final collected = themeEntries.where((e) => e.isCollected).length;
     final total = themeEntries.length;
     return {'collected': collected, 'total': total};
  }
}

final binderProvider = StateNotifierProvider<BinderNotifier, AsyncValue<List<BinderEntry>>>((ref) {
  return BinderNotifier();
});
