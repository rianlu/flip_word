import 'dart:math';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/models.dart';
import '../../data/models/task.dart'; // Explicit import for RewardType

/// 全局单例 Mock 数据库服务
/// 用于在不连接 Supabase 的情况下维持 App 的运行时状态
class MockDatabaseService {
  // 私有构造函数
  MockDatabaseService._internal();

  // 单例实例
  static final MockDatabaseService _instance = MockDatabaseService._internal();

  // 工厂构造函数返回单例
  factory MockDatabaseService() => _instance;

  // ---------------------------------------------------------------------------
  // In-Memory State (内存数据库)
  // ---------------------------------------------------------------------------

  late SharedPreferences _prefs;

  int stardust = 1250;
  int packCount = 5;
  int daysStreak = 5;
  
  // 模拟用户档案
  Profile currentUser = const Profile(
    id: 'mock_user_001',
    nickname: 'Little Explorer',
    stardust: 1250,
  );

  // 模拟单词库
  late List<UserWord> userWords = [];
  late List<Word> allWords = [];
  
  // 模拟主题库
  late List<ThemeModel> themes = [];

  // 模拟任务列表
  late List<Task> tasks = [];

  // 初始化标志
  bool _isInitialized = false;

  // 初始化 Mock 数据
  Future<void> init() async {
    if (_isInitialized) return;
    
    _prefs = await SharedPreferences.getInstance();

    // 1. Load Custom Themes
    try {
        final themesString = await rootBundle.loadString('assets/data/themes.json');
        final themesJson = json.decode(themesString) as List;
        themes = themesJson.map((t) => ThemeModel.fromJson(t)).toList();
        print('✅ Loaded ${themes.length} themes from themes.json');
    } catch (e) {
        print('❌ Error loading themes: $e');
        themes = [
            const ThemeModel(id: 'fallback_1', name: 'Fallback Theme', emoji: '⚠️', description: 'No data', category: 'Basic', color: '0xFF888888'),
        ];
    }

    // 2. Load Base Words
    try {
        final jsonString = await rootBundle.loadString('assets/data/initial_data.json');
        final data = json.decode(jsonString);

        // 1. 解析单词
        final wordsJson = data['words'] as List;
        allWords = wordsJson.map((w) => Word.fromJson(w)).toList();
        print('✅ Loaded ${allWords.length} base words');
        
    } catch (e) {
        print('❌ Error loading base words: $e');
        _initWordsFallback();
    }

    // 3. Load User Progress (Dynamic)
    if (_prefs.containsKey('storage_profile')) {
       _loadFromPrefs();
    } else {
       _initNewUserProgress();
    }
    
    _initTasks(); // Tasks reset daily in this simple version
    _syncProfile();

    _isInitialized = true;
    print('📦 MockDatbaseService initialized (Persistence Enabled)!');
  }
  
  // ---------------------------------------------------------------------------
  // Data Loading Logic
  // ---------------------------------------------------------------------------

  void _loadFromPrefs() {
      // Profile
      final profileStr = _prefs.getString('storage_profile');
      if (profileStr != null) {
          currentUser = Profile.fromJson(jsonDecode(profileStr));
          stardust = currentUser.stardust;
          print('📂 Creating User: Loaded Profile ${currentUser.nickname}');
      }

      // UserWords
      final userWordsStr = _prefs.getString('storage_user_words');
      if (userWordsStr != null) {
          final List content = jsonDecode(userWordsStr);
          userWords = content.map((e) => UserWord.fromJson(e)).toList();
          print('📂 Creating User: Loaded ${userWords.length} user word states');
      } else {
        // Fallback if profile exists but words don't (rare)
        _initNewUserProgress();
      }
      
      // Packs & Streak (Simple keys)
      packCount = _prefs.getInt('storage_pack_count') ?? 5;
      if (packCount == 0) packCount = 5; // Force refill for testing if empty
      daysStreak = _prefs.getInt('storage_streak') ?? 1;
  }

  void _initNewUserProgress() {
       print('🆕 Creating New User Progress');
        // 初始化用户进度 (默认解锁前 3 个单词作为初始集合)
        userWords = allWords.asMap().entries.map((entry) {
          final i = entry.key;
          final w = entry.value;
          final isUnlocked = i < 3; 
          
          return UserWord(
            userId: 'mock_user_001',
            wordId: w.id,
            isCollected: isUnlocked,
            starLevel: isUnlocked ? 1 : 0, 
            nextReviewAt: isUnlocked ? DateTime.now() : null,
          );
        }).toList();

        packCount = 10; // Give free packs for testing!
        
        saveProgress();
        saveProfile();
  }
  
  // ---------------------------------------------------------------------------
  // Persistence Methods
  // ---------------------------------------------------------------------------

  Future<void> saveProfile() async {
      await _prefs.setString('storage_profile', jsonEncode(currentUser.toJson()));
      await _prefs.setInt('storage_pack_count', packCount);
      await _prefs.setInt('storage_streak', daysStreak);
      print('💾 Profile Saved: Stardust=$stardust, Packs=$packCount');
  }

  // Force reset helper (optional, for debugging)
  Future<void> clearAllData() async {
     await _prefs.clear();
     _isInitialized = false;
     print('🧹 All data cleared!');
     init();
  }

  Future<void> saveProgress() async {
      await _prefs.setString('storage_user_words', jsonEncode(userWords.map((e) => e.toJson()).toList()));
      print('💾 Progress Saved: ${userWords.where((x) => x.isCollected).length} collected');
  }

  Future<void> _loadInitialData() async {
      // Deprecated, logic moved to init()
  }

  void _initWordsFallback() {
    // 构造 20 个基础单词
    allWords = List.generate(20, (index) {
      return Word(
        id: index + 1, // ID 从 1 开始 (int)
        text: index % 2 == 0 ? 'Apple ${index + 1}' : 'Run ${index + 1}',
        definition: index % 2 == 0 ? '一种水果' : '一种运动',
        phonetic: '/test/',
        partOfSpeech: index % 2 == 0 ? 'n.' : 'v.',
        rarity: ['common', 'rare', 'epic'] [index % 3], 
        themeId: 'theme_fruit',
      ); 
    });

    // 构造用户单词状态
    userWords = allWords.asMap().entries.map((entry) {
      final i = entry.key;
      final w = entry.value;
      return UserWord(
        userId: 'mock_user_001', // 必填字段
        wordId: w.id,
        isCollected: i < 5, // 前5个默认解锁
        starLevel: 1,
      );
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // Core Logic Methods
  // ---------------------------------------------------------------------------

  /// 1. 星尘系统
  
  // 增加星尘
  void addStardust(int amount) {
    stardust += amount;
    _syncProfile();
    saveProfile();
  }

  // 消费星尘
  bool consumeStardust(int amount) {
    if (stardust >= amount) {
      stardust -= amount;
      _syncProfile();
      saveProfile();
      return true;
    }
    return false;
  }
  
  // 消费卡包
  bool consumePack() {
      if (packCount > 0) {
          packCount --;
          saveProfile(); // Persist pack count
          return true;
      }
      return false;
  }

  /// 2. 单词系统

  // 解锁单词 (点亮图鉴)
  void unlockWord(int wordId) {
    final index = userWords.indexWhere((uw) => uw.wordId == wordId);
    if (index != -1) {
      final current = userWords[index];
      if (!current.isCollected) {
        userWords[index] = current.copyWith(isCollected: true);
        print('🔓 Unlocked word: $wordId');
        saveProgress();
      }
    }
  }

  // 获取复习会话 (返回 5 个随机单词)
  List<Word> getReviewSession() {
    final random = Random();
    // 简单打乱返回前5个
    final shuffled = List<Word>.from(allWords)..shuffle(random);
    return shuffled.take(5).toList();
  }
  
  // 获取统计数据：已收集单词数
  int getWordsCollectedCount() {
      return userWords.where((w) => w.isCollected).length;
  }

  /// 3. 任务系统

  // 完成任务 (领取奖励)
  bool completeTask(String taskId) {
    final index = tasks.indexWhere((t) => t.id == taskId);
    if (index != -1) {
      final task = tasks[index];
      if (!task.isCompleted) {
        // 更新任务状态 (这里假设 progress 直接设为 target 即完成)
        tasks[index] = task.copyWith(progress: task.target);
        
        return true;
      }
    }
    return false;
  }
  
  // ---------------------------------------------------------------------------
  // Internal Helpers
  // ---------------------------------------------------------------------------

  void _syncProfile() {
    currentUser = currentUser.copyWith(stardust: stardust);
  }

  // Old _initWords is replaced by _initWordsFallback and called in catch block

  void _initTasks() {
    tasks = [
      const Task(
          id: '1', 
          title: 'Review 10 Words', 
          description: 'Review 10 words to get a pack',
          progress: 0, 
          target: 10, 
          rewardType: RewardType.pack, 
          rewardAmount: 1
      ),
      const Task(
          id: '2', 
          title: 'Collect 3 New Cards', 
          description: 'Get new cards from packs',
          progress: 1, 
          target: 3, 
          rewardType: RewardType.stardust, 
          rewardAmount: 50
      ),
      const Task(
          id: '3', 
          title: 'Perfect Flip 5 Times', 
          description: 'Flip cards perfectly',
          progress: 5, 
          target: 5, 
          rewardType: RewardType.stardust, 
          rewardAmount: 30
      ), // isCompleted calculated by progress >= target
    ];
  }
}
