import 'package:flutter/material.dart';
import 'package:flip_word/shared/cards/cards.dart';
import 'package:flip_word/data/models/models.dart' as models;
import 'package:flip_word/core/theme/app_theme.dart';

/// 卡片组件演示页面
/// 用于测试 FlipCard 的翻转效果
class CardDemoPage extends StatelessWidget {
  const CardDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 创建测试数据
    final testWords = [
      models.Word(
        id: 1,
        text: 'run',
        phonetic: '/rʌn/',
        definition: '跑；奔跑；运转',
        partOfSpeech: 'v.',
        rarity: 'common',
        themeId: 1,
        forms: {
          'past': 'ran',
          'past_participle': 'run',
          'present_participle': 'running',
        },
      ),
      models.Word(
        id: 2,
        text: 'beautiful',
        phonetic: '/ˈbjuːtɪfəl/',
        definition: '美丽的；漂亮的',
        partOfSpeech: 'adj.',
        rarity: 'rare',
        themeId: 1,
        forms: {
          'comparative': 'more beautiful',
          'superlative': 'most beautiful',
        },
      ),
      models.Word(
        id: 3,
        text: 'wisdom',
        phonetic: '/ˈwɪzdəm/',
        definition: '智慧；才智；明智',
        partOfSpeech: 'n.',
        rarity: 'epic',
        themeId: 2,
        forms: {
          'plural': 'wisdoms',
        },
      ),
      models.Word(
        id: 4,
        text: 'extraordinary',
        phonetic: '/ɪkˈstrɔːdəneri/',
        definition: '非凡的；特别的；离奇的',
        partOfSpeech: 'adj.',
        rarity: 'legend',
        themeId: 2,
        forms: null,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlipCard 演示'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: testWords.length,
        itemBuilder: (context, index) {
          final word = testWords[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${word.text} (${word.rarity})',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 400,
                  child: Center(
                    child: SizedBox(
                      width: 280,
                      child: FlipCard(
                        word: word,
                        onFlip: () {
                          debugPrint('Card flipped: ${word.text}');
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const CardDemoApp());
}

class CardDemoApp extends StatelessWidget {
  const CardDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipCard Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const CardDemoPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
