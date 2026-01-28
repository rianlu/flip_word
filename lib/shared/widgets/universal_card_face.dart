import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../data/models/models.dart';

class UniversalCardFace extends StatelessWidget {
  final Word word;
  final bool showMeaning;

  const UniversalCardFace({
    super.key,
    required this.word,
    this.showMeaning = true,
  });

  @override
  Widget build(BuildContext context) {
     final rarity = word.rarity?.toLowerCase() ?? 'common';
     
     // 1. Rarity Config
     Color borderColor = Colors.grey;
     Gradient? borderGradient;
     double borderStroke = 1.0;
     IconData? rarityIcon;
     Color iconColor = Colors.transparent;
     
     switch (rarity) {
       case 'legend': 
         borderGradient = const LinearGradient(
            colors: [Color(0xFFFFD700), Color(0xFFFDB931), Color(0xFFFFD700)],
            begin: Alignment.topLeft, end: Alignment.bottomRight
         );
         borderStroke = 4.0;
         rarityIcon = Icons.diamond;
         iconColor = const Color(0xFFFFD700);
         break;
       case 'epic': 
         borderColor = AppColors.rarityEpic; 
         borderStroke = 3.0;
         rarityIcon = Icons.auto_awesome;
         iconColor = AppColors.rarityEpic;
         break;
       case 'rare': 
         borderColor = AppColors.rarityRare; 
         borderStroke = 2.0;
         rarityIcon = Icons.star;
         iconColor = AppColors.rarityRare;
         break;
       default: 
         borderColor = Colors.grey; 
         borderStroke = 1.0;
         break;
     }

     return Container(
        decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(16),
           gradient: borderGradient,
           border: borderGradient == null ? Border.all(color: borderColor, width: borderStroke) : null,
           boxShadow: [
              BoxShadow(
                 color: Colors.black.withOpacity(0.1), 
                 blurRadius: 8, 
                 offset: const Offset(0, 4)
              ),
           ],
        ),
        padding: borderGradient != null ? EdgeInsets.all(borderStroke) : null,
        child: Container(
            decoration: BoxDecoration(
               color: Colors.grey[50],
               borderRadius: BorderRadius.circular(16 - borderStroke),
            ),
            child: ClipRRect(
               borderRadius: BorderRadius.circular(14), // Inner clip
               child: Stack(
                  children: [
                     // 2. Background Watermark
                     Positioned(
                        bottom: -20,
                        right: -20,
                        child: Transform.rotate(
                           angle: -0.26, // ~ -15 degrees
                           child: Text(
                              word.text.isNotEmpty ? word.text[0].toUpperCase() : '',
                              style: const TextStyle(
                                 fontSize: 150,
                                 fontWeight: FontWeight.w900,
                                 color: Color(0x1A000000), // Black with 0.1 opacity
                                 height: 1,
                              ),
                           ),
                        ),
                     ),
                     
                     // 3. Content Typography
                     Center(
                        child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 16),
                           child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 // English Word (Hero)
                                 Text(
                                    word.text,
                                    style: const TextStyle(
                                       fontSize: 40,
                                       fontWeight: FontWeight.w900,
                                       color: Colors.black,
                                       height: 1.1,
                                       letterSpacing: -1,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                 ),
                                 
                                 // Phonetic
                                 if (word.phonetic != null) ...[
                                    const SizedBox(height: 8),
                                    Text(
                                       word.phonetic!,
                                       style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontStyle: FontStyle.italic,
                                       ),
                                    ),
                                 ],

                                 const SizedBox(height: 16),
                                 
                                 // Divider
                                 Container(
                                    width: 40,
                                    height: 2,
                                    color: (borderGradient != null ? iconColor : borderColor).withOpacity(0.5),
                                 ),
                                 
                                 const SizedBox(height: 16),

                                 // Meaning or Hint
                                 if (showMeaning)
                                   Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                         Flexible(
                                            child: Text(
                                               word.definition ?? '',
                                               style: const TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF333333), // Dark Grey
                                                  height: 1.3,
                                               ),
                                               textAlign: TextAlign.center,
                                               maxLines: 2,
                                               overflow: TextOverflow.ellipsis,
                                            ),
                                         ),
                                         if (rarityIcon != null) ...[
                                            const SizedBox(width: 8),
                                            Icon(rarityIcon, size: 20, color: iconColor),
                                         ]
                                      ],
                                   )
                                 else 
                                   const Text(
                                      'Tap to Flip',
                                      style: TextStyle(
                                         fontSize: 16,
                                         color: Colors.grey,
                                         fontWeight: FontWeight.w500
                                      ),
                                   ),
                              ],
                           ),
                        ),
                     ),
                     
                     // Rarity Badge (Top Right)
                     if (rarityIcon == null)
                       Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                             width: 8,
                             height: 8,
                             decoration: BoxDecoration(
                                color: borderColor,
                                shape: BoxShape.circle,
                             ),
                          ),
                       ),
                  ],
               ),
            ),
        ),
     );
  }
}
