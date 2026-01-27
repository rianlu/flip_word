import 'package:flutter/material.dart';

/// FlipWord 应用颜色系统
/// 基于文档二：UI/UX 设计规范 - "Vibrant TCG" 风格
class AppColors {
  // 防止实例化
  AppColors._();

  // ============================================
  // 品牌主色 (Primary Colors)
  // ============================================
  
  /// 活力橙 - Logo/主按钮/强调元素
  static const Color primaryOrange = Color(0xFFFF6B35);
  
  /// 翻转蓝 - 辅助色/链接/次要按钮
  static const Color flipBlue = Color(0xFF4A90E2);

  // ============================================
  // 词性色 (Part of Speech Colors) - 视觉核心
  // ============================================
  
  /// 动词 - 红色系
  static const Color verbRed = Color(0xFFE74C3C);
  
  /// 名词 - 蓝色系
  static const Color nounBlue = Color(0xFF3498DB);
  
  /// 形容词 - 绿色系
  static const Color adjGreen = Color(0xFF2ECC71);
  
  /// 副词 - 黄色系
  static const Color advYellow = Color(0xFFF39C12);

  // ============================================
  // 稀有度色 (Rarity Colors) - 光效/边框
  // ============================================
  
  /// 普通 - 灰白色
  static const Color rarityCommon = Color(0xFFBDC3C7);
  
  /// 稀有 - 蓝光
  static const Color rarityRare = Color(0xFF3498DB);
  
  /// 史诗 - 紫光+粒子效果
  static const Color rarityEpic = Color(0xFF9B59B6);
  
  /// 传说 - 金色全屏光效
  static const Color rarityLegend = Color(0xFFF39C12);

  // ============================================
  // 经济系统色 (Economy Colors)
  // ============================================
  
  /// 星尘 - 金色粉末
  static const Color stardust = Color(0xFFFFD700);

  // ============================================
  // 中性色 (Neutral Colors) - 背景/文字
  // ============================================
  
  /// 深色背景（用于深色模式）
  static const Color backgroundDark = Color(0xFF1A1A2E);
  
  /// 浅色背景（用于浅色模式）
  static const Color backgroundLight = Color(0xFFF5F5F5);
  
  /// 卡片背景（浅色模式）
  static const Color cardLight = Color(0xFFFFFFFF);
  
  /// 卡片背景（深色模式）
  static const Color cardDark = Color(0xFF16213E);
  
  /// 主文本（深色模式）
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  
  /// 主文本（浅色模式）
  static const Color textPrimaryLight = Color(0xFF1A1A2E);
  
  /// 次要文本（深色模式）
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  
  /// 次要文本（浅色模式）
  static const Color textSecondaryLight = Color(0xFF6B6B6B);

  // ============================================
  // 功能色 (Functional Colors)
  // ============================================
  
  /// 成功 - 绿色
  static const Color success = Color(0xFF27AE60);
  
  /// 警告 - 橙色
  static const Color warning = Color(0xFFE67E22);
  
  /// 错误 - 红色
  static const Color error = Color(0xFFE74C3C);
  
  /// 信息 - 蓝色
  static const Color info = Color(0xFF3498DB);

  // ============================================
  // 辅助方法 (Helper Methods)
  // ============================================
  
  /// 根据词性获取对应颜色
  static Color getPartOfSpeechColor(String pos) {
    switch (pos.toLowerCase()) {
      case 'v':
      case 'verb':
      case 'v.':
        return verbRed;
      case 'n':
      case 'noun':
      case 'n.':
        return nounBlue;
      case 'adj':
      case 'adjective':
      case 'adj.':
        return adjGreen;
      case 'adv':
      case 'adverb':
      case 'adv.':
        return advYellow;
      default:
        return rarityCommon; // 默认灰色
    }
  }

  /// 根据稀有度获取对应颜色
  static Color getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common':
        return rarityCommon;
      case 'rare':
        return rarityRare;
      case 'epic':
        return rarityEpic;
      case 'legend':
      case 'legendary':
        return rarityLegend;
      default:
        return rarityCommon;
    }
  }

  /// 根据稀有度获取发光效果颜色（带透明度）
  static Color getRarityGlowColor(String rarity) {
    return getRarityColor(rarity).withOpacity(0.4);
  }
}
