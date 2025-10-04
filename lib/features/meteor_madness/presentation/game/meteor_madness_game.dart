import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'components/planet_component.dart';
import 'components/player_component.dart';
import 'components/meteor_component.dart';
import 'components/starfield_component.dart';
import 'components/cannon_upgrade_system.dart';
import 'components/weapon_system.dart';
import '../screens/level_selection_page.dart';

class MeteorMadnessGame extends FlameGame
    with HasCollisionDetection, TapDetector {
  late PlayerComponent player;
  late CannonUpgradeSystem cannonUpgrades;
  WeaponType currentWeapon = WeaponType.standardLaser;
  PlanetComponent? _planet;
  late final Random random;
  final GameDifficulty difficulty;

  // Safe access to planet
  PlanetComponent get planet => _planet!;

  // Safe getters for shield properties
  bool get shieldActive => _planet?.shieldActive ?? false;
  double get shieldCooldown => _planet?.shieldCooldown ?? 0.0;

  // Shield activation method
  void activateShield() => _planet?.activateShield();

  int currentWave = 1;
  int score = 0;
  int combo = 0;
  int meteorsDestroyed = 0;
  int meteorsToSpawn = 5;
  double spawnTimer = 0;
  final double spawnInterval = 2.0;

  // Callbacks for UI updates
  Function(int score, int combo, int health, int wave)? onGameStateUpdate;
  Function()? onGameOver;
  Function(int wave)? onWaveComplete;

  MeteorMadnessGame({this.difficulty = GameDifficulty.normal}) {
    random = Random();
    cannonUpgrades = CannonUpgradeSystem(currentWave: 1);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Add starfield background
    add(StarfieldComponent());

    // Add planet at center
    _planet = PlanetComponent(position: size / 2, radius: 60);
    add(_planet!);

    // Add player ship with upgrade system
    player = PlayerComponent(
      planet: _planet!,
      orbitRadius: 180,
      onShoot: _handleShoot,
      upgradeSystem: cannonUpgrades,
    );
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update spawn timer
    if (meteorsToSpawn > 0) {
      spawnTimer += dt;
      if (spawnTimer >= spawnInterval) {
        spawnMeteor();
        meteorsToSpawn--;
        spawnTimer = 0;
      }
    }

    // Check for wave completion
    if (meteorsToSpawn == 0 && children.whereType<MeteorComponent>().isEmpty) {
      _completeWave();
    }

    // Update UI
    if (_planet != null) {
      onGameStateUpdate?.call(score, combo, _planet!.health, currentWave);

      // Check game over
      if (_planet!.health <= 0) {
        onGameOver?.call();
        pauseEngine();
      }
    }
  }

  void spawnMeteor() {
    final angle = random.nextDouble() * 2 * pi;
    final distance = max(size.x, size.y) / 2 + 100;
    final position = Vector2(
      size.x / 2 + cos(angle) * distance,
      size.y / 2 + sin(angle) * distance,
    );

    final meteorType = _getRandomMeteorType();
    final meteor = MeteorComponent(
      startPosition: position,
      target: size / 2,
      type: meteorType,
      onDestroyed: _handleMeteorDestroyed,
      onPlanetHit: _handlePlanetHit,
      speedMultiplier: difficulty.speedMultiplier,
      healthMultiplier: difficulty.meteorHealthMultiplier,
    );
    add(meteor);
  }

  MeteorType _getRandomMeteorType() {
    final value = random.nextDouble();
    if (currentWave >= 5 && value < 0.1) {
      return MeteorType.ultraFast;
    } else if (currentWave >= 3 && value < 0.2) {
      return MeteorType.exploding;
    } else if (value < 0.5) {
      return MeteorType.small;
    } else if (value < 0.8) {
      return MeteorType.medium;
    } else {
      return MeteorType.large;
    }
  }

  void _handleShoot(Vector2 position, Vector2 direction) {
    // Shooting is handled by the player component
  }

  void _handleMeteorDestroyed(int points) {
    score += points;
    combo++;
    meteorsDestroyed++;
  }

  void _handlePlanetHit(int damage) {
    final adjustedDamage = (damage * difficulty.damageMultiplier).round();
    _planet?.takeDamage(adjustedDamage);
    combo = 0; // Reset combo on planet hit
  }

  void _completeWave() {
    onWaveComplete?.call(currentWave);
    currentWave++;
    meteorsToSpawn = 5 + (currentWave * 2);

    // Update cannon upgrades for new wave
    cannonUpgrades.updateWave(currentWave);

    // Update player wave for weapon scaling
    player.setWave(currentWave);
  }

  /// Change the current weapon
  void changeWeapon(WeaponType weapon) {
    if (WeaponRegistry.isUnlocked(weapon, currentWave)) {
      currentWeapon = weapon;
      player.setWeapon(weapon);
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Use global (world) position provided by event for aiming
    player.shootAtTarget(info.eventPosition.global);
  }
}
