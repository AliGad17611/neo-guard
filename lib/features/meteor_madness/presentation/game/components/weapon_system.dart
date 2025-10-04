import 'package:flutter/material.dart';

/// Types of weapons available
enum WeaponType {
  standardLaser,
  rapidFire,
  heavyCannon,
  spreadShot,
  piercingLaser,
  plasmaCannon,
}

/// Weapon configuration data
class WeaponData {
  final WeaponType type;
  final String name;
  final String description;
  final double fireRate;
  final int baseDamage;
  final double projectileSpeed;
  final int projectileCount;
  final double spreadAngle;
  final int pierceCount;
  final double sizeMultiplier;
  final Color color;
  final Color glowColor;
  final IconData icon;
  final int unlockWave;

  const WeaponData({
    required this.type,
    required this.name,
    required this.description,
    required this.fireRate,
    required this.baseDamage,
    required this.projectileSpeed,
    required this.projectileCount,
    this.spreadAngle = 0.0,
    this.pierceCount = 0,
    this.sizeMultiplier = 1.0,
    required this.color,
    required this.glowColor,
    required this.icon,
    this.unlockWave = 1,
  });

  /// Get damage with wave scaling
  int getDamage(int wave) {
    // Scale damage by 20% per 5 waves
    final scaling = 1.0 + ((wave - 1) ~/ 5) * 0.2;
    return (baseDamage * scaling).round();
  }

  /// Get speed with wave scaling
  double getSpeed(int wave) {
    // Scale speed by 10% per 10 waves
    final scaling = 1.0 + ((wave - 1) ~/ 10) * 0.1;
    return projectileSpeed * scaling;
  }
}

/// Available weapons configuration
class WeaponRegistry {
  static const Map<WeaponType, WeaponData> weapons = {
    WeaponType.standardLaser: WeaponData(
      type: WeaponType.standardLaser,
      name: 'Standard Laser',
      description: 'Balanced damage and fire rate',
      fireRate: 0.15,
      baseDamage: 15,
      projectileSpeed: 500,
      projectileCount: 1,
      sizeMultiplier: 1.0,
      color: Color(0xFF00D4FF),
      glowColor: Color(0xFF00FFFF),
      icon: Icons.flash_on,
      unlockWave: 1,
    ),
    WeaponType.rapidFire: WeaponData(
      type: WeaponType.rapidFire,
      name: 'Rapid Fire',
      description: 'Fast shooting, lower damage',
      fireRate: 0.08,
      baseDamage: 8,
      projectileSpeed: 600,
      projectileCount: 1,
      sizeMultiplier: 0.8,
      color: Color(0xFFFFD700),
      glowColor: Color(0xFFFFFF00),
      icon: Icons.speed,
      unlockWave: 3,
    ),
    WeaponType.heavyCannon: WeaponData(
      type: WeaponType.heavyCannon,
      name: 'Heavy Cannon',
      description: 'Slow but devastating damage',
      fireRate: 0.35,
      baseDamage: 40,
      projectileSpeed: 400,
      projectileCount: 1,
      sizeMultiplier: 1.5,
      color: Color(0xFFFF4500),
      glowColor: Color(0xFFFF6347),
      icon: Icons.local_fire_department,
      unlockWave: 5,
    ),
    WeaponType.spreadShot: WeaponData(
      type: WeaponType.spreadShot,
      name: 'Spread Shot',
      description: 'Fires multiple projectiles',
      fireRate: 0.20,
      baseDamage: 10,
      projectileSpeed: 450,
      projectileCount: 5,
      spreadAngle: 0.5,
      sizeMultiplier: 0.9,
      color: Color(0xFF9D00FF),
      glowColor: Color(0xFFBF40FF),
      icon: Icons.apps,
      unlockWave: 8,
    ),
    WeaponType.piercingLaser: WeaponData(
      type: WeaponType.piercingLaser,
      name: 'Piercing Laser',
      description: 'Pierces through multiple enemies',
      fireRate: 0.18,
      baseDamage: 12,
      projectileSpeed: 550,
      projectileCount: 1,
      pierceCount: 5,
      sizeMultiplier: 1.2,
      color: Color(0xFF00FFD4),
      glowColor: Color(0xFF00FFE5),
      icon: Icons.straight,
      unlockWave: 10,
    ),
    WeaponType.plasmaCannon: WeaponData(
      type: WeaponType.plasmaCannon,
      name: 'Plasma Cannon',
      description: 'Triple shot with pierce',
      fireRate: 0.25,
      baseDamage: 18,
      projectileSpeed: 500,
      projectileCount: 3,
      spreadAngle: 0.3,
      pierceCount: 2,
      sizeMultiplier: 1.3,
      color: Color(0xFFFF00FF),
      glowColor: Color(0xFFFF69B4),
      icon: Icons.auto_awesome,
      unlockWave: 15,
    ),
  };

  /// Get weapon data by type
  static WeaponData getWeapon(WeaponType type) {
    return weapons[type]!;
  }

  /// Get all unlocked weapons for current wave
  static List<WeaponData> getUnlockedWeapons(int currentWave) {
    return weapons.values
        .where((weapon) => weapon.unlockWave <= currentWave)
        .toList()
      ..sort((a, b) => a.unlockWave.compareTo(b.unlockWave));
  }

  /// Check if weapon is unlocked
  static bool isUnlocked(WeaponType type, int currentWave) {
    return weapons[type]!.unlockWave <= currentWave;
  }
}
