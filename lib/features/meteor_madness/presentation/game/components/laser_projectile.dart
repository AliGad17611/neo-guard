import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'meteor_component.dart';

class LaserProjectile extends PositionComponent with CollisionCallbacks {
  final Vector2 direction;
  final double speed;
  final int damage;
  final int maxPierceCount;
  final double sizeMultiplier;
  final Color color;
  final Color glowColor;
  int currentPierceCount = 0;

  LaserProjectile({
    required Vector2 startPosition,
    required this.direction,
    this.speed = 400,
    this.damage = 10,
    this.maxPierceCount = 0,
    this.sizeMultiplier = 1.0,
    this.color = const Color(0xFF00D4FF),
    this.glowColor = const Color(0xFF00FFFF),
  }) : super(
         position: startPosition,
         size: Vector2(20 * sizeMultiplier, 6 * sizeMultiplier),
         anchor: Anchor.center,
       ) {
    angle = direction.angleToSigned(Vector2(1, 0));
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += direction * speed * dt;

    // Remove if off screen
    if (parent != null) {
      final gameSize = (parent is FlameGame)
          ? (parent as FlameGame).size
          : Vector2(1000, 1000);
      if (position.x < -50 ||
          position.x > gameSize.x + 50 ||
          position.y < -50 ||
          position.y > gameSize.y + 50) {
        removeFromParent();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is MeteorComponent) {
      other.takeDamage(damage);
      currentPierceCount++;

      // Only remove if we've exceeded pierce count
      if (currentPierceCount > maxPierceCount) {
        removeFromParent();
      }
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Draw laser beam with weapon color
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.x, size.y),
        Radius.circular(3 * sizeMultiplier),
      ),
      paint,
    );

    // Draw enhanced glow
    final glowIntensity = 5.0 + (maxPierceCount * 2.0) + (sizeMultiplier * 2.0);
    final glowPaint = Paint()
      ..color = glowColor.withValues(alpha: 0.6)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, glowIntensity);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(-2, -2, size.x + 4, size.y + 4),
        Radius.circular(5 * sizeMultiplier),
      ),
      glowPaint,
    );

    // Add core glow for piercing or large projectiles
    if (maxPierceCount >= 2 || sizeMultiplier >= 1.3) {
      final corePaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.7)
        ..style = PaintingStyle.fill;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            size.x * 0.25,
            size.y * 0.25,
            size.x * 0.5,
            size.y * 0.5,
          ),
          Radius.circular(2 * sizeMultiplier),
        ),
        corePaint,
      );
    }
  }
}
