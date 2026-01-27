import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// FlipWord 应用文本样式系统
/// 使用 GoogleFonts 实现多语言字体支持
/// - 英文：Nunito (柔和圆润) / Quicksand (活力Q弹)
/// - 中文：Noto Sans SC (简洁现代)
class AppTextStyles {
  // 防止实例化
  AppTextStyles._();

  // ============================================
  // 字体家族 (Font Families)
  // ============================================
  
  /// 英文主字体 - Nunito (用于正文、释义)
  static TextStyle get _nunitoBase => GoogleFonts.nunito();
  
  /// 英文强调字体 - Quicksand (用于单词卡片、标题)
  static TextStyle get _quicksandBase => GoogleFonts.quicksand();
  
  /// 中文字体 - Noto Sans SC
  static TextStyle get _notoSansBase => GoogleFonts.notoSansSc();

  // ============================================
  // 显示级别文本 (Display Text) - 超大号标题
  // ============================================
  
  /// Display Large - 用于 Logo、启动页
  static TextStyle displayLarge({Color? color}) => _quicksandBase.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: color,
      );

  /// Display Medium - 用于页面主标题
  static TextStyle displayMedium({Color? color}) => _quicksandBase.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// Display Small - 用于次级标题
  static TextStyle displaySmall({Color? color}) => _quicksandBase.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ============================================
  // 标题文本 (Headline Text)
  // ============================================
  
  /// Headline Large - 卡片上的单词（超大）
  static TextStyle headlineLarge({Color? color}) => _quicksandBase.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// Headline Medium - 区块标题
  static TextStyle headlineMedium({Color? color}) => _nunitoBase.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: color,
      );

  /// Headline Small - 小标题
  static TextStyle headlineSmall({Color? color}) => _nunitoBase.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ============================================
  // 正文文本 (Body Text)
  // ============================================
  
  /// Body Large - 大号正文
  static TextStyle bodyLarge({Color? color}) => _nunitoBase.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: color,
      );

  /// Body Medium - 常规正文
  static TextStyle bodyMedium({Color? color}) => _nunitoBase.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: color,
      );

  /// Body Small - 小号正文
  static TextStyle bodySmall({Color? color}) => _nunitoBase.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: color,
      );

  // ============================================
  // 标签文本 (Label Text) - 按钮、标签
  // ============================================
  
  /// Label Large - 大型按钮文字
  static TextStyle labelLarge({Color? color}) => _quicksandBase.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        color: color,
      );

  /// Label Medium - 常规按钮文字
  static TextStyle labelMedium({Color? color}) => _nunitoBase.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: color,
      );

  /// Label Small - 小型标签
  static TextStyle labelSmall({Color? color}) => _nunitoBase.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        color: color,
      );

  // ============================================
  // 特殊用途文本 (Special Purpose)
  // ============================================
  
  /// 单词卡片 - 正面单词（超大粗体）
  static TextStyle cardWord({Color? color}) => _quicksandBase.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
        color: color,
      );

  /// 音标文本
  static TextStyle phonetic({Color? color}) => _nunitoBase.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: color ?? AppColors.textSecondaryLight,
      );

  /// 释义文本（中文）
  static TextStyle definition({Color? color}) => _notoSansBase.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.5,
        color: color,
      );

  /// 例句文本
  static TextStyle example({Color? color}) => _nunitoBase.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        height: 1.6,
        color: color ?? AppColors.textSecondaryLight,
      );

  /// 稀有度标签
  static TextStyle rarityBadge({Color? color}) => _quicksandBase.copyWith(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: color ?? Colors.white,
      );

  /// 星尘数量显示
  static TextStyle stardustAmount({Color? color}) => _quicksandBase.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.stardust,
      );

  /// 词性标签（如 n. v. adj.）
  static TextStyle partOfSpeech({Color? color}) => _nunitoBase.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.italic,
        color: color,
      );

  /// 导航栏文字
  static TextStyle navLabel({Color? color}) => _quicksandBase.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: color,
      );

  // ============================================
  // 中文专用样式
  // ============================================
  
  /// 中文标题
  static TextStyle chineseHeadline({Color? color}) => _notoSansBase.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: color,
      );

  /// 中文正文
  static TextStyle chineseBody({Color? color}) => _notoSansBase.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: color,
      );

  /// 中文按钮
  static TextStyle chineseButton({Color? color}) => _notoSansBase.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: color,
      );
}
