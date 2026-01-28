import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/mock_database_service.dart';
import '../../../../data/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/pack_provider.dart';
import '../screens/pack_opening_screen.dart';

import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/mock_database_service.dart';
import '../../../../data/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/pack_provider.dart';
import '../screens/pack_opening_screen.dart';

class ThemeSelectionSheet extends ConsumerStatefulWidget {
  const ThemeSelectionSheet({super.key});

  @override
  ConsumerState<ThemeSelectionSheet> createState() => _ThemeSelectionSheetState();
}

class _ThemeSelectionSheetState extends ConsumerState<ThemeSelectionSheet> {
  late PageController _pageController;
  int _currentPageIndex = 0;
  final MockDatabaseService _db = MockDatabaseService();

  @override
  void initState() {
    super.initState();
    // fractional viewport to show prev/next cards
    _pageController = PageController(viewportFraction: 0.7);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themes = _db.themes;

    if (themes.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: const Center(child: Text('Loading themes...')),
      );
    }

    // Handle case where currentPageIndex is out of bounds (e.g., if themes changed)
    if (_currentPageIndex >= themes.length) {
       _currentPageIndex = 0;
    }

    final currentTheme = themes[_currentPageIndex];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Pack',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),

          // Carousel (PageView)
          SizedBox(
            height: 320,
            child: PageView.builder(
              controller: _pageController,
              itemCount: themes.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final theme = themes[index];
                final isSelected = index == _currentPageIndex;
                
                // Pack Cover Widget
                return AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: isSelected ? 1.05 : 0.9,
                  curve: Curves.easeOutBack,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: isSelected ? 1.0 : 0.6,
                    child: _buildPackCover(theme, isSelected),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),

          // Action Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                   _selectThemeAndOpen(context, currentTheme);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: Text(
                  'OPEN ${currentTheme.name?.toUpperCase() ?? 'PACK'}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void _selectThemeAndOpen(BuildContext context, ThemeModel theme) {
    Navigator.pop(context);
    ref.read(packProvider.notifier).reset();
    ref.read(packProvider.notifier).selectTheme(theme.id);
    Navigator.of(context).push(
       MaterialPageRoute(builder: (context) => const PackOpeningScreen()),
    );
  }

  Widget _buildPackCover(ThemeModel theme, bool isSelected) {
    // Determine colors based on theme ID to give variety
    // Fallback gradients based on ID if theme doesn't specify colors (mock Logic)
    final List<Color> gradientColors = theme.name?.toLowerCase().contains('space') == true 
        ? [const Color(0xFF2C3E50), const Color(0xFF4CA1AF)] // Space: Dark Blue/Teal
        : (theme.name?.toLowerCase().contains('fruit') == true 
           ? [const Color(0xFFFF416C), const Color(0xFFFF4B2B)] // Fruit: Red/Orange
           : [const Color(0xFF11998e), const Color(0xFF38ef7d)]); // Default: Green

    // Progress Logic
    final themeWordIds = _db.allWords.where((w) => w.themeId == theme.id).map((w) => w.id).toSet();
    final collectedCount = _db.userWords.where((uw) => themeWordIds.contains(uw.wordId) && uw.isCollected).length;
    final totalCount = themeWordIds.length;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8), // Gap between items
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          // Texture / Pattern (Optional)
          Positioned(
             right: -20, top: -20,
             child: Icon(Icons.style_rounded, size: 150, color: Colors.white.withOpacity(0.1)),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Theme Name
                Container(
                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                   decoration: BoxDecoration(
                     color: Colors.black.withOpacity(0.2),
                     borderRadius: BorderRadius.circular(20),
                   ),
                   child: Text(
                     theme.name?.toUpperCase() ?? 'THEME',
                     style: const TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       fontSize: 12,
                       letterSpacing: 2,
                     ),
                   ),
                ),
                
                const Spacer(),
                
                // Big Emoji Icon
                Text(
                  theme.emoji ?? '📦',
                  style: const TextStyle(fontSize: 80),
                ).animate(
                  // Gentle float animation for active card
                  target: isSelected ? 1 : 0, 
                ).scale(
                   begin: const Offset(1, 1), end: const Offset(1.1, 1.1),
                   duration: 2000.ms, curve: Curves.easeInOut,
                ).then(delay: 100.ms).scale(
                   begin: const Offset(1.1, 1.1), end: const Offset(1, 1),
                   duration: 2000.ms, curve: Curves.easeInOut,
                ), // Loop handled by manual key trigger or just simple animate? 
                   // Riverpod Animate loop is cleaner: .animate(onPlay: (c) => c.repeat(reverse:true))... 
                   // But here we conditional on isSelected. Let's keep it simple.

                const SizedBox(height: 20),
                
                Text(
                  '${totalCount} Cards',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
                
                const Spacer(),
                
                // Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Collected', style: TextStyle(color: Colors.white70, fontSize: 10)),
                        Text('$collectedCount/$totalCount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearProgressIndicator(
                      value: totalCount > 0 ? collectedCount / totalCount : 0,
                      backgroundColor: Colors.black12,
                      color: Colors.white,
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
