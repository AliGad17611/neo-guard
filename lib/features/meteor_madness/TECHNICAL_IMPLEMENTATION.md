# Meteor Madness - Technical Implementation Guide

## 🏗️ Architecture Overview

### Technology Stack

```yaml
Framework: Flutter 3.x
Game Engine: Flame (Flutter game engine)
State Management: Riverpod / Bloc
Local Storage: Hive / Shared Preferences
Audio: audioplayers / flame_audio
Physics: Built-in Flame physics / Box2D
Animations: Flutter animations + Flame sprites
Analytics: Firebase Analytics (optional)
Leaderboards: Firebase/Supabase (optional)
```

### Project Structure

```
lib/features/meteor_madness/
├── data/
│   ├── datasources/
│   │   ├── local_storage_service.dart
│   │   └── leaderboard_service.dart
│   ├── models/
│   │   ├── save_data_model.dart
│   │   └── leaderboard_entry_model.dart
│   └── repositories/
│       └── game_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── meteor.dart
│   │   ├── weapon.dart
│   │   ├── power_up.dart
│   │   └── player_ship.dart
│   ├── repositories/
│   │   └── game_repository.dart
│   └── usecases/
│       ├── save_game_progress.dart
│       ├── load_game_progress.dart
│       └── update_leaderboard.dart
│
├── presentation/
│   ├── game/
│   │   ├── meteor_madness_game.dart (main Flame game)
│   │   ├── components/
│   │   │   ├── player_component.dart
│   │   │   ├── meteor_component.dart
│   │   │   ├── weapon_component.dart
│   │   │   ├── planet_component.dart
│   │   │   ├── power_up_component.dart
│   │   │   └── particle_effects.dart
│   │   ├── managers/
│   │   │   ├── wave_manager.dart
│   │   │   ├── spawn_manager.dart
│   │   │   ├── collision_manager.dart
│   │   │   └── score_manager.dart
│   │   └── systems/
│   │       ├── health_system.dart
│   │       ├── weapon_system.dart
│   │       └── upgrade_system.dart
│   │
│   ├── screens/
│   │   ├── main_menu_screen.dart
│   │   ├── game_screen.dart
│   │   ├── upgrade_screen.dart
│   │   ├── leaderboard_screen.dart
│   │   └── settings_screen.dart
│   │
│   ├── widgets/
│   │   ├── game_hud.dart
│   │   ├── health_bar.dart
│   │   ├── power_up_button.dart
│   │   ├── score_display.dart
│   │   └── upgrade_card.dart
│   │
│   └── providers/
│       ├── game_state_provider.dart
│       ├── upgrade_provider.dart
│       └── settings_provider.dart
│
└── utils/
    ├── constants.dart
    ├── game_config.dart
    └── audio_manager.dart
```

---

## 🎮 Core Game Implementation

### 1. Main Game Class

```dart
// lib/features/meteor_madness/presentation/game/meteor_madness_game.dart

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class MeteorMadnessGame extends FlameGame 
    with HasCollisionDetection, TapDetector, PanDetector {
  
  late PlayerComponent player;
  late PlanetComponent planet;
  late WaveManager waveManager;
  late SpawnManager spawnManager;
  late ScoreManager scoreManager;
  late CollisionManager collisionManager;
  
  // Game state
  int currentWave = 1;
  int score = 0;
  int combo = 0;
  GameState state = GameState.playing;
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Initialize managers
    waveManager = WaveManager(this);
    spawnManager = SpawnManager(this);
    scoreManager = ScoreManager(this);
    collisionManager = CollisionManager(this);
    
    // Add background
    add(StarfieldComponent());
    add(NebulaComponent());
    
    // Add planet/station
    planet = PlanetComponent(
      position: size / 2,
      radius: 80,
      maxHealth: 100,
    );
    add(planet);
    
    // Add player ship
    player = PlayerComponent(
      planet: planet,
      orbitRadius: 200,
    );
    add(player);
    
    // Add HUD overlay (handled in Flutter widget layer)
    
    // Start first wave
    waveManager.startWave(currentWave);
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update managers
    waveManager.update(dt);
    spawnManager.update(dt);
    scoreManager.update(dt);
    collisionManager.update(dt);
    
    // Check game state
    if (planet.health <= 0) {
      state = GameState.gameOver;
      pauseEngine();
    }
    
    if (waveManager.isWaveComplete && state == GameState.playing) {
      _advanceWave();
    }
  }
  
  void _advanceWave() {
    currentWave++;
    
    if (currentWave % 6 == 0) {
      // Boss wave
      waveManager.startBossWave(currentWave ~/ 6);
    } else {
      waveManager.startWave(currentWave);
    }
  }
  
  @override
  void onTapDown(TapDownInfo info) {
    player.shoot(info.eventPosition.game);
  }
  
  @override
  void onPanUpdate(PanUpdateInfo info) {
    player.moveToward(info.eventPosition.game);
  }
}

enum GameState { 
  playing, 
  paused, 
  gameOver, 
  waveComplete, 
  bossIntro 
}
```

### 2. Player Component

```dart
// lib/features/meteor_madness/presentation/game/components/player_component.dart

class PlayerComponent extends SpriteAnimationComponent 
    with HasGameRef<MeteorMadnessGame> {
  
  final PlanetComponent planet;
  final double orbitRadius;
  
  double angle = 0;
  double angularVelocity = 0;
  final double maxAngularVelocity = pi; // 180°/sec
  
  // Weapons
  late LaserWeapon laser;
  late MissileWeapon missile;
  Weapon? activeWeapon;
  
  // Stats
  int health = 100;
  double energy = 100;
  final double energyRegenRate = 10; // per second
  
  PlayerComponent({
    required this.planet,
    required this.orbitRadius,
  }) : super(
    size: Vector2(40, 40),
    anchor: Anchor.center,
  );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Load sprite animation
    animation = await gameRef.loadSpriteAnimation(
      'player_ship.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.1,
        textureSize: Vector2(64, 64),
      ),
    );
    
    // Initialize weapons
    laser = LaserWeapon(this);
    missile = MissileWeapon(this);
    activeWeapon = laser;
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update position based on orbit
    position = planet.position + Vector2(
      cos(angle) * orbitRadius,
      sin(angle) * orbitRadius,
    );
    
    // Update rotation to face outward
    angle += angularVelocity * dt;
    this.angle = angle + pi / 2; // Sprite rotation
    
    // Regenerate energy
    energy = min(100, energy + energyRegenRate * dt);
    
    // Update weapons
    laser.update(dt);
    missile.update(dt);
  }
  
  void moveClockwise() {
    angularVelocity = maxAngularVelocity;
  }
  
  void moveCounterClockwise() {
    angularVelocity = -maxAngularVelocity;
  }
  
  void stopMovement() {
    angularVelocity = 0;
  }
  
  void moveToward(Vector2 target) {
    final targetAngle = (target - planet.position).angleToSigned(Vector2(1, 0));
    final angleDiff = _shortestAngleDiff(angle, targetAngle);
    
    if (angleDiff.abs() > 0.1) {
      angularVelocity = angleDiff.sign * maxAngularVelocity;
    } else {
      angularVelocity = 0;
    }
  }
  
  void shoot(Vector2 target) {
    if (activeWeapon?.canFire() ?? false) {
      final direction = (target - position).normalized();
      activeWeapon!.fire(position, direction);
    }
  }
  
  void switchWeapon() {
    activeWeapon = activeWeapon == laser ? missile : laser;
  }
  
  double _shortestAngleDiff(double from, double to) {
    var diff = to - from;
    while (diff > pi) diff -= 2 * pi;
    while (diff < -pi) diff += 2 * pi;
    return diff;
  }
}
```

### 3. Meteor Component

```dart
// lib/features/meteor_madness/presentation/game/components/meteor_component.dart

class MeteorComponent extends SpriteComponent 
    with HasGameRef<MeteorMadnessGame>, CollisionCallbacks {
  
  final MeteorType type;
  final double speed;
  
  int health;
  final int maxHealth;
  final int damage;
  final int pointValue;
  
  late Vector2 velocity;
  Vector2 target;
  
  MeteorComponent({
    required this.type,
    required this.speed,
    required this.health,
    required this.damage,
    required this.pointValue,
    required Vector2 startPosition,
    required this.target,
  }) : maxHealth = health, super(
    position: startPosition,
    anchor: Anchor.center,
  );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    
    // Load sprite based on type and size
    sprite = await gameRef.loadSprite(_getSpriteForType());
    size = _getSizeForType();
    
    // Add collision hitbox
    add(CircleHitbox());
    
    // Calculate initial velocity
    velocity = (target - position).normalized() * speed;
    
    // Add visual effects based on type
    if (type == MeteorType.exploding) {
      add(PulsingGlowEffect(color: Colors.red));
    } else if (type == MeteorType.ultraFast) {
      add(TrailEffect(color: Colors.blue));
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update position
    position += velocity * dt;
    
    // Rotate meteor
    angle += 0.5 * dt;
    
    // Apply special movement patterns
    if (type == MeteorType.zigzag) {
      _applyZigzagPattern(dt);
    } else if (type == MeteorType.orbiting) {
      _applyOrbitPattern(dt);
    }
    
    // Check if off screen or hit planet
    if (_isOffScreen() || _hasHitPlanet()) {
      removeFromParent();
    }
  }
  
  void takeDamage(int amount) {
    health -= amount;
    
    // Visual feedback
    add(FlashEffect(
      duration: 0.1,
      color: Colors.white,
    ));
    
    // Damage particles
    gameRef.add(DamageParticleEffect(position: position, intensity: amount));
    
    // Check destruction
    if (health <= 0) {
      destroy();
    }
  }
  
  void destroy() {
    // Award points
    gameRef.scoreManager.addScore(pointValue);
    gameRef.scoreManager.incrementCombo();
    
    // Explosion effect
    gameRef.add(ExplosionEffect(
      position: position,
      size: size.x,
    ));
    
    // Play sound
    AudioManager.playSound('explosion_${_getSizeCategory()}.mp3');
    
    // Special behavior for exploding meteors
    if (type == MeteorType.exploding) {
      _createShockwave();
    } else if (type == MeteorType.split) {
      _spawnSplitMeteors();
    }
    
    removeFromParent();
  }
  
  void _createShockwave() {
    final shockwave = ShockwaveComponent(
      position: position,
      radius: 50,
      damage: 20,
    );
    gameRef.add(shockwave);
  }
  
  void _spawnSplitMeteors() {
    for (int i = 0; i < 3; i++) {
      final angle = (i * 120) * pi / 180;
      final offset = Vector2(cos(angle), sin(angle)) * 30;
      
      gameRef.add(MeteorComponent(
        type: MeteorType.small,
        speed: speed * 1.2,
        health: maxHealth ~/ 3,
        damage: damage ~/ 2,
        pointValue: pointValue ~/ 3,
        startPosition: position + offset,
        target: target,
      ));
    }
  }
  
  void _applyZigzagPattern(double dt) {
    final perpendicular = velocity.clone()..rotate(pi / 2);
    final offset = sin(gameRef.currentTime() * 2 * pi * 2) * 50; // 2 Hz frequency
    position += perpendicular.normalized() * offset * dt;
  }
  
  void _applyOrbitPattern(double dt) {
    final toTarget = target - position;
    final distance = toTarget.length;
    
    if (distance > 100) {
      // Spiral inward
      final tangent = toTarget.clone()..rotate(pi / 2);
      velocity = (toTarget.normalized() * speed * 0.3) + 
                 (tangent.normalized() * speed * 0.7);
    } else {
      // Direct approach when close
      velocity = toTarget.normalized() * speed;
    }
  }
  
  String _getSpriteForType() {
    switch (type) {
      case MeteorType.small:
        return 'meteor_small.png';
      case MeteorType.medium:
        return 'meteor_medium.png';
      case MeteorType.large:
        return 'meteor_large.png';
      case MeteorType.exploding:
        return 'meteor_exploding.png';
      case MeteorType.armored:
        return 'meteor_armored.png';
      default:
        return 'meteor_small.png';
    }
  }
  
  Vector2 _getSizeForType() {
    switch (type) {
      case MeteorType.small:
        return Vector2.all(30);
      case MeteorType.medium:
        return Vector2.all(50);
      case MeteorType.large:
        return Vector2.all(80);
      default:
        return Vector2.all(40);
    }
  }
  
  String _getSizeCategory() {
    if (size.x < 40) return 'small';
    if (size.x < 70) return 'medium';
    return 'large';
  }
  
  bool _isOffScreen() {
    return position.x < -100 || position.x > gameRef.size.x + 100 ||
           position.y < -100 || position.y > gameRef.size.y + 100;
  }
  
  bool _hasHitPlanet() {
    final distance = position.distanceTo(target);
    return distance < 80; // Planet radius
  }
}

enum MeteorType {
  small,
  medium,
  large,
  exploding,
  ultraFast,
  armored,
  split,
  zigzag,
  orbiting,
}
```

### 4. Weapon System

```dart
// lib/features/meteor_madness/presentation/game/components/weapon_component.dart

abstract class Weapon {
  final PlayerComponent player;
  
  int level = 1;
  double lastFireTime = 0;
  double fireRate; // shots per second
  
  Weapon(this.player, {required this.fireRate});
  
  bool canFire() {
    final currentTime = player.gameRef.currentTime();
    final cooldown = 1.0 / fireRate;
    return currentTime - lastFireTime >= cooldown;
  }
  
  void fire(Vector2 position, Vector2 direction);
  
  void update(double dt) {}
  
  void upgrade() {
    level++;
    _applyUpgrade();
  }
  
  void _applyUpgrade();
}

class LaserWeapon extends Weapon {
  int damage = 10;
  bool isPiercing = false;
  bool isHeatSeeking = false;
  
  LaserWeapon(PlayerComponent player) : super(player, fireRate: 5.0);
  
  @override
  void fire(Vector2 position, Vector2 direction) {
    if (!canFire() || player.energy < 2) return;
    
    player.energy -= 2;
    lastFireTime = player.gameRef.currentTime();
    
    final projectile = LaserProjectile(
      position: position.clone(),
      direction: direction,
      damage: damage,
      isPiercing: isPiercing,
      isHeatSeeking: isHeatSeeking,
    );
    
    player.gameRef.add(projectile);
    AudioManager.playSound('laser_shoot.mp3');
  }
  
  @override
  void _applyUpgrade() {
    switch (level) {
      case 2:
        fireRate = 7.0; // +2 fire rate
        break;
      case 3:
        damage = 15; // +5 damage
        break;
      case 4:
        isPiercing = true;
        break;
      case 5:
        isHeatSeeking = true;
        break;
    }
  }
}

class LaserProjectile extends SpriteComponent 
    with HasGameRef<MeteorMadnessGame>, CollisionCallbacks {
  
  final Vector2 direction;
  final int damage;
  final bool isPiercing;
  final bool isHeatSeeking;
  
  final double speed = 500;
  int hitCount = 0;
  
  LaserProjectile({
    required Vector2 position,
    required this.direction,
    required this.damage,
    this.isPiercing = false,
    this.isHeatSeeking = false,
  }) : super(
    position: position,
    size: Vector2(20, 8),
    anchor: Anchor.center,
  );
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite('laser_beam.png');
    add(RectangleHitbox());
    angle = direction.angleToSigned(Vector2(1, 0));
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (isHeatSeeking) {
      _seekNearestMeteor(dt);
    }
    
    position += direction.normalized() * speed * dt;
    
    if (_isOffScreen()) {
      removeFromParent();
    }
  }
  
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is MeteorComponent) {
      other.takeDamage(damage);
      hitCount++;
      
      if (!isPiercing || hitCount >= 2) {
        removeFromParent();
      }
    }
  }
  
  void _seekNearestMeteor(double dt) {
    MeteorComponent? nearest;
    double nearestDist = double.infinity;
    
    for (final component in gameRef.children) {
      if (component is MeteorComponent) {
        final dist = position.distanceTo(component.position);
        if (dist < nearestDist && dist < 200) {
          nearest = component;
          nearestDist = dist;
        }
      }
    }
    
    if (nearest != null) {
      final toTarget = (nearest.position - position).normalized();
      direction.lerp(toTarget, 0.1); // Gentle steering
      angle = direction.angleToSigned(Vector2(1, 0));
    }
  }
  
  bool _isOffScreen() {
    return position.x < -50 || position.x > gameRef.size.x + 50 ||
           position.y < -50 || position.y > gameRef.size.y + 50;
  }
}

class MissileWeapon extends Weapon {
  int damage = 50;
  int ammo = 10;
  int maxAmmo = 10;
  double ammoRegenTime = 0;
  final double ammoRegenRate = 5.0; // seconds per missile
  
  bool isCluster = false;
  bool isNuclear = false;
  
  MissileWeapon(PlayerComponent player) : super(player, fireRate: 0.5);
  
  @override
  void fire(Vector2 position, Vector2 direction) {
    if (!canFire() || ammo <= 0) return;
    
    ammo--;
    lastFireTime = player.gameRef.currentTime();
    
    final missile = MissileProjectile(
      position: position.clone(),
      direction: direction,
      damage: damage,
      isCluster: isCluster,
      isNuclear: isNuclear,
    );
    
    player.gameRef.add(missile);
    AudioManager.playSound('missile_launch.mp3');
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Regenerate ammo
    if (ammo < maxAmmo) {
      ammoRegenTime += dt;
      if (ammoRegenTime >= ammoRegenRate) {
        ammo++;
        ammoRegenTime = 0;
      }
    }
  }
  
  @override
  void _applyUpgrade() {
    switch (level) {
      case 2:
        maxAmmo = 11;
        ammo = maxAmmo;
        break;
      case 3:
        damage = 70;
        break;
      case 4:
        isCluster = true;
        break;
      case 5:
        isNuclear = true;
        damage = 150;
        break;
    }
  }
}
```

### 5. Wave Manager

```dart
// lib/features/meteor_madness/presentation/game/managers/wave_manager.dart

class WaveManager {
  final MeteorMadnessGame game;
  
  int currentWave = 0;
  bool isActive = false;
  bool isComplete = false;
  int meteorsSpawned = 0;
  int meteorsDestroyed = 0;
  int totalMeteorsInWave = 0;
  
  double waveTime = 0;
  
  WaveManager(this.game);
  
  void startWave(int waveNumber) {
    currentWave = waveNumber;
    isActive = true;
    isComplete = false;
    meteorsSpawned = 0;
    meteorsDestroyed = 0;
    waveTime = 0;
    
    // Calculate wave difficulty
    final config = _getWaveConfig(waveNumber);
    totalMeteorsInWave = config.totalMeteors;
    
    // Start spawning
    game.spawnManager.startSpawning(config);
  }
  
  void startBossWave(int bossNumber) {
    currentWave = bossNumber * 6;
    isActive = true;
    isComplete = false;
    
    // Spawn boss
    final boss = _createBoss(bossNumber);
    game.add(boss);
    
    totalMeteorsInWave = 1; // Just the boss
  }
  
  void update(double dt) {
    if (!isActive) return;
    
    waveTime += dt;
    
    // Check completion
    if (meteorsDestroyed >= totalMeteorsInWave && 
        !_hasActiveMeteors()) {
      _completeWave();
    }
  }
  
  void onMeteorDestroyed() {
    meteorsDestroyed++;
  }
  
  void _completeWave() {
    isActive = false;
    isComplete = true;
    
    // Calculate bonuses
    final timeBonus = max(0, (60 - waveTime) * 10).toInt();
    final perfectBonus = game.planet.health == game.planet.maxHealth ? 1000 : 0;
    
    game.scoreManager.addScore(timeBonus + perfectBonus);
    
    // Show completion UI
    game.overlays.add('wave_complete');
  }
  
  WaveConfig _getWaveConfig(int wave) {
    // Base configuration
    final baseSpeed = 100.0;
    final speedMultiplier = 1 + (wave * 0.1);
    
    final meteorCount = 5 + (wave * 2);
    
    // Distribute meteor types based on wave
    int small = (meteorCount * 0.5).toInt();
    int medium = (meteorCount * 0.3).toInt();
    int large = (meteorCount * 0.2).toInt();
    
    // Add special meteors every few waves
    int exploding = wave >= 3 ? 1 : 0;
    int ultraFast = wave >= 5 ? 1 : 0;
    int armored = wave >= 7 ? 1 : 0;
    
    return WaveConfig(
      waveNumber: wave,
      totalMeteors: meteorCount,
      smallCount: small,
      mediumCount: medium,
      largeCount: large,
      exploderCount: exploding,
      ultraFastCount: ultraFast,
      armoredCount: armored,
      baseSpeed: baseSpeed * speedMultiplier,
      spawnRate: max(0.5, 2.0 - (wave * 0.1)),
    );
  }
  
  BossComponent _createBoss(int bossNumber) {
    switch (bossNumber) {
      case 1:
        return TitanMeteorBoss(game: game);
      case 2:
        return AlienDestroyerBoss(game: game);
      case 3:
        return MeteorStormBoss(game: game);
      default:
        return TitanMeteorBoss(game: game, isEnhanced: true);
    }
  }
  
  bool _hasActiveMeteors() {
    return game.children.any((c) => c is MeteorComponent || c is BossComponent);
  }
}

class WaveConfig {
  final int waveNumber;
  final int totalMeteors;
  final int smallCount;
  final int mediumCount;
  final int largeCount;
  final int exploderCount;
  final int ultraFastCount;
  final int armoredCount;
  final double baseSpeed;
  final double spawnRate;
  
  WaveConfig({
    required this.waveNumber,
    required this.totalMeteors,
    required this.smallCount,
    required this.mediumCount,
    required this.largeCount,
    required this.exploderCount,
    required this.ultraFastCount,
    required this.armoredCount,
    required this.baseSpeed,
    required this.spawnRate,
  });
}
```

---

## 📊 Data Management

### Save System

```dart
// lib/features/meteor_madness/data/models/save_data_model.dart

import 'package:hive/hive.dart';

part 'save_data_model.g.dart';

@HiveType(typeId: 0)
class SaveDataModel {
  @HiveField(0)
  final int highScore;
  
  @HiveField(1)
  final int currentLevel;
  
  @HiveField(2)
  final Map<String, int> weaponLevels;
  
  @HiveField(3)
  final Map<String, int> upgradeLevels;
  
  @HiveField(4)
  final List<String> unlockedAchievements;
  
  @HiveField(5)
  final int totalPoints;
  
  @HiveField(6)
  final DateTime lastPlayed;
  
  SaveDataModel({
    required this.highScore,
    required this.currentLevel,
    required this.weaponLevels,
    required this.upgradeLevels,
    required this.unlockedAchievements,
    required this.totalPoints,
    required this.lastPlayed,
  });
}

// Repository implementation
class GameRepositoryImpl implements GameRepository {
  final Box<SaveDataModel> _saveBox;
  
  GameRepositoryImpl(this._saveBox);
  
  @override
  Future<void> saveProgress(SaveDataModel data) async {
    await _saveBox.put('game_save', data);
  }
  
  @override
  SaveDataModel? loadProgress() {
    return _saveBox.get('game_save');
  }
  
  @override
  Future<void> resetProgress() async {
    await _saveBox.delete('game_save');
  }
}
```

---

## 🎨 UI Integration

### Game Screen Widget

```dart
// lib/features/meteor_madness/presentation/screens/game_screen.dart

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late MeteorMadnessGame _game;
  
  @override
  void initState() {
    super.initState();
    _game = MeteorMadnessGame();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: _game,
        overlayBuilderMap: {
          'game_hud': (context, game) => GameHUD(game: _game),
          'wave_complete': (context, game) => WaveCompleteOverlay(game: _game),
          'pause_menu': (context, game) => PauseMenu(game: _game),
          'game_over': (context, game) => GameOverScreen(game: _game),
        },
        initialActiveOverlays: const ['game_hud'],
      ),
    );
  }
}
```

### HUD Widget

```dart
// lib/features/meteor_madness/presentation/widgets/game_hud.dart

class GameHUD extends StatelessWidget {
  final MeteorMadnessGame game;
  
  const GameHUD({required this.game});
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GameState>(
      stream: game.stateStream,
      builder: (context, snapshot) {
        return Stack(
          children: [
            // Top bar
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HealthBar(health: game.planet.health),
                  ScoreDisplay(score: game.score, combo: game.combo),
                ],
              ),
            ),
            
            // Power-ups (right side)
            Positioned(
              right: 20,
              top: 120,
              child: PowerUpPanel(game: game),
            ),
            
            // Weapon indicator (bottom)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: WeaponIndicator(game: game),
            ),
          ],
        );
      },
    );
  }
}
```

---

## 🔊 Audio System

```dart
// lib/features/meteor_madness/utils/audio_manager.dart

import 'package:flame_audio/flame_audio.dart';

class AudioManager {
  static bool _initialized = false;
  static bool musicEnabled = true;
  static bool sfxEnabled = true;
  
  static Future<void> initialize() async {
    if (_initialized) return;
    
    await FlameAudio.audioCache.loadAll([
      'laser_shoot.mp3',
      'missile_launch.mp3',
      'explosion_small.mp3',
      'explosion_medium.mp3',
      'explosion_large.mp3',
      'power_up.mp3',
      'shield_activate.mp3',
      'background_music.mp3',
    ]);
    
    _initialized = true;
  }
  
  static void playSound(String fileName, {double volume = 1.0}) {
    if (sfxEnabled) {
      FlameAudio.play(fileName, volume: volume);
    }
  }
  
  static void playMusic(String fileName, {double volume = 0.5}) {
    if (musicEnabled) {
      FlameAudio.bgm.play(fileName, volume: volume);
    }
  }
  
  static void stopMusic() {
    FlameAudio.bgm.stop();
  }
}
```

---

## ⚡ Performance Optimization

### Object Pooling

```dart
// Object pool for frequently created/destroyed objects
class ObjectPool<T> {
  final List<T> _available = [];
  final T Function() _factory;
  final void Function(T)? _reset;
  
  ObjectPool(this._factory, {void Function(T)? reset}) : _reset = reset;
  
  T acquire() {
    if (_available.isEmpty) {
      return _factory();
    }
    return _available.removeLast();
  }
  
  void release(T obj) {
    _reset?.call(obj);
    _available.add(obj);
  }
}

// Usage example
final particlePool = ObjectPool<ParticleComponent>(
  () => ParticleComponent(),
  reset: (particle) {
    particle.reset();
  },
);
```

### Sprite Batching

```dart
// Batch similar sprites for better performance
class SpriteBatch extends Component with HasGameRef {
  final List<SpriteComponent> sprites = [];
  
  @override
  void render(Canvas canvas) {
    // Batch render all sprites with same texture
    for (final sprite in sprites) {
      sprite.render(canvas);
    }
  }
}
```

---

## 🧪 Testing

### Unit Test Example

```dart
// test/meteor_test.dart

void main() {
  group('Meteor Component Tests', () {
    test('Meteor takes damage correctly', () {
      final meteor = MeteorComponent(
        type: MeteorType.small,
        speed: 100,
        health: 10,
        damage: 5,
        pointValue: 10,
        startPosition: Vector2.zero(),
        target: Vector2(100, 100),
      );
      
      meteor.takeDamage(5);
      expect(meteor.health, equals(5));
      
      meteor.takeDamage(5);
      expect(meteor.health, equals(0));
    });
  });
}
```

---

*End of Technical Implementation Guide*

