import 'package:flutter/material.dart';

/// FlipWord Consisten Design System - Colors
/// Based on @ui_design_spec.md
class AppColors {
  AppColors._();

  // ===========================================================================
  // Core Palette (Semantic)
  // ===========================================================================
  
  /// Primary: Vitality Orange (Main Actions, Brand)
  static const Color primary = Color(0xFFFF6B35);

  /// Secondary: Flip Blue (Accents, Links, Secondary Actions)
  static const Color secondary = Color(0xFF4A90E2);

  /// Background: Off-white (App Background)
  static const Color background = Color(0xFFF5F7FA);

  /// Surface: Pure White (Cards, Sheets)
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Surface Variant: Subtle grey for grouping
  static const Color surfaceVariant = Color(0xFFF0F2F5);

  // ===========================================================================
  // Rarity Colors (Game Mechanics)
  // ===========================================================================

  static const Color rarityCommon = Color(0xFFBDC3C7); // Grey
  static const Color rarityRare = Color(0xFF3498DB);   // Blue
  static const Color rarityEpic = Color(0xFF9B59B6);   // Purple
  static const Color rarityLegend = Color(0xFFF39C12); // Gold

  // ===========================================================================
  // Text Colors
  // ===========================================================================

  /// Primary Text (Headlines, Important/Body)
  static const Color textPrimary = Color(0xFF2C3E50);

  /// Secondary Text (Captions, Subtitles)
  static const Color textSecondary = Color(0xFF7F8C8D);
  
  /// Tertiary Text (Disabled, Hints)
  static const Color textTertiary = Color(0xFFBDC3C7);
  
  /// Inverse Text (Text on Primary)
  static const Color textInverse = Colors.white;

  // ===========================================================================
  // Functional Colors
  // ===========================================================================
  
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF1C40F);
  static const Color error = Color(0xFFE74C3C);
  static const Color stardust = Color(0xFFFFD700);

  // ===========================================================================
  // Part of Speech Colors
  // ===========================================================================
  
  static const Color posVerb = Color(0xFFE74C3C);
  static const Color posNoun = Color(0xFF3498DB);
  static const Color posAdj = Color(0xFF2ECC71);
  static const Color posAdv = Color(0xFFF39C12);

  // Helper for Rarity
  static Color getRarityColor(String rarity) {
    switch (rarity.toLowerCase()) {
      case 'common': return rarityCommon;
      case 'rare': return rarityRare;
      case 'epic': return rarityEpic;
      case 'legend': 
      case 'legendary': return rarityLegend;
      default: return rarityCommon;
    }
  }

  // Helper for POS
  static Color getPosColor(String pos) {
    if (pos.isEmpty) return textSecondary;
    final p = pos.toLowerCase().replaceAll('.', '');
    if (p.startsWith('v')) return posVerb;
    if (p.startsWith('n')) return posNoun;
    if (p.startsWith('adj')) return posAdj;
    if (p.startsWith('adv')) return posAdv;
    return textSecondary;
  }

  // ===========================================================================
  // Compatibility Layer (Deprecated - for backward compatibility)
  // ===========================================================================
  static const Color primaryOrange = primary;
  static const Color flipBlue = secondary;
  static const Color backgroundLight = background;
  static const Color backgroundDark = Color(0xFF1A1A2E); // Keep original dark
  static const Color textPrimaryLight = textPrimary;
  static const Color textSecondaryLight = textSecondary;
  static const Color cardLight = surface;
  static const Color cardDark = Color(0xFF16213E);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  
  // Aliases
  static const Color verbRed = posVerb;
  static const Color nounBlue = posNoun;
  static const Color adjGreen = posAdj;
  static const Color advYellow = posAdv;
  
  static Color getPartOfSpeechColor(String pos) => getPosColor(pos);
}
