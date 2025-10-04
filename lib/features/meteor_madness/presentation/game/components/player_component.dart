import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'planet_component.dart';
import 'laser_projectile.dart';
import 'cannon_upgrade_system.dart';
import 'weapon_system.dart';

class PlayerComponent extends PositionComponent {
  final PlanetComponent planet;
  final double orbitRadius;
  final Function(Vector2 position, Vector2 direction)? onShoot;
  CannonUpgradeSystem? upgradeSystem;
  WeaponType currentWeapon = WeaponType.standardLaser;
  int currentWave = 1;

  @override
  double angle = 0;
  double targetAngle = 0;
  final double rotationSpeed = 4.0; // radians per second
  double lastShotTime = 0;

  PlayerComponent({
    required this.planet,
    required this.orbitRadius,
    this.onShoot,
    this.upgradeSystem,
  }) : super(size: Vector2.all(30), anchor: Anchor.center);

  /// Change the current weapon
  void setWeapon(WeaponType weapon) {
    currentWeapon = weapon;
  }

  /// Update current wave for weapon scaling
  void setWave(int wave) {
    currentWave = wave;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update position based on orbit
    position =
        planet.position +
        Vector2(cos(angle) * orbitRadius, sin(angle) * orbitRadius);

    // Smooth rotation toward target
    final angleDiff = _shortestAngleDiff(angle, targetAngle);
    if (angleDiff.abs() > 0.01) {
      angle += angleDiff.sign * rotationSpeed * dt;
    }
  }

  void shootAtTarget(Vector2 target) {
    final currentTime = DateTime.now().millisecondsSinceEpoch / 1000.0;

    // Get current weapon data
    final weaponData = WeaponRegistry.getWeapon(currentWeapon);

    if (currentTime - lastShotTime < weaponData.fireRate) return;

    lastShotTime = currentTime;

    // Calculate base direction to target
    final baseDirection = (target - position).normalized();

    // Get weapon stats with wave scaling
    final projectileCount = weaponData.projectileCount;
    final spreadAngle = weaponData.spreadAngle;
    final damage = weaponData.getDamage(currentWave);
    final speed = weaponData.getSpeed(currentWave);
    final pierceCount = weaponData.pierceCount;
    final sizeMultiplier = weaponData.sizeMultiplier;

    // Create multiple projectiles if weapon supports it
    for (int i = 0; i < projectileCount; i++) {
      Vector2 direction;

      if (projectileCount == 1) {
        direction = baseDirection;
      } else {
        // Calculate spread angle for this projectile
        final angleOffset =
            spreadAngle *
            (i - (projectileCount - 1) / 2) /
            (projectileCount > 1 ? (projectileCount - 1) / 2 : 1);
        // Use angle from +X axis to the base direction so spread offsets rotate correctly toward tap
        final baseAngle = Vector2(1, 0).angleToSigned(baseDirection);
        final newAngle = baseAngle + angleOffset;
        direction = Vector2(cos(newAngle), sin(newAngle)).normalized();
      }

      // Create laser projectile with weapon stats
      final laser = LaserProjectile(
        startPosition: position.clone(),
        direction: direction,
        speed: speed,
        damage: damage,
        maxPierceCount: pierceCount,
        sizeMultiplier: sizeMultiplier,
        color: weaponData.color,
        glowColor: weaponData.glowColor,
      );
      parent?.add(laser);
    }

    onShoot?.call(position, baseDirection);
  }

  void moveToward(Vector2 target) {
    targetAngle = (target - planet.position).angleToSigned(Vector2(1, 0));
  }

  double _shortestAngleDiff(double from, double to) {
    var diff = to - from;
    while (diff > pi) {
      diff -= 2 * pi;
    }
    while (diff < -pi) {
      diff += 2 * pi;
    }
    return diff;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final center = size / 2;
    final weaponData = WeaponRegistry.getWeapon(currentWeapon);

    // Size scale based on weapon type
    final sizeScale = 1.0 + (weaponData.sizeMultiplier - 1.0) * 0.5;

    // Draw ship body (curved dart-like shape)
    final path = Path();
    final noseX = center.x + 16 * sizeScale;
    final tailX = center.x - 14 * sizeScale;
    final topY = center.y - 9 * sizeScale;
    final bottomY = center.y + 9 * sizeScale;

    // Hull with smooth bezier curves
    path.moveTo(noseX, center.y);
    path.quadraticBezierTo(
      center.x + 4 * sizeScale,
      topY - 6 * sizeScale,
      center.x - 4 * sizeScale,
      topY,
    );
    path.quadraticBezierTo(tailX, center.y, center.x - 4 * sizeScale, bottomY);
    path.quadraticBezierTo(
      center.x + 4 * sizeScale,
      bottomY + 6 * sizeScale,
      noseX,
      center.y,
    );
    path.close();

    // Add small fin details
    final finPath = Path()
      ..moveTo(center.x - 8 * sizeScale, center.y)
      ..quadraticBezierTo(
        center.x - 16 * sizeScale,
        center.y - 2 * sizeScale,
        center.x - 10 * sizeScale,
        center.y - 6 * sizeScale,
      )
      ..quadraticBezierTo(
        center.x - 6 * sizeScale,
        center.y - 2 * sizeScale,
        center.x - 8 * sizeScale,
        center.y,
      )
      ..close();

    // Rotate to face outward
    canvas.save();
    canvas.translate(center.x, center.y);
    canvas.rotate(angle + pi / 2);
    canvas.translate(-center.x, -center.y);

    // Use weapon color for ship
    final shipColor = weaponData.color;

    final paint = Paint()
      ..color = shipColor
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
    final finPaint = Paint()
      ..color = shipColor.withValues(alpha: 0.8)
      ..style = PaintingStyle.fill;
    canvas.drawPath(finPath, finPaint);

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, outlinePaint);
    canvas.drawPath(finPath, outlinePaint);

    // Add glow effect
    final glowPaint = Paint()
      ..color = weaponData.glowColor.withValues(alpha: 0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10.0);
    canvas.drawPath(path, glowPaint);
    canvas.drawPath(finPath, glowPaint);

    // Draw multi-cannon indicators
    final projectileCount = weaponData.projectileCount;
    if (projectileCount > 1) {
      final indicatorPaint = Paint()
        ..color = weaponData.glowColor
        ..style = PaintingStyle.fill;

      // Draw small dots to indicate number of shots
      for (int i = 0; i < min(projectileCount, 5); i++) {
        final xPos = center.x - 8 + (i * 4);
        canvas.drawCircle(
          Offset(xPos * sizeScale, (center.y + 8) * sizeScale),
          1.5,
          indicatorPaint,
        );
      }
    }

    // Draw pierce indicator
    if (weaponData.pierceCount > 0) {
      final piercePaint = Paint()
        ..color = weaponData.glowColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      for (int i = 0; i < min(weaponData.pierceCount, 3); i++) {
        canvas.drawCircle(
          Offset(center.x + 12 * sizeScale, center.y),
          3.0 + (i * 2.0),
          piercePaint,
        );
      }
    }

    canvas.restore();
  }
}
