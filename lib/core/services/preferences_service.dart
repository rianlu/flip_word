import 'package:shared_preferences/shared_preferences.dart';

/// 本地偏好设置服务
/// 管理轻量级配置数据（如首次启动标志、音效开关等）
class PreferencesService {
  PreferencesService._();
  
  static final PreferencesService _instance = PreferencesService._();
  factory PreferencesService() => _instance;

  late SharedPreferences _prefs;
  bool _isInitialized = false;

  // Keys
  static const String _keyIsFirstTime = 'is_first_time';
  static const String _keySoundEnabled = 'sound_enabled';

  /// 初始化服务 (需要在 main.dart 中调用)
  Future<void> init() async {
    if (_isInitialized) return;
    _prefs = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  // ===========================================================================
  // Is First Time (Onboarding)
  // ===========================================================================

  /// 是否首次启动
  bool get isFirstTime => _prefs.getBool(_keyIsFirstTime) ?? true;

  /// 完成引导流程
  Future<void> completeOnboarding() async {
    await _prefs.setBool(_keyIsFirstTime, false);
  }
  
  // ===========================================================================
  // Settings (Sound)
  // ===========================================================================

  bool get isSoundEnabled => _prefs.getBool(_keySoundEnabled) ?? true;
  
  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool(_keySoundEnabled, enabled);
  }

  static const String _keyHapticsEnabled = 'haptics_enabled';

  bool get isHapticsEnabled => _prefs.getBool(_keyHapticsEnabled) ?? true;

  Future<void> setHapticsEnabled(bool enabled) async {
    await _prefs.setBool(_keyHapticsEnabled, enabled);
  }
}
