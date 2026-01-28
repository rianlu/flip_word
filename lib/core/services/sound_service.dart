import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'preferences_service.dart';

/// 游戏化音效与触感服务 (Sound & Haptics)
/// 负责管理应用内所有的音频播放和震动反馈
class SoundService {
  SoundService._();
  
  static final SoundService _instance = SoundService._();
  factory SoundService() => _instance;

  final AudioPlayer _player = AudioPlayer();

  // ===========================================================================
  // Settings Control
  // ===========================================================================

  final PreferencesService _prefs = PreferencesService();

  Future<void> toggleSound(bool enabled) async {
      await _prefs.setSoundEnabled(enabled);
  }

  Future<void> toggleHaptics(bool enabled) async {
      await _prefs.setHapticsEnabled(enabled);
  }

  bool get isSoundEnabled => _prefs.isSoundEnabled;
  bool get isHapticsEnabled => _prefs.isHapticsEnabled;

  // ===========================================================================
  // Core Methods
  // ===========================================================================

  /// 翻转卡片 (轻微点击感)
  Future<void> playFlip() async {
    if (isHapticsEnabled) await HapticFeedback.lightImpact();
    await _playSound('sounds/flip.ogg');
  }

  /// 答对/成功 (愉悦的提示音)
  Future<void> playSuccess() async {
    if (isHapticsEnabled) await HapticFeedback.mediumImpact();
    await _playSound('sounds/success.ogg');
  }

  /// 卡包晃动 (连续轻微震动)
  Future<void> playPackShake() async {
    if (isHapticsEnabled) await HapticFeedback.selectionClick();
    await _playSound('sounds/shake.ogg');
  }

  /// 开包/爆卡 (强烈震动 + 爆炸音效)
  Future<void> playPackOpen() async {
    if (isHapticsEnabled) await HapticFeedback.heavyImpact();
    await _playSound('sounds/open.ogg');
  }

  /// 获得星尘/购买成功 (魔法闪烁声)
  Future<void> playStardust() async {
    if (isHapticsEnabled) await HapticFeedback.mediumImpact();
    await _playSound('sounds/stardust.ogg');
  }
  
  // ===========================================================================
  // Internal Helper
  // ===========================================================================

  Future<void> _playSound(String assetPath) async {
    try {
      if (isSoundEnabled) {
        // 使用 source: AssetSource 注意 audioplayers ^6.0.0 写法
        // Stop previous sound to avoid overlap if needed, strict mode
        await _player.stop(); 
        await _player.play(AssetSource(assetPath));
      }
    } catch (e) {
      // 忽略音频播放错误 (例如文件不存在)
      print('⚠️ SoundService Error: $e');
    }
  }
}
