import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// FlipWord Consistent Design System - Typography
/// Enforces hierarchy: h1, h2, h3, body, caption
class AppTextStyles {
  AppTextStyles._();

  // ===========================================================================
  // Base Fonts
  // ===========================================================================
  
  // English: Nunito (Rounded, Friendly)
  static TextStyle get _fontPrimary => GoogleFonts.nunito();
  
  // Chinese: Noto Sans SC
  static TextStyle get _fontChinese => GoogleFonts.notoSansSc();

  // ===========================================================================
  // Hierarchy
  // ===========================================================================

  /// H1: Big Titles (Page Headers, Hero Text)
  /// Size: 32, Weight: Bold
  static TextStyle get h1 => _fontPrimary.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  /// H2: Section Titles (Card Titles, Section Headers)
  /// Size: 24, Weight: SemiBold
  static TextStyle get h2 => _fontPrimary.copyWith(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: 0,
  );

  /// H3: Subtitles (Small Headers)
  /// Size: 18, Weight: Bold
  static TextStyle get h3 => _fontPrimary.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Body: Standard Reading Text
  /// Size: 16, Weight: Normal
  static TextStyle get body => _fontPrimary.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5, // Better readability
  );
  
  /// Body Small: Dense information
  /// Size: 14, Weight: Normal
  static TextStyle get bodySmall => _fontPrimary.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  /// Caption: Tiny details, timestamps, badges
  /// Size: 12, Weight: SemiBold
  static TextStyle get caption => _fontPrimary.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
    letterSpacing: 0.5,
  );

  /// Button: Text inside buttons
  /// Size: 16, Weight: Bold
  static TextStyle get button => _fontPrimary.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textInverse, // Usually white on primary
    letterSpacing: 0.5,
  );

  // ===========================================================================
  // Game Specific Styles (Methods for flexibility & compatibility)
  // ===========================================================================

  /// Card Front Word
  static TextStyle cardWord({Color? color}) => _fontPrimary.copyWith(
    fontSize: 40,
    fontWeight: FontWeight.w800,
    color: color ?? AppColors.textPrimary,
  );
  
  /// Card Definition (Chinese)
  static TextStyle definition({Color? color}) => _fontChinese.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: color ?? AppColors.textPrimary,
    height: 1.6,
  );

  /// Stardust Counter
  static TextStyle stardust({Color? color}) => _fontPrimary.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: color ?? AppColors.stardust,
  );
  
  // ===========================================================================
  // Compatibility Layer (Deprecated)
  // ===========================================================================
  
  static TextStyle headlineLarge({Color? color}) => h1.copyWith(color: color);
  static TextStyle headlineMedium({Color? color}) => h2.copyWith(color: color);
  static TextStyle headlineSmall({Color? color}) => h3.copyWith(color: color);
  
  static TextStyle bodyLarge({Color? color}) => body.copyWith(fontSize: 18, color: color);
  static TextStyle bodyMedium({Color? color}) => body.copyWith(color: color);
  // static TextStyle bodySmall({Color? color}) => bodySmall.copyWith(color: color); // conflict name
  
  static TextStyle labelLarge({Color? color}) => button.copyWith(color: color);
  static TextStyle labelMedium({Color? color}) => caption.copyWith(fontSize: 14, color: color);
  static TextStyle labelSmall({Color? color}) => caption.copyWith(fontSize: 11, color: color);
  
  static TextStyle partOfSpeech({Color? color}) => caption.copyWith(color: color, fontStyle: FontStyle.italic);
  static TextStyle rarityBadge({Color? color}) => caption.copyWith(color: color, fontWeight: FontWeight.bold);
  static TextStyle phonetic({Color? color}) => bodySmall.copyWith(color: color, fontStyle: FontStyle.italic);
  static TextStyle navLabel({Color? color}) => caption.copyWith(color: color);
  
  // Chinese compat
  static TextStyle chineseHeadline({Color? color}) => _fontChinese.copyWith(fontSize: 24, fontWeight: FontWeight.bold, color: color);
  static TextStyle chineseBody({Color? color}) => _fontChinese.copyWith(fontSize: 16, color: color);
}
