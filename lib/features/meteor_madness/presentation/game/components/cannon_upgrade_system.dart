import 'dart:math';

/// Manages the cannon upgrade system based on wave progression
class CannonUpgradeSystem {
  int currentWave;

  CannonUpgradeSystem({this.currentWave = 1});

  /// Base fire rate (seconds between shots)
  double get fireRate {
    // Starts at 0.2s, decreases to min 0.05s at wave 20+
    final baseRate = 0.2;
    final improvement = min(currentWave - 1, 20) * 0.0075;
    return max(baseRate - improvement, 0.05);
  }

  /// Laser damage
  int get damage {
    // Starts at 10, increases by 3 per wave, caps at 100
    return min(10 + (currentWave - 1) * 3, 100);
  }

  /// Laser speed
  double get projectileSpeed {
    // Starts at 400, increases to 800 at wave 15+
    final baseSpeed = 400.0;
    final improvement = min(currentWave - 1, 15) * 25.0;
    return baseSpeed + improvement;
  }

  /// Laser size multiplier
  double get projectileSizeMultiplier {
    // Starts at 1.0, increases to 2.0 at wave 10+
    return 1.0 + min(currentWave - 1, 10) * 0.1;
  }

  /// Number of projectiles to shoot
  int get projectileCount {
    if (currentWave >= 15) return 5; // Spread shot of 5
    if (currentWave >= 10) return 3; // Triple shot
    if (currentWave >= 5) return 2; // Double shot
    return 1; // Single shot
  }

  /// Spread angle for multi-shot (in radians)
  double get spreadAngle {
    if (projectileCount >= 5) return 0.4; // ~23 degrees spread
    if (projectileCount >= 3) return 0.3; // ~17 degrees spread
    if (projectileCount >= 2) return 0.2; // ~11 degrees spread
    return 0.0;
  }

  /// Pierce count (how many meteors a laser can go through)
  int get pierceCount {
    if (currentWave >= 20) return 3;
    if (currentWave >= 12) return 2;
    if (currentWave >= 7) return 1;
    return 0;
  }

  /// Get upgrade level (1-5 based on wave)
  int get upgradeLevel {
    if (currentWave >= 20) return 5;
    if (currentWave >= 15) return 4;
    if (currentWave >= 10) return 3;
    if (currentWave >= 5) return 2;
    return 1;
  }

  /// Get upgrade description for current level
  String get upgradeDescription {
    switch (upgradeLevel) {
      case 5:
        return 'ULTIMATE CANNON: 5-Shot Spread, Max Pierce';
      case 4:
        return 'ADVANCED CANNON: 5-Shot Spread';
      case 3:
        return 'TRIPLE CANNON: 3-Shot';
      case 2:
        return 'DUAL CANNON: 2-Shot';
      default:
        return 'STANDARD CANNON';
    }
  }

  /// Update to new wave
  void updateWave(int wave) {
    currentWave = wave;
  }

  /// Get stats summary
  Map<String, dynamic> getStats() {
    return {
      'fireRate': fireRate,
      'damage': damage,
      'projectileSpeed': projectileSpeed,
      'projectileCount': projectileCount,
      'pierceCount': pierceCount,
      'upgradeLevel': upgradeLevel,
    };
  }
}
