import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/cards/cards.dart';
import '../../../../data/models/models.dart' as models;
import '../../../../core/services/sound_service.dart';
import '../providers/pack_provider.dart';
import '../widgets/mystery_card.dart';

enum OpeningStage { idle, shaking, revealed, finished }

class PackOpeningScreen extends ConsumerStatefulWidget {
  const PackOpeningScreen({super.key});

  @override
  ConsumerState<PackOpeningScreen> createState() => _PackOpeningScreenState();
}

class _PackOpeningScreenState extends ConsumerState<PackOpeningScreen> with TickerProviderStateMixin {
  OpeningStage _stage = OpeningStage.idle;
  
  // Confetti Controllers (one global for now)
  late ConfettiController _confettiController;
  
  // Animation Controllers for Shake and Flash
  late AnimationController _shakeController;
  late AnimationController _flashController;
  
  // State tracking
  List<models.Word> _cards = [];
  final Set<int> _flippedIndices = {};
  
  // Timer for Long Press
  DateTime? _pressStartTime;
  bool _isLongPressing = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100)); // Fast loop
    _flashController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    
    // Reset provider state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(packProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _shakeController.dispose();
    _flashController.dispose();
    super.dispose();
  }

  // --- Logic Methods ---

  void _startShaking() {
     setState(() {
        _stage = OpeningStage.shaking;
        _isLongPressing = true;
        _pressStartTime = DateTime.now();
     });
     _shakeController.repeat(reverse: true);
     SoundService().playPackShake(); // Ensure sound loops or is long enough
     HapticFeedback.heavyImpact(); // Initial haptic
  }

  void _stopShaking({bool success = false}) {
     _shakeController.stop();
     _shakeController.reset();
     setState(() {
        _isLongPressing = false;
        if (!success) _stage = OpeningStage.idle;
     });
  }

  void _onPackReleased() {
      if (!_isLongPressing) return;

      final duration = DateTime.now().difference(_pressStartTime!);
      if (duration.inMilliseconds > 1000) {
         // Success! Open the pack
         _triggerOpeningSequence();
      } else {
         // Fail
         _stopShaking(success: false);
      }
  }

  Future<void> _triggerOpeningSequence() async {
      _stopShaking(success: true); // Stop shake animation
      
      // Flash Animation
      _flashController.forward(from: 0).then((_) => _flashController.reverse());
      SoundService().playPackOpen();
      HapticFeedback.vibrate();

      // Trigger Provider
      await ref.read(packProvider.notifier).openPack();
      
      // Get cards from provider
      final state = ref.read(packProvider);
      if (state is PackRevealed) {
         setState(() {
            _cards = state.cards;
            _stage = OpeningStage.revealed;
            _flippedIndices.clear();
         });
      }
  }
  
  void _onCardFlipped(int index, String rarity) {
      if (_flippedIndices.contains(index)) return;
      
      setState(() {
         _flippedIndices.add(index);
      });
      
      SoundService().playFlip();

      // Rarity Effects
      if (['rare', 'epic', 'legend'].contains(rarity.toLowerCase())) {
          _confettiController.play();
          SoundService().playSuccess();
          HapticFeedback.mediumImpact();
      }
      
      // Check completion
      if (_flippedIndices.length == _cards.length) {
          Future.delayed(const Duration(milliseconds: 1000), () {
             if (mounted) setState(() => _stage = OpeningStage.finished);
          });
      }
  }

  // --- UI Build ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        children: [
            // Background Effects (Particles?)
            
            // Main Content
            SafeArea(
               child: Center(
                  child: AnimatedSwitcher(
                     duration: const Duration(milliseconds: 300),
                     child: _buildCurrentStage(),
                  ),
               ),
            ),
            
            // Flash Layer
            IgnorePointer(
               child: AnimatedBuilder(
                  animation: _flashController,
                  builder: (context, child) {
                     return Container(
                        color: Colors.white.withOpacity(_flashController.value),
                     );
                  },
               ),
            ),
            
            // Confetti
            Align(
               alignment: Alignment.topCenter,
               child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple], 
               ),
            ),
        ],
      ),
    );
  }

  Widget _buildCurrentStage() {
     switch (_stage) {
        case OpeningStage.idle:
           return _buildPackWidget(isShaking: false);
        case OpeningStage.shaking:
           return _buildPackWidget(isShaking: true);
        case OpeningStage.revealed:
        case OpeningStage.finished:
           return _buildCardsGrid();
     }
  }

  // --- Widgets ---

  Widget _buildPackWidget({required bool isShaking}) {
     return GestureDetector(
        onLongPressStart: (_) => _startShaking(),
        onLongPressEnd: (_) => _onPackReleased(),
        child: AnimatedBuilder(
           animation: _shakeController,
           builder: (context, child) {
              final offset = isShaking 
                 ? Offset(
                     sin(_shakeController.value * pi * 10) * 5, 
                     cos(_shakeController.value * pi * 10) * 5
                   )
                 : Offset.zero;
              return Transform.translate(
                 offset: offset,
                 child: child,
              );
           },
           child: Container(
             width: 240,
             height: 340,
             decoration: BoxDecoration(
               gradient: const LinearGradient(
                  colors: [Color(0xFF4AC29A), Color(0xFFBDFFF3)], 
                  begin: Alignment.topLeft, 
                  end: Alignment.bottomRight
               ),
               borderRadius: BorderRadius.circular(24),
               boxShadow: [
                  BoxShadow(color: const Color(0xFF4AC29A).withOpacity(0.6), blurRadius: 40, spreadRadius: 5),
               ],
               border: Border.all(color: Colors.white, width: 4),
             ),
             child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.auto_awesome, size: 80, color: Colors.white),
                   SizedBox(height: 20),
                   Text(
                      'HOLD TO OPEN', 
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2)
                   ),
                ],
             ),
           ).animate(target: isShaking ? 0 : 1).scale(begin: const Offset(0.95, 0.95), end: const Offset(1,1), duration: 800.ms, curve: Curves.easeInOut).then().shimmer(duration: 1500.ms),
        ),
     );
  }

  Widget _buildCardsGrid() {
     return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Wrap(
              alignment: WrapAlignment.center, // Fixed typo
              spacing: 16,
              runSpacing: 24,
              children: List.generate(_cards.length, (index) {
                 final word = _cards[index];
                 // Staggered Fly-In Animation
                 return SizedBox(
                   width: 140,
                   child: AspectRatio(
                     aspectRatio: 2.5 / 3.5,
                     child: MysteryCard(
                        word: word,
                        isFlipped: _flippedIndices.contains(index),
                        onFlip: () => _onCardFlipped(index, word.rarity ?? 'common'),
                     ),
                   ),
                 ).animate().fadeIn(duration: 400.ms, delay: (index * 100).ms).moveY(begin: 100, end: 0, curve: Curves.easeOutBack);
              }),
           ),
           
           if (_stage == OpeningStage.finished)
             Padding(
                padding: const EdgeInsets.only(top: 40),
                child: ElevatedButton(
                   onPressed: () => Navigator.of(context).pop(),
                   style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                   ),
                   child: const Text('COLLECT ALL'),
                ).animate().fadeIn().moveY(begin: 20, end: 0),
             ),
        ],
     );
  }
}

