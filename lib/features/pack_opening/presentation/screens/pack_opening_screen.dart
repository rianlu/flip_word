import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/cards/cards.dart';
import '../../../../shared/widgets/universal_card_face.dart';
import '../../../../data/models/models.dart' as models;
import '../../../../core/services/sound_service.dart';
import '../providers/pack_provider.dart';

enum OpeningStage { pack, cards, summary }

class PackOpeningScreen extends ConsumerStatefulWidget {
  const PackOpeningScreen({super.key});

  @override
  ConsumerState<PackOpeningScreen> createState() => _PackOpeningScreenState();
}

class _PackOpeningScreenState extends ConsumerState<PackOpeningScreen> with TickerProviderStateMixin {
  OpeningStage _stage = OpeningStage.pack;

  // Controllers
  late ConfettiController _confettiController;
  late AnimationController _ripController; 
  late AnimationController _sunburstController;
  late AnimationController _breathController;

  late PageController _pageController;

  // State
  List<models.Word> _cards = [];
  List<bool> _cardRevealStates = [];
  int _currentIndex = 0;
  bool _isInteractionLocked = false; 

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    
    _ripController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _sunburstController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _breathController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
    
    _pageController = PageController(viewportFraction: 0.75); // Adjusted for focus effect

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(packProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _ripController.dispose();
    _sunburstController.dispose();
    _breathController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // --- Logic ---

  Future<void> _handleTapToRip() async {
     if (_isInteractionLocked) return;
     
     setState(() {
       _isInteractionLocked = true;
     });

     SoundService().playPackOpen(); 
     HapticFeedback.mediumImpact();
     
     try {
         await ref.read(packProvider.notifier).openPack();
         final state = ref.read(packProvider);
         
         if (state is PackRevealed) {
            _cards = state.cards;
         } else {
             // Fallback
            _cards = [
               const models.Word(id: 1, text: 'Serendipity', definition: 'The occurrence of events by chance in a happy way', rarity: 'legend'),
               const models.Word(id: 2, text: 'Hello', definition: 'Greeting', rarity: 'common'),
               const models.Word(id: 3, text: 'World', definition: 'Planet', rarity: 'common'),
               const models.Word(id: 4, text: 'Flutter', definition: 'Framework', rarity: 'epic'),
               const models.Word(id: 5, text: 'Dart', definition: 'Language', rarity: 'rare'),
            ];
         }
         
         await _ripController.forward();
         // 4. Reveal Cards
         setState(() {
            _stage = OpeningStage.cards;
            _currentIndex = 0;
            _cardRevealStates = List.filled(_cards.length, false);
            _isInteractionLocked = false;
         });

     } catch (e) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
         setState(() => _isInteractionLocked = false);
     }
  }

  void _onCardFlipped(int index) {
     if (_cardRevealStates[index]) return; 

     setState(() {
        _cardRevealStates[index] = true;
     });

     final word = _cards[index];
     final rarity = word.rarity?.toLowerCase() ?? 'common';
     final isHighRarity = ['legend', 'epic', 'rare'].contains(rarity);

     if (isHighRarity) {
        SoundService().playSuccess();
        HapticFeedback.heavyImpact();
        _confettiController.play();
     } else {
        SoundService().playFlip();
        HapticFeedback.selectionClick();
     }
  }

  Future<void> _handleRevealAll() async {
     if (_isInteractionLocked) return;
     _isInteractionLocked = true;

     for (int i = 0; i < _cards.length; i++) {
        if (!_cardRevealStates[i]) {
           _onCardFlipped(i);
           await Future.delayed(const Duration(milliseconds: 200));
        }
     }
     
     _isInteractionLocked = false;
  }
  
  bool _isCollecting = false;
  
  Future<void> _handleCollect() async {
     setState(() {
        _isCollecting = true;
     });
     
     SoundService().playSuccess(); // Should ideally be a specific 'bag' sound
     
     // Animation duration
     await Future.delayed(const Duration(milliseconds: 1200));
     
     if (mounted) Navigator.of(context).pop();
  }

  // --- UI ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       extendBodyBehindAppBar: true, 
       body: Container(
          decoration: const BoxDecoration(
             gradient: RadialGradient(
                center: Alignment(0, -0.2), 
                radius: 1.2,
                colors: [Color(0xFF2C3E50), Color(0xFF000000)], // Vignette: Blue-Grey -> Black
                stops: [0.3, 1.0],
             ),
          ),
          child: Stack(
         alignment: Alignment.center,
         children: [
            // 0. God Rays (Background)
            _buildGodRays(),

            // 1. Confetti
            Align(
               alignment: Alignment.center,
               child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  colors: const [Colors.green, Colors.blue, Colors.pink, Colors.orange, Colors.purple, Colors.amber], 
               ),
            ),
            
            // 2. Content
            SafeArea(
               child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: _isCollecting ? 0.0 : 1.0,
                  child: _buildStageContent(),
               ),
            ),
            
            // 3. Collection Animation Overlay
            if (_isCollecting)
              _buildCollectAnimation(),
         ],
       ),
    )); 
  }
  
  Widget _buildCollectAnimation() {
     return Stack(
        alignment: Alignment.center,
        children: [
           for (int i = 0; i < 5; i++)
              TweenAnimationBuilder<Offset>(
                 tween: Tween(begin: Offset.zero, end: Offset((i - 2) * 20.0, 400)),
                 duration: Duration(milliseconds: 600 + (i * 100)),
                 curve: Curves.easeInOutBack,
                 builder: (context, offset, child) {
                    return Transform.translate(
                       offset: offset,
                       child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1.0, end: 0.2),
                          duration: Duration(milliseconds: 600 + (i * 100)),
                          builder: (context, scale, _) {
                             return Transform.scale(scale: scale, child: const Icon(Icons.style, color: Colors.white, size: 40));
                          }
                       ),
                    );
                 },
              ),
        ],
     );
  }
  
  Widget _buildGodRays() {
     if (_stage != OpeningStage.cards || _cards.isEmpty) return const SizedBox();
     
     // Only show God Rays if the CURRENT centered card is a flipped high-rarity card
     // Note: access key state or just check model if we tracked 'flipped' state in parent. 
     // For now, simple god rays always on might be too much. 
     // Let's rely on the confetti for the "Moment". 
     // Or, we could skip God Rays for this iteration to keep it clean, as per request focus on 'Tease'.
     // But strictly following user "Upgrade Card Back to Breathing Glow", I'll leave simple ambient rays if desired.
     return const SizedBox(); 
  }

  Widget _buildStageContent() {
     return Column(
        children: [
           const SizedBox(height: 20),
           // Header Title (Always Visible except summary)
           if (_stage != OpeningStage.summary)
              Text(
                 'SPACE VOYAGER', 
                 style: TextStyle(
                    fontFamily: 'Roboto', 
                    fontSize: 28, 
                    fontWeight: FontWeight.w900, 
                    color: Colors.white,
                    letterSpacing: 2,
                    shadows: [
                       BoxShadow(color: Colors.blueAccent.withOpacity(0.8), blurRadius: 20, spreadRadius: 0),
                    ]
                 )
              ).animate().fadeIn(duration: 800.ms).shimmer(duration: 2000.ms, color: Colors.white54),

           Expanded(
              child: _buildMainContent(),
           ),
        ],
     );
  }

  Widget _buildMainContent() {
      switch (_stage) {
         case OpeningStage.pack: return _buildPackView();
         case OpeningStage.cards: return _buildCarouselReveal();
         case OpeningStage.summary: return _buildSummaryView();
      }
  }
  
  // --- PACK RIPPING VIEW ---
  
  Widget _buildPackView() {
     return Center(
        child: GestureDetector(
           onTap: _handleTapToRip,
           child: Stack(
              alignment: Alignment.center,
              children: [
                 AnimatedBuilder(
                    animation: _ripController,
                    builder: (_, __) => Opacity(
                       opacity: 1.0 - _ripController.value,
                       child: Transform.translate(
                          offset: const Offset(0, -220),
                          child: const Text('TAP TO OPEN', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2)),
                       ),
                    ),
                 ),
                 AnimatedBuilder(
                    animation: _ripController,
                    builder: (context, child) {
                       final val = CurvedAnimation(parent: _ripController, curve: Curves.easeInBack).value;
                       final topOffset = Offset(-50 * val, -600 * val);
                       final topAngle = -0.2 * val;
                       final bottomOffset = Offset(50 * val, 600 * val);
                       final bottomAngle = 0.2 * val;

                       return SizedBox(
                          width: 240,
                          height: 340,
                          child: Stack(
                             children: [
                                Transform.translate(
                                   offset: bottomOffset,
                                   child: Transform.rotate(
                                      angle: bottomAngle,
                                      child: ClipPath(clipper: _JaggedClipper(isTop: false), child: _buildPackContainer()),
                                   ),
                                ),
                                Transform.translate(
                                   offset: topOffset,
                                   child: Transform.rotate(
                                      angle: topAngle,
                                      child: ClipPath(clipper: _JaggedClipper(isTop: true), child: _buildPackContainer()),
                                   ),
                                ),
                             ],
                          ),
                       );
                    },
                 ),
              ],
           ),
        ),
     );
  }
  
  Widget _buildPackContainer() {
     return Container(
        decoration: BoxDecoration(
           gradient: const LinearGradient(colors: [Color(0xFF6dd5ed), Color(0xFF2193b0)], begin: Alignment.topLeft, end: Alignment.bottomRight),
           borderRadius: BorderRadius.circular(24),
           border: Border.all(color: Colors.white, width: 4),
           boxShadow: [BoxShadow(color: Colors.blueAccent.withOpacity(0.5), blurRadius: 40, spreadRadius: 5)],
        ),
        child: const Center(child: Icon(Icons.inventory_2, size: 80, color: Colors.white)),
     );
  }

  // --- CAROUSEL VIEW ---

  // --- CAROUSEL VIEW ---

  Widget _buildCarouselReveal() {
     return Column(
        children: [
           // Indicator
           const SizedBox(height: 10),
           Text(
              '${_currentIndex + 1} / ${_cards.length}',
              style: const TextStyle(color: Colors.white30, fontSize: 16, fontWeight: FontWeight.bold),
           ),
           const Spacer(), 
           
           // CAROUSEL
           SizedBox( 
              height: 480, // Fixed height for carousel to ensure vertical centering impact
              child: PageView.builder(
                 controller: _pageController,
                 physics: const BouncingScrollPhysics(),
                 onPageChanged: (index) {
                    setState(() {
                       _currentIndex = index;
                    });
                 },
                 itemCount: _cards.length,
                 itemBuilder: (context, index) {
                    return AnimatedBuilder(
                       animation: _pageController,
                       builder: (context, child) {
                          double page = 0.0;
                          if (_pageController.position.haveDimensions) {
                             page = _pageController.page!;
                          } else {
                             page = _currentIndex.toDouble();
                          }
                          
                          // Focus Effect: Scale center card 1.0, others smaller
                          double diff = (index - page).abs();
                          double scale = 1.0 - (diff * 0.15); 
                          scale = scale.clamp(0.85, 1.0);
                          
                          return Transform.scale(
                             scale: scale,
                             child: child,
                          );
                       },
                       child: Center(
                          child: PackCardFlipItem(
                             word: _cards[index],
                             isRevealed: _cardRevealStates[index],
                             onFlip: () => _onCardFlipped(index),
                          ),
                       ),
                    );
                 },
              ),
           ), 
           
           const Spacer(),

           // CONTROLS AREA
           SizedBox(
              height: 120,
              child: Center(
                child: _cardRevealStates.isNotEmpty && _cardRevealStates.every((r) => r) 
                ? _buildCollectButton() // Primary Action
                : _buildRevealControls(), // Secondary Actions
              ),
           ),
           const SizedBox(height: 20),
        ],
     );
  }

  Widget _buildCollectButton() {
      return GestureDetector(
         onTap: _handleCollect,
         child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(30),
               gradient: const LinearGradient(
                  colors: [Color(0xFFFFD700), Color(0xFFFFA500)], // Gold -> Amber
                  begin: Alignment.topLeft, end: Alignment.bottomRight
               ),
               boxShadow: [
                  BoxShadow(color: const Color(0xFF8B4500).withOpacity(1), offset: const Offset(0, 4), blurRadius: 0), // Hard 3D Shadow
                  BoxShadow(color: Colors.amber.withOpacity(0.4), offset: const Offset(0, 8), blurRadius: 16), // Glow
               ],
            ),
            child: const Text(
               'COLLECT ALL',
               style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1,
                  shadows: [Shadow(color: Colors.black26, offset: Offset(0, 1), blurRadius: 2)]
               ),
            ),
         ).animate().scale(curve: Curves.elasticOut, duration: 400.ms),
      );
  }

  Widget _buildRevealControls() {
      return Column(
         mainAxisSize: MainAxisSize.min,
         children: [
            // Glass Button
            GestureDetector(
               onTap: _handleRevealAll,
               child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                     color: Colors.white.withOpacity(0.1),
                     borderRadius: BorderRadius.circular(20),
                     border: Border.all(color: Colors.white30, width: 1),
                  ),
                  child: const Text('REVEAL ALL', style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.bold)),
               ),
            ),
            const SizedBox(height: 16),
            const Text(
               'SWIPE TO EXPLORE',
               style: TextStyle(color: Colors.white24, fontSize: 10, letterSpacing: 2),
            ),
         ],
      );
  }

  Widget _buildSummaryView() {
     return Column(
        children: [
           const SizedBox(height: 20),
           Text('COLLECTION UPDATED!', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
           Expanded(
              child: GridView.builder(
                 padding: const EdgeInsets.all(16),
                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5 / 3.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                 ),
                 itemCount: _cards.length,
                 itemBuilder: (context, index) {
                    return UniversalCardFace(word: _cards[index], showMeaning: true)
                        .animate().fadeIn(delay: (index * 100).ms).scale();
                 },
              ),
           ),
           Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.white,
                       foregroundColor: Colors.black,
                       padding: const EdgeInsets.symmetric(vertical: 16),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('CONTINUE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                 ),
              ),
           ),
        ],
     );
  }
}

class PackCardFlipItem extends StatefulWidget {
  final models.Word word;
  final bool isRevealed;
  final VoidCallback onFlip;

  const PackCardFlipItem({
    super.key,
    required this.word,
    required this.isRevealed,
    required this.onFlip,
  });

  @override
  State<PackCardFlipItem> createState() => _PackCardFlipItemState();
}

class _PackCardFlipItemState extends State<PackCardFlipItem> with SingleTickerProviderStateMixin {
  late AnimationController _flipController;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    
    if (widget.isRevealed) {
       _flipController.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(PackCardFlipItem oldWidget) {
     super.didUpdateWidget(oldWidget);
     if (widget.isRevealed && !oldWidget.isRevealed) {
        _flipController.forward();
     }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _handleTap() {
     if (widget.isRevealed) return;
     widget.onFlip();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: _handleTap,
       child: SizedBox(
          width: 300,
          child: AspectRatio(
             aspectRatio: 2.5 / 3.5,
             child: AnimatedBuilder(
                animation: _flipController,
                builder: (context, child) {
                   final angle = _flipController.value * pi;
                   final isFrontVisible = angle >= (pi / 2);
                   
                   return Transform(
                      transform: Matrix4.identity()
                         ..setEntry(3, 2, 0.002) // Perspective
                         ..rotateY(angle),
                      alignment: Alignment.center,
                      child: isFrontVisible
                         ? Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()..rotateY(pi), 
                              child: UniversalCardFace(word: widget.word, showMeaning: true),
                           )
                         : _buildCardBack(widget.word),
                   );
                },
             ),
          ),
       ),
    );
  }

  Widget _buildCardBack(models.Word word) {
     final rarity = word.rarity?.toLowerCase() ?? 'common';
     final showFireflies = ['legend', 'epic', 'rare'].contains(rarity); // Rare/Epic/Legend
     
     return Container(
        decoration: BoxDecoration(
           color: AppColors.cardDark,
           borderRadius: BorderRadius.circular(16),
           border: Border.all(color: Colors.white24, width: 2),
           boxShadow: const [
              BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4))
           ],
        ),
        child: Stack(
           alignment: Alignment.center,
           children: [
               if (showFireflies)
                  Positioned.fill(child: FireflyParticles(rarity: rarity)),
                  
               Center(
                  child: Icon(Icons.help_outline, color: Colors.white.withOpacity(0.3), size: 60),
               ),
           ],
        ),
     );
  }
}

class FireflyParticles extends StatefulWidget {
   final String rarity;
   const FireflyParticles({super.key, required this.rarity});

   @override
   State<FireflyParticles> createState() => _FireflyParticlesState();
}

class _FireflyParticlesState extends State<FireflyParticles> with TickerProviderStateMixin {
   final List<_Firefly> _fireflies = [];
   final Random _random = Random();
   late AnimationController _controller;

   @override
   void initState() {
      super.initState();
      _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
      
      for (int i = 0; i < 15; i++) {
         _fireflies.add(_Firefly(
            x: _random.nextDouble(),
            y: _random.nextDouble(),
            size: _random.nextDouble() * 3 + 1,
            speed: _random.nextDouble() * 0.5 + 0.2,
            offset: _random.nextDouble() * 2 * pi,
         ));
      }
   }
   
   @override
   void dispose() {
      _controller.dispose();
      super.dispose();
   }

   @override
   Widget build(BuildContext context) {
      final color = widget.rarity == 'legend' ? Colors.amber : (widget.rarity == 'epic' ? Colors.purpleAccent : Colors.lightBlueAccent);

      return AnimatedBuilder(
         animation: _controller,
         builder: (context, child) {
            return Stack(
               children: _fireflies.map((f) {
                  final t = _controller.value;
                  // Simple floating motion using sine waves
                  final dx = f.x + sin(t * 2 * pi * f.speed + f.offset) * 0.05;
                  final dy = f.y + cos(t * 2 * pi * f.speed + f.offset) * 0.05;
                  final opacity = (sin(t * 4 * pi * f.speed + f.offset) + 1) / 2; // Twinkle

                  return Positioned(
                     left: (dx * 100) % 100 * 3, // Multiplier for spread roughly fitting card
                     top: (dy * 100) % 100 * 4,
                     child: Opacity(
                        opacity: opacity * 0.8,
                        child: Container(
                           width: f.size,
                           height: f.size,
                           decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: color, blurRadius: 4)],
                           ),
                        ),
                     ),
                  );
               }).toList(),
            );
         },
      );
   }
}

class _Firefly {
   final double x, y, size, speed, offset;
   _Firefly({required this.x, required this.y, required this.size, required this.speed, required this.offset});
}

class _JaggedClipper extends CustomClipper<Path> {
  final bool isTop;
  _JaggedClipper({required this.isTop});

  @override
  Path getClip(Size size) {
    final path = Path();
    final double mid = size.height / 2;
    final double teeth = 8;
    final double w = size.width;
    final double step = w / teeth;

    if (isTop) {
       path.moveTo(0, 0);
       path.lineTo(0, mid);
       for (double x = 0; x < w; x += step) {
          path.lineTo(x + step / 2, mid - 15); // Zig Up
          path.lineTo(x + step, mid + 15);     // Zag Down
       }
       path.lineTo(w, 0);
    } else {
       path.moveTo(0, mid);
       for (double x = 0; x < w; x += step) {
          path.lineTo(x + step / 2, mid - 15); // Match top zig
          path.lineTo(x + step, mid + 15);     // Match top zag
       }
       path.lineTo(w, size.height);
       path.lineTo(0, size.height);
    }
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
