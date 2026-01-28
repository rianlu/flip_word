import 'package:flutter/material.dart';
import '../../data/models/word.dart';
import '../widgets/universal_card_face.dart'; // Correct import
import 'dart:math' as math;
import '../../../core/services/sound_service.dart';

/// 可翻转的单词卡片组件
/// 
/// 实现文档二的 "The Flip" 动画：
/// - 时长：500ms
/// - 曲线：Curves.easeInOutBack（Q弹回弹）
/// - 3D 翻转效果 + 阴影变化
class FlipCard extends StatefulWidget {
  final Word word;
  final bool initialShowFront;
  final VoidCallback? onFlip;

  const FlipCard({
    super.key,
    required this.word,
    this.initialShowFront = true,
    this.onFlip,
  });

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _showFront = widget.initialShowFront;
    
    // 创建动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // 创建带 easeInOutBack 曲线的动画
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutBack,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_controller.isAnimating) return; // 防止动画进行时多次点击

    setState(() {
      _showFront = !_showFront;
    });

    if (_showFront) {
      // 从背面翻回正面
      _controller.reverse();
    } else {
      // 从正面翻到背面
      _controller.forward();
    }

    widget.onFlip?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SoundService().playFlip();
        _handleTap();
      },
      child: AspectRatio(
        aspectRatio: 2.5 / 3.5, // 卡片比例（类似扑克牌）
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            // 计算旋转角度（0 到 π）
            final angle = _animation.value * math.pi;
            
            // 判断是否显示背面（旋转超过 90 度）
            final isFrontVisible = angle < math.pi / 2;

            // 计算阴影深度（翻转时增加阴影，模拟卡片离屏飞起）
            final elevation = 4.0 + (8.0 * (1 - (angle / math.pi - 0.5).abs() * 2));

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001) // 透视效果
                ..rotateY(angle),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: elevation,
                      offset: Offset(0, elevation / 2),
                    ),
                  ],
                ),
                child: isFrontVisible
                    ? UniversalCardFace(word: widget.word, showMeaning: false)
                    : Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..rotateY(math.pi), // 翻转背面防止镜像
                        child: UniversalCardFace(word: widget.word, showMeaning: true),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
