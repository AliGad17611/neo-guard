import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedStarfield extends StatefulWidget {
  const AnimatedStarfield({super.key});

  @override
  State<AnimatedStarfield> createState() => _AnimatedStarfieldState();
}

class _AnimatedStarfieldState extends State<AnimatedStarfield>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Generate random stars
    final random = Random();
    for (int i = 0; i < 100; i++) {
      _stars.add(Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3,
        opacity: 0.3 + random.nextDouble() * 0.7,
        duration: 2 + random.nextDouble() * 3,
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: StarfieldPainter(
            stars: _stars,
            animation: _controller.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double duration;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.duration,
  });
}

class StarfieldPainter extends CustomPainter {
  final List<Star> stars;
  final double animation;

  StarfieldPainter({
    required this.stars,
    required this.animation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (final star in stars) {
      final phase = (animation * star.duration) % 1.0;
      final opacity = star.opacity * (0.5 + 0.5 * sin(phase * 2 * pi));

      paint.color = Colors.white.withValues(alpha:opacity);
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StarfieldPainter oldDelegate) => true;
}