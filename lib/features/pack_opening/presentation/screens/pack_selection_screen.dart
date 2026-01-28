import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/mock_database_service.dart';
import '../../../../data/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/pack_provider.dart';
import 'pack_opening_screen.dart';

class PackSelectionScreen extends ConsumerStatefulWidget {
  const PackSelectionScreen({super.key});

  @override
  ConsumerState<PackSelectionScreen> createState() => _PackSelectionScreenState();
}

class _PackSelectionScreenState extends ConsumerState<PackSelectionScreen> {
  final MockDatabaseService _db = MockDatabaseService();
  String _searchQuery = '';
  String _selectedFilterDisplay = '全部'; 
  final List<String> _filters = ['全部', '基础', '扩展', '限定'];

  // Helper to map display name to category key
  String _getCategoryKey(String displayName) {
    switch (displayName) {
      case '基础': return 'basic';
      case '扩展': return 'expansion';
      case '限定': return 'limited';
      default: return 'all';
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Filter themes
    var filteredThemes = _db.themes.where((t) {
       final matchesSearch = t.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false;
       
       final categoryKey = _getCategoryKey(_selectedFilterDisplay);
       final matchesFilter = categoryKey == 'all' || t.category == categoryKey;
       
       return matchesSearch && matchesFilter;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('选择卡包', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: true,
      ),
      body: Column(
         children: [
            // 2. Search & Filter Area
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: [
                   // Search Bar
                   TextField(
                      decoration: InputDecoration(
                        hintText: '搜索卡包名称...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(12),
                           borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                      onChanged: (val) => setState(() => _searchQuery = val),
                   ),
                   const SizedBox(height: 12),
                   // Filters
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       children: _filters.map((filter) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: _buildFilterChip(filter),
                          );
                       }).toList(),
                     ),
                   ),
                ],
              ),
            ),
            
            // 3. The Grid
            Expanded(
               child: filteredThemes.isEmpty 
               ? Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       const Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
                       const SizedBox(height: 16),
                       Text('未找到相关卡包', style: TextStyle(color: Colors.grey[600])),
                     ],
                   ),
               )
               : GridView.builder(
                   padding: const EdgeInsets.all(16),
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3, // Portrait Card Aspect Ratio
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                   ),
                   itemCount: filteredThemes.length,
                   itemBuilder: (context, index) {
                      final theme = filteredThemes[index];
                      // Staggered entry animation
                      return _PackGridItem(
                         theme: theme, 
                         db: _db,
                         onTap: () {
                            // Navigate to Opening
                            ref.read(packProvider.notifier).reset();
                            ref.read(packProvider.notifier).selectTheme(theme.id);
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const PackOpeningScreen()),
                            );
                         },
                      ).animate().fadeIn(duration: 400.ms, delay: (index * 50).ms).slideY(begin: 0.1, end: 0);
                   },
               ),
            ),
         ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
     final isSelected = _selectedFilterDisplay == label;
     return FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
           setState(() => _selectedFilterDisplay = label);
        },
        selectedColor: AppColors.primaryOrange.withOpacity(0.2),
        checkmarkColor: AppColors.primaryOrange,
        labelStyle: TextStyle(
           color: isSelected ? AppColors.primaryOrange : Colors.black87,
           fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
     );
  }
}

class _PackGridItem extends StatelessWidget {
  final ThemeModel theme;
  final MockDatabaseService db;
  final VoidCallback onTap;

  const _PackGridItem({required this.theme, required this.db, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // Logic for progress
    final themeWordIds = db.allWords.where((w) => w.themeId == theme.id).map((w) => w.id).toSet();
    final collectedCount = db.userWords.where((uw) => themeWordIds.contains(uw.wordId) && uw.isCollected).length;
    final totalCount = themeWordIds.length;
    final progress = totalCount > 0 ? collectedCount / totalCount : 0.0;
    
    // Gradient Logic from Theme Color
    List<Color> gradientColors;
    if (theme.color != null) {
       try {
          final color = Color(int.parse(theme.color!));
          // Create a gradient: Base Color -> Slightly Darker/Saturated
          final HSLColor hsl = HSLColor.fromColor(color);
          final darker = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor();
          gradientColors = [color, darker];
       } catch (e) {
          gradientColors = [Colors.grey, Colors.black54];
       }
    } else {
       gradientColors = [const Color(0xFF11998e), const Color(0xFF38ef7d)];
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
           ),
           borderRadius: BorderRadius.circular(16),
           boxShadow: [
              BoxShadow(
                 color: gradientColors.first.withOpacity(0.3),
                 blurRadius: 10,
                 offset: const Offset(0, 4),
              ),
           ],
         ),
         child: Stack(
           children: [
             // Pattern
             Positioned(
               right: -10, top: -10,
               child: Icon(Icons.style, size: 100, color: Colors.white.withOpacity(0.1)),
             ),
             
             // Content
             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                  const Spacer(),
                  // Emoji
                  Text(
                    theme.emoji ?? '📦',
                    style: const TextStyle(fontSize: 64),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(begin: const Offset(1,1), end: const Offset(1.05, 1.05), duration: 2000.ms),
                  
                  const SizedBox(height: 12),
                  
                  // Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      theme.name ?? 'Pack',
                      style: const TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.w900,
                         fontSize: 18,
                         shadows: [Shadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4)],
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Text(
                      theme.description ?? '',
                      style: TextStyle(
                         color: Colors.white.withOpacity(0.9),
                         fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                  const Spacer(),

                  // Progress Bar section
                  Container(
                     width: double.infinity,
                     padding: const EdgeInsets.all(12),
                     decoration: const BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                                const Text('已收集', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
                                Text('$collectedCount/$totalCount', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                             ],
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                             value: progress,
                             backgroundColor: Colors.white24,
                             color: AppColors.stardust,
                             minHeight: 4,
                             borderRadius: BorderRadius.circular(2),
                          ),
                       ],
                     ),
                  ),
               ],
             ),
             
             // New Tag (Mock logic: if progress < 0.2)
             if (progress < 0.2)
                Positioned(
                   top: 12, left: 12,
                   child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                         color: AppColors.primaryOrange,
                         borderRadius: BorderRadius.circular(8),
                         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                      ),
                      child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                   ),
                ),
           ],
         ),
      ),
    );
  }
}
