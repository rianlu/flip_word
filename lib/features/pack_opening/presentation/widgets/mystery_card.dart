import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../data/models/models.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/universal_card_face.dart';

class MysteryCard extends StatefulWidget {
  final Word word;
  final bool isFlipped;
  final VoidCallback onFlip;

  const MysteryCard({
    super.key,
    required this.word,
    required this.isFlipped,
    required this.onFlip,
  });

  @override
  State<MysteryCard> createState() => _MysteryCardState();
}

class _MysteryCardState extends State<MysteryCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
       vsync: this, 
       duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(
       CurvedAnimation(parent: _controller, curve: Curves.easeInOutBack),
    );

    if (widget.isFlipped) {
       _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(MysteryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFlipped && !oldWidget.isFlipped) {
       _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Glow Color Logic
    Color glowColor;
    double glowSpread;
    switch (widget.word.rarity?.toLowerCase()) {
       case 'legend': glowColor = Colors.amber; glowSpread = 15; break;
       case 'epic': glowColor = Colors.purpleAccent; glowSpread = 10; break;
       case 'rare': glowColor = Colors.blueAccent; glowSpread = 5; break;
       default: glowColor = Colors.transparent; glowSpread = 0; break;
    }

    return GestureDetector(
       onTap: widget.isFlipped ? null : widget.onFlip, // TODO: Add bounce on already flipped
       child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
             final angle = _animation.value;
             final isBackVisible = angle < (pi / 2);
             
             return Transform(
                transform: Matrix4.identity()
                   ..setEntry(3, 2, 0.001) // Perspective
                   ..rotateY(angle),
                alignment: Alignment.center,
                child: isBackVisible
                   ? _buildCardBack(glowColor, glowSpread)
                   : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(pi), // Correct text orientation
                        child: _buildTrophyFace(),
                     ),
             );
          },
       ),
    );
  }

  Widget _buildCardBack(Color glowColor, double glowSpread) {
      return Container(
          key: const ValueKey('back'),
          decoration: BoxDecoration(
             color: AppColors.cardDark,
             borderRadius: BorderRadius.circular(16),
             border: Border.all(color: Colors.white24, width: 2),
             boxShadow: [
                BoxShadow(color: glowColor.withOpacity(0.6), blurRadius: glowSpread * 2, spreadRadius: glowSpread),
             ],
          ),
          child: Center(
             child: Icon(Icons.help_outline, color: Colors.white.withOpacity(0.5), size: 48)
                   .animate(onPlay: (c) => c.repeat(reverse: true))
                   .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), duration: 1000.ms),
          ),
      );
  }


  Widget _buildTrophyFace() {
     return UniversalCardFace(
       word: widget.word,
       showMeaning: true,
     );
  }
}
