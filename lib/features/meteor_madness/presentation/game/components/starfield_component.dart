import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class StarfieldComponent extends Component {
  final List<Star> stars = [];
  final Random random = Random();
  final int starCount = 200;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Generate stars
    for (int i = 0; i < starCount; i++) {
      stars.add(
        Star(
          position: Vector2(
            random.nextDouble() * 1000,
            random.nextDouble() * 1000,
          ),
          size: random.nextDouble() * 2 + 1,
          opacity: random.nextDouble() * 0.8 + 0.2,
          twinkleSpeed: random.nextDouble() * 2,
        ),
      );
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update star twinkle
    for (final star in stars) {
      star.twinklePhase += star.twinkleSpeed * dt;
      if (star.twinklePhase > 2 * pi) {
        star.twinklePhase -= 2 * pi;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()..color = Colors.white;

    for (final star in stars) {
      final opacity = star.opacity + sin(star.twinklePhase) * 0.2;
      paint.color = Colors.white.withValues(alpha: opacity.clamp(0.0, 1.0));
      canvas.drawCircle(
        Offset(star.position.x, star.position.y),
        star.size,
        paint,
      );
    }
  }
}

class Star {
  Vector2 position;
  double size;
  double opacity;
  double twinkleSpeed;
  double twinklePhase;

  Star({
    required this.position,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
  }) : twinklePhase = 0;
}
