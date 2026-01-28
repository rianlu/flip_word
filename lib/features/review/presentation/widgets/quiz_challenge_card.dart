import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../../data/models/models.dart';
import '../../../../shared/widgets/universal_card_face.dart';
import '../../../../core/services/sound_service.dart';
import '../../../../core/theme/app_colors.dart';

class QuizChallengeCard extends StatefulWidget {
  final Word word;
  final List<String> options;
  final VoidCallback onCorrect;

  const QuizChallengeCard({
    super.key,
    required this.word,
    required this.options,
    required this.onCorrect,
  });

  @override
  State<QuizChallengeCard> createState() => _QuizChallengeCardState();
}

class _QuizChallengeCardState extends State<QuizChallengeCard> {
  late ConfettiController _confettiController;
  int? _selectedOptionIndex;
  bool _isCompleted = false;
  final Set<int> _wrongIndices = {};

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _handleOptionTap(int index, String option) {
    if (_isCompleted) return;

    final isCorrect = option == widget.word.definition;

    setState(() {
      _selectedOptionIndex = index;
    });

    if (isCorrect) {
      // Correct!
      setState(() {
        _isCompleted = true;
      });
      SoundService().playSuccess();
      _confettiController.play();

      // Auto advance
      Future.delayed(const Duration(milliseconds: 800), () {
        widget.onCorrect();
      });
    } else {
      // Wrong!
      HapticFeedback.mediumImpact();
      setState(() {
        _wrongIndices.add(index);
      });
      
      // Clear selection after short delay to allow retry
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
           setState(() {
              _selectedOptionIndex = null;
           });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Content
        Column(
          children: [
            // 1. Question Card (Top)
            Expanded(
               flex: 3,
               child: Center(
                 child: SizedBox(
                    width: 280,
                    child: AspectRatio(
                       aspectRatio: 2.5/3.5,
                       child: UniversalCardFace(
                          word: widget.word, 
                          showMeaning: false
                       ),
                    ),
                 ),
               ),
            ),
            
            const SizedBox(height: 24),

            // 2. Options Grid (Bottom)
            Expanded(
               flex: 2,
               child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 24),
                 child: LayoutBuilder(
                   builder: (context, constraints) {
                     // Calculate responsive grid
                     final crossAxisCount = 2;
                     final spacing = 12.0;
                     final width = (constraints.maxWidth - (spacing * (crossAxisCount - 1))) / crossAxisCount;
                     final height = (constraints.maxHeight - spacing) / 2;
                     final childAspectRatio = width / height;

                     return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: spacing,
                          mainAxisSpacing: spacing,
                          childAspectRatio: childAspectRatio.clamp(1.5, 3.0),
                        ),
                        itemCount: widget.options.length,
                        itemBuilder: (context, index) {
                           return _buildOptionButton(index, widget.options[index]);
                        },
                     );
                   }
                 ),
               ),
            ),
            const SizedBox(height: 16),
          ],
        ),

        // Confetti Overlay
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple],
          ),
        ),
      ],
    );
  }

  Widget _buildOptionButton(int index, String text) {
     final isWrong = _wrongIndices.contains(index);
     final isCorrect = _isCompleted && text == widget.word.definition;
     
     Color bgColor = Colors.white;
     Color textColor = Colors.black87;
     Color borderColor = Colors.black12;
     
     if (isWrong) {
        bgColor = AppColors.error.withOpacity(0.1);
        borderColor = AppColors.error;
        textColor = AppColors.error;
     } else if (isCorrect) {
        bgColor = AppColors.success;
        borderColor = AppColors.success;
        textColor = Colors.white;
     }

     return GestureDetector(
        onTap: () => _handleOptionTap(index, text),
        child: AnimatedContainer(
           duration: const Duration(milliseconds: 200),
           decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor, width: 2),
              boxShadow: isCorrect ? [
                 BoxShadow(color: AppColors.success.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))
              ] : [
                 BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))
              ],
           ),
           padding: const EdgeInsets.all(12),
           alignment: Alignment.center,
           child: Text(
              text,
              style: TextStyle(
                 color: textColor,
                 fontWeight: FontWeight.bold,
                 fontSize: 16,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
           ).animate(target: isWrong ? 1 : 0).shakeX(amount: 4),
        ),
     );
  }
}
