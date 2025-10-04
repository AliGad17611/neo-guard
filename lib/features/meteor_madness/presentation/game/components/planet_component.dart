import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PlanetComponent extends PositionComponent {
  final double radius;
  int health = 100;
  final int maxHealth = 100;

  // Shield system
  bool shieldActive = false;
  double shieldCooldown = 0;
  final double shieldDuration = 5.0;
  final double shieldMaxCooldown = 15.0;
  double shieldTimer = 0;

  PlanetComponent({required Vector2 position, required this.radius})
    : super(
        position: position,
        size: Vector2.all(radius * 2),
        anchor: Anchor.center,
      );

  void takeDamage(int damage) {
    if (shieldActive) {
      // Shield blocks damage
      return;
    }
    health = (health - damage).clamp(0, maxHealth);
  }

  void activateShield() {
    if (shieldCooldown <= 0 && !shieldActive) {
      shieldActive = true;
      shieldTimer = shieldDuration;
      shieldCooldown = shieldMaxCooldown;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update shield timer
    if (shieldActive) {
      shieldTimer -= dt;
      if (shieldTimer <= 0) {
        shieldActive = false;
      }
    }

    // Update cooldown
    if (shieldCooldown > 0) {
      shieldCooldown -= dt;
      if (shieldCooldown < 0) {
        shieldCooldown = 0;
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw planet with gradient
    final center = size / 2;
    final gradient = RadialGradient(
      colors: [
        const Color(0xFF60A5FA), // Blue
        const Color(0xFF3B82F6),
        const Color(0xFF2563EB),
      ],
    );

    final paint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: Offset(center.x, center.y), radius: radius),
      );

    canvas.drawCircle(Offset(center.x, center.y), radius, paint);

    // Draw health indicator (cracks if damaged)
    if (health < maxHealth) {
      final crackPaint = Paint()
        ..color = Colors.red.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawCircle(Offset(center.x, center.y), radius * 0.9, crackPaint);
    }

    // Draw shield if active
    if (shieldActive) {
      final shieldPaint = Paint()
        ..color = const Color(0xFF00FFD4).withValues(alpha: 0.6)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4;

      canvas.drawCircle(Offset(center.x, center.y), radius + 15, shieldPaint);

      final shieldGlowPaint = Paint()
        ..color = const Color(0xFF00FFD4).withValues(alpha: 0.3)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

      canvas.drawCircle(
        Offset(center.x, center.y),
        radius + 15,
        shieldGlowPaint,
      );
    }

    // Draw atmosphere glow
    final glowPaint = Paint()
      ..color = const Color(0xFF60A5FA).withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawCircle(Offset(center.x, center.y), radius + 5, glowPaint);
  }
}
