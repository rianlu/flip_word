import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/cards/cards.dart';
import '../../../../data/models/models.dart';
import '../../../../core/services/preferences_service.dart';
// import '../../../../core/services/sound_service.dart'; // Optional: Use if we want specific sounds here
import '../../../pack_opening/presentation/screens/pack_opening_screen.dart';
import '../../../../main_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _buildWelcomePage(),
                  _buildTutorialPage(),
                  _buildGiftPage(),
                ],
              ),
            ),
            
            // Indicators
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) => _buildIndicator(index)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIndicator(int index) {
    bool isActive = _currentPage == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.rarityCommon,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  // Page 1: Welcome
  Widget _buildWelcomePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Logo (Placeholder Icon for now)
        Icon(Icons.auto_stories_rounded, size: 100, color: AppColors.primary),
        const SizedBox(height: 32),
        Text('FlipWord', style: AppTextStyles.h1),
        const SizedBox(height: 16),
        Text(
          'Flip cards.\nSpark minds.',
          textAlign: TextAlign.center,
          style: AppTextStyles.h2.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }

  // Page 2: Tutorial
  Widget _buildTutorialPage() {
    // Mock Word for Demo
    final demoWord = Word(
       id: 0,
       text: 'Spark',
       definition: '火花 / 激发',
       phonetic: '/spɑːrk/',
       partOfSpeech: 'n.',
       rarity: 'common',
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Tap to Flip', style: AppTextStyles.h2),
        const SizedBox(height: 32),
        SizedBox(
          width: 200, 
          height: 280,
          child: FlipCard(word: demoWord),
        ),
        const SizedBox(height: 32),
        Text(
           'Remember & Collect', 
           style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)
        ),
      ],
    );
  }

  // Page 3: The Gift
  Widget _buildGiftPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Your Journey Begins', style: AppTextStyles.h2),
        const SizedBox(height: 48),
        
        // Gift Box Visual
        Stack(
          alignment: Alignment.center,
          children: [
             Container(
               width: 150, height: 150,
               decoration: BoxDecoration(
                 color: AppColors.primary.withOpacity(0.1),
                 shape: BoxShape.circle,
               ),
             ),
             Icon(Icons.card_giftcard_rounded, size: 80, color: AppColors.primary),
          ],
        ),
        
        const SizedBox(height: 48),
        
        ElevatedButton(
          onPressed: _finishOnboarding,
          child: const Text('OPEN MY FIRST PACK'),
        ),
      ],
    );
  }

  void _finishOnboarding() async {
    // 1. Mark as completed
    await PreferencesService().completeOnboarding();

    if (!mounted) return;

    // 2. Navigate to MainScreen logic
    // We want the user to end up on MainScreen, but first see the PackOpening.
    // So we push MainScreen as the base, then push PackOpening on top.
    
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const MainScreen()),
      (route) => false,
    );
    
    // 3. Trigger Pack Opening immediately
    Navigator.of(context).push(
       MaterialPageRoute(builder: (context) => const PackOpeningScreen()),
    );
  }
}
