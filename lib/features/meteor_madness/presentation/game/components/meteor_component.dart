import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

enum MeteorType { small, medium, large, exploding, ultraFast }

class MeteorComponent extends PositionComponent with CollisionCallbacks {
  final Vector2 target;
  final MeteorType type;
  final Function(int points)? onDestroyed;
  final Function(int damage)? onPlanetHit;
  final double speedMultiplier;
  final double healthMultiplier;

  late Vector2 velocity;
  int health;
  final int damage;
  final int pointValue;
  final double speed;
  double rotationAngle = 0;
  final double rotationSpeed;

  MeteorComponent({
    required Vector2 startPosition,
    required this.target,
    required this.type,
    this.onDestroyed,
    this.onPlanetHit,
    this.speedMultiplier = 1.0,
    this.healthMultiplier = 1.0,
  }) : health = (_getHealthForType(type) * healthMultiplier).round(),
       damage = _getDamageForType(type),
       pointValue = _getPointsForType(type),
       speed = _getSpeedForType(type) * speedMultiplier,
       rotationSpeed = Random().nextDouble() * 2 - 1,
       super(
         position: startPosition,
         size: Vector2.all(_getSizeForType(type)),
         anchor: Anchor.center,
       ) {
    velocity = (target - position).normalized() * speed;
    add(CircleHitbox());
  }

  static int _getHealthForType(MeteorType type) {
    switch (type) {
      case MeteorType.small:
        return 10;
      case MeteorType.medium:
        return 30;
      case MeteorType.large:
        return 60;
      case MeteorType.exploding:
        return 40;
      case MeteorType.ultraFast:
        return 20;
    }
  }

  static int _getDamageForType(MeteorType type) {
    switch (type) {
      case MeteorType.small:
        return 5;
      case MeteorType.medium:
        return 15;
      case MeteorType.large:
        return 30;
      case MeteorType.exploding:
        return 20;
      case MeteorType.ultraFast:
        return 10;
    }
  }

  static int _getPointsForType(MeteorType type) {
    switch (type) {
      case MeteorType.small:
        return 10;
      case MeteorType.medium:
        return 25;
      case MeteorType.large:
        return 50;
      case MeteorType.exploding:
        return 75;
      case MeteorType.ultraFast:
        return 100;
    }
  }

  static double _getSpeedForType(MeteorType type) {
    switch (type) {
      case MeteorType.small:
        return 150;
      case MeteorType.medium:
        return 100;
      case MeteorType.large:
        return 80;
      case MeteorType.exploding:
        return 100;
      case MeteorType.ultraFast:
        return 250;
    }
  }

  static double _getSizeForType(MeteorType type) {
    switch (type) {
      case MeteorType.small:
        return 25;
      case MeteorType.medium:
        return 40;
      case MeteorType.large:
        return 60;
      case MeteorType.exploding:
        return 35;
      case MeteorType.ultraFast:
        return 20;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;
    rotationAngle += rotationSpeed * dt;

    // Check if hit planet
    if (position.distanceTo(target) < 60) {
      onPlanetHit?.call(damage);
      removeFromParent();
    }

    // Remove if off screen
    if (_isOffScreen()) {
      removeFromParent();
    }
  }

  void takeDamage(int damageAmount) {
    health -= damageAmount;
    if (health <= 0) {
      destroy();
    }
  }

  void destroy() {
    onDestroyed?.call(pointValue);
    removeFromParent();
  }

  bool _isOffScreen() {
    if (parent == null) return false;
    final gameSize = (parent is FlameGame)
        ? (parent as FlameGame).size
        : Vector2(1000, 1000);
    return position.x < -100 ||
        position.x > gameSize.x + 100 ||
        position.y < -100 ||
        position.y > gameSize.y + 100;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.save();
    canvas.translate(size.x / 2, size.y / 2);
    canvas.rotate(rotationAngle);
    canvas.translate(-size.x / 2, -size.y / 2);

    final paint = Paint()
      ..color = _getColorForType()
      ..style = PaintingStyle.fill;

    // Draw meteor as polygon
    final path = _getMeteorPath();
    canvas.drawPath(path, paint);

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(path, outlinePaint);

    // Special glow for special meteors
    if (type == MeteorType.exploding) {
      final glowPaint = Paint()
        ..color = Colors.red.withValues(alpha: 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
      canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, glowPaint);
    } else if (type == MeteorType.ultraFast) {
      final glowPaint = Paint()
        ..color = Colors.blue.withValues(alpha: 0.5)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawCircle(Offset(size.x / 2, size.y / 2), size.x / 2, glowPaint);
    }

    canvas.restore();
  }

  Path _getMeteorPath() {
    final center = size / 2;
    final radius = size.x / 2;
    final path = Path();

    // Create irregular polygon for meteor
    final points = 8;
    for (int i = 0; i < points; i++) {
      final angle = (i / points) * 2 * pi;
      final r = radius * (0.7 + Random().nextDouble() * 0.3);
      final x = center.x + cos(angle) * r;
      final y = center.y + sin(angle) * r;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    return path;
  }

  Color _getColorForType() {
    switch (type) {
      case MeteorType.small:
      case MeteorType.medium:
      case MeteorType.large:
        return const Color(0xFF8B7355);
      case MeteorType.exploding:
        return const Color(0xFFFF4500);
      case MeteorType.ultraFast:
        return const Color(0xFF00BFFF);
    }
  }
}
