import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/binder_provider.dart';
import '../widgets/binder_card_item.dart';

class ThemeCollectionScreen extends ConsumerWidget {
  final ThemeModel theme;
  
  const ThemeCollectionScreen({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final binderState = ref.watch(binderProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
         title: Text(theme.name ?? 'Collection'),
         backgroundColor: Colors.white,
         foregroundColor: Colors.black,
         elevation: 0,
      ),
      body: binderState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
        data: (allEntries) {
           final themeEntries = allEntries.where((e) => e.word.themeId == theme.id).toList();
           
           // Sort: Common -> Legend, then by ID
           themeEntries.sort((a, b) {
              const rarityOrder = {'common': 0, 'rare': 1, 'epic': 2, 'legend': 3};
              final rA = rarityOrder[a.word.rarity?.toLowerCase() ?? 'common'] ?? 0;
              final rB = rarityOrder[b.word.rarity?.toLowerCase() ?? 'common'] ?? 0;
              if (rA != rB) return rA.compareTo(rB);
              return a.word.id.compareTo(b.word.id);
           });

           if (themeEntries.isEmpty) {
              return const Center(child: Text('No cards in this theme yet.'));
           }

           return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.75,
                 crossAxisSpacing: 16,
                 mainAxisSpacing: 16,
              ),
              itemCount: themeEntries.length,
              itemBuilder: (context, index) {
                 final entry = themeEntries[index];
                 return Opacity(
                    opacity: entry.isCollected ? 1.0 : 0.5,
                    child: BinderCardItem(
                       word: entry.word,
                       isCollected: entry.isCollected,
                    ),
                 );
              },
           );
        },
      ),
    );
  }
}
