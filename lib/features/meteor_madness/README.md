# 🌠 Meteor Madness - Space Defense Game

## Overview

**Meteor Madness** is an action-packed 2D/3D space defense game integrated into the NEO Guard app. Players defend a planet or space station from waves of incoming meteors using an arsenal of weapons and strategic power-ups.

---

## 📚 Documentation

This feature includes comprehensive documentation covering all aspects of the game:

### 1. [Game Concept](./GAME_CONCEPT.md)
Complete game design document including:
- Core gameplay objectives and mechanics
- Player control systems
- Meteor types and behaviors
- Level progression and boss fights
- Weapons, upgrades, and power-ups
- Visual and audio design
- Scoring and leaderboard systems
- Additional features and future expansions

### 2. [Gameplay Mechanics](./GAMEPLAY_MECHANICS.md)
Detailed technical breakdown of game systems:
- Movement and targeting systems
- Weapon mechanics and calculations
- Meteor AI and behavior patterns
- Damage calculation formulas
- Power-up system mechanics
- Combo and scoring algorithms
- Boss fight phase systems
- Difficulty scaling and game modes

### 3. [Technical Implementation](./TECHNICAL_IMPLEMENTATION.md)
Development guide and code architecture:
- Technology stack (Flutter + Flame)
- Project structure and organization
- Core game components implementation
- Player, meteor, and weapon systems
- Wave and spawn management
- Data persistence and save system
- Audio integration
- Performance optimization techniques

### 4. [UI/UX Design](./UI_UX_DESIGN.md)
Complete visual design specifications:
- Color palette and typography
- Screen layouts and wireframes
- Interactive element designs
- Animation and transition details
- Responsive design for all platforms
- Accessibility features
- Particle effects and visual feedback
- User flow diagrams

---

## 🎮 Core Features

### Gameplay
- **360° Orbital Defense**: Control a spaceship orbiting around a planet/station
- **Dynamic Waves**: Progressively challenging meteor waves with varying types
- **Boss Battles**: Epic confrontations every 6 waves
- **Multiple Weapons**: Lasers for speed, missiles for power
- **Strategic Power-ups**: Shields, time freeze, weapon overcharge, and more

### Progression
- **Upgrade System**: Enhance weapons, ship, and defensive capabilities
- **Skill Tree**: 50 levels of customization across 4 skill categories
- **Unlockables**: New weapons, ships, and cosmetic skins
- **Achievements**: 20+ achievements to unlock

### Competition
- **Leaderboards**: Global, friends, and weekly rankings
- **Score System**: Complex scoring with combos and multipliers
- **Game Modes**: Story, Survival, Time Attack, and Boss Rush

---

## 🛠️ Technology Stack

```yaml
Framework: Flutter 3.x
Game Engine: Flame (Flutter game engine)
State Management: Riverpod / Bloc
Local Storage: Hive / Shared Preferences
Audio: flame_audio / audioplayers
Physics: Flame physics / Box2D
Animations: Flutter animations + Flame sprites
```

---

## 📁 Project Structure

```
lib/features/meteor_madness/
├── data/                          # Data layer
│   ├── datasources/              # Local and remote data sources
│   ├── models/                   # Data models
│   └── repositories/             # Repository implementations
│
├── domain/                        # Business logic layer
│   ├── entities/                 # Game entities
│   ├── repositories/             # Repository interfaces
│   └── usecases/                 # Use cases
│
├── presentation/                  # Presentation layer
│   ├── game/                     # Flame game components
│   │   ├── components/           # Game objects (player, meteors, etc.)
│   │   ├── managers/             # Game systems managers
│   │   └── systems/              # Game systems
│   ├── screens/                  # UI screens
│   ├── widgets/                  # Reusable widgets
│   └── providers/                # State providers
│
└── utils/                         # Utilities and constants
```

---

## 🚀 Getting Started

### Prerequisites

```yaml
Flutter SDK: >= 3.0.0
Dart SDK: >= 3.0.0

Dependencies:
  - flame: ^1.18.0
  - flame_audio: ^2.1.0
  - hive: ^2.2.3
  - riverpod: ^2.5.0
```

### Installation

1. **Add dependencies to `pubspec.yaml`**:

```yaml
dependencies:
  flame: ^1.18.0
  flame_audio: ^2.1.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_riverpod: ^2.5.0
  audioplayers: ^6.0.0
```

2. **Run package install**:

```bash
flutter pub get
```

3. **Initialize Hive for local storage**:

```dart
await Hive.initFlutter();
await Hive.openBox<SaveDataModel>('game_saves');
```

4. **Load audio assets**:

```dart
await AudioManager.initialize();
```

### Running the Game

```dart
// Navigate to game screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => GameScreen(),
  ),
);
```

---

## 🎨 Assets Required

### Images
```
assets/images/meteor_madness/
├── player_ship.png
├── meteors/
│   ├── meteor_small.png
│   ├── meteor_medium.png
│   ├── meteor_large.png
│   ├── meteor_exploding.png
│   └── meteor_armored.png
├── weapons/
│   ├── laser_beam.png
│   └── missile.png
├── backgrounds/
│   ├── starfield.png
│   └── nebula.png
└── ui/
    ├── health_bar.png
    ├── power_up_icons.png
    └── buttons.png
```

### Audio
```
assets/audio/meteor_madness/
├── sfx/
│   ├── laser_shoot.mp3
│   ├── missile_launch.mp3
│   ├── explosion_small.mp3
│   ├── explosion_medium.mp3
│   └── explosion_large.mp3
└── music/
    ├── background_music.mp3
    └── boss_theme.mp3
```

---

## 🎯 Key Gameplay Mechanics

### Player Controls

**Mobile:**
- Tap to shoot at location
- Swipe to rotate ship
- Tap power-up icons to activate

**Desktop:**
- WASD/Arrow keys to move
- Mouse to aim and click to fire
- Number keys (1-4) for power-ups
- Space to switch weapons

### Meteor Types

| Type | Speed | Health | Damage | Special Ability |
|------|-------|--------|--------|-----------------|
| Small | Fast (3-5 u/s) | 10 HP | 5 HP | None |
| Medium | Moderate (2-3 u/s) | 30 HP | 15 HP | None |
| Large | Slow (1-2 u/s) | 60 HP | 30 HP | None |
| Exploding | Moderate | 40 HP | 20 HP | Area damage on death |
| Ultra-Fast | Very Fast (6-8 u/s) | 20 HP | 10 HP | Requires quick reflexes |
| Armored | Slow | 80 HP | 25 HP | Resistant to lasers |

### Weapons

**Laser Cannon:**
- Fire Rate: 5 shots/sec
- Damage: 10 HP
- Best for: Small-medium meteors
- Upgrades: Fire rate, damage, piercing, heat-seeking

**Missile Launcher:**
- Fire Rate: 1 shot/2 sec
- Damage: 50 HP
- Best for: Large meteors, bosses
- Upgrades: Ammo, damage, cluster, nuclear

### Power-Ups

- **Energy Shield** (🛡️): Absorbs 3 hits, 10s duration
- **Time Freeze** (⏰): Slows meteors 80%, 5s duration
- **Weapon Overcharge** (⚡): 2x damage & fire rate, 8s duration
- **Auto-Turrets** (🔫): Deploy 2 AI turrets, 15s duration

---

## 📈 Progression System

### Level Progression
- Each level has 5 waves + 1 boss wave
- Difficulty increases: +10% speed every 2 levels
- New meteor types unlock every 3-5 levels

### Upgrade System
- Earn points by destroying meteors
- Spend points between levels on:
  - Weapon upgrades (5 levels each)
  - Ship enhancements (speed, health, crit chance)
  - Defensive systems (shields, auto-repair)
  - New power-ups

### Achievements
- 20+ achievements to unlock
- Rewards include: Cosmetic skins, bonus points, special abilities

---

## 🏆 Scoring System

### Base Points
```
Small Meteor: 10 points
Medium Meteor: 25 points
Large Meteor: 50 points
Special Meteors: 75-100 points
Boss Defeat: 500-3000 points
```

### Multipliers
- **Combo System**: +0.1x per consecutive hit (max 5.0x)
- **Perfect Wave**: +500 bonus (no damage taken)
- **Speed Bonus**: Clear wave faster than par time
- **Accuracy Bonus**: 95%+ hit rate

---

## 🎮 Game Modes

### Story Mode
- Progress through 20+ levels
- Face unique bosses
- Unlock permanent upgrades

### Survival Mode
- Infinite waves
- Progressive difficulty
- Compete for longest survival time

### Time Attack
- Race to clear levels quickly
- All weapons unlocked
- Speed-based leaderboard

### Boss Rush
- Fight all bosses consecutively
- Limited healing
- Skill-based challenge

---

## ♿ Accessibility

### Visual
- 3 colorblind modes (Protanopia, Deuteranopia, Tritanopia)
- High contrast mode
- Text scaling (100%-200%)
- Reduced motion option

### Audio
- Visual sound indicators
- Separate volume controls (Music, SFX)
- Subtitles for important events

### Controls
- Multiple input methods supported
- Auto-aim assistance (3 levels)
- Fully remappable controls
- Adjustable sensitivity

---

## 📱 Platform Support

- ✅ **Android** (8.0+)
- ✅ **iOS** (iPhone 7+)
- ✅ **Web** (Modern browsers)
- ✅ **Windows** (Desktop)
- ✅ **macOS** (Desktop)
- ✅ **Linux** (Desktop)

---

## 🔧 Configuration

### Game Constants

```dart
// lib/features/meteor_madness/utils/game_config.dart

class GameConfig {
  // Player
  static const double playerOrbitRadius = 200.0;
  static const double playerMaxSpeed = 180.0; // degrees/sec
  static const int playerStartHealth = 100;
  
  // Meteors
  static const double meteorSpawnDistance = 400.0;
  static const double baseSpawnRate = 2.0; // seconds
  
  // Weapons
  static const int laserDamage = 10;
  static const double laserFireRate = 5.0; // shots/sec
  static const int missileDamage = 50;
  static const int missileAmmo = 10;
  
  // Scoring
  static const int smallMeteorPoints = 10;
  static const int mediumMeteorPoints = 25;
  static const int largeMeteorPoints = 50;
  static const double comboMultiplierIncrement = 0.1;
  static const double maxComboMultiplier = 5.0;
}
```

---

## 🐛 Known Issues

- None currently (feature in concept phase)

---

## 🚧 Development Roadmap

### Phase 1 - Core Gameplay (4-6 weeks)
- [ ] Basic game loop and player controls
- [ ] Meteor spawning and movement
- [ ] Collision detection
- [ ] Basic weapon systems
- [ ] Simple UI/HUD

### Phase 2 - Content (3-4 weeks)
- [ ] All meteor types implementation
- [ ] Boss fights (3 bosses)
- [ ] Upgrade system
- [ ] Power-ups
- [ ] Audio integration

### Phase 3 - Polish (2-3 weeks)
- [ ] Visual effects and animations
- [ ] UI/UX refinement
- [ ] Difficulty balancing
- [ ] Performance optimization
- [ ] Bug fixes

### Phase 4 - Extended Features (3-4 weeks)
- [ ] Leaderboard integration
- [ ] Achievement system
- [ ] Additional game modes
- [ ] Social features
- [ ] Cloud save

---

## 🤝 Contributing

This feature is part of the NEO Guard app. Follow the app's contribution guidelines when adding to or modifying this feature.

---

## 📄 License

This feature follows the same license as the NEO Guard app.

---

## 📞 Support

For questions or issues related to Meteor Madness:
1. Check the documentation files in this directory
2. Review the codebase comments
3. Contact the development team

---

## 🙏 Credits

### Inspiration
- Classic arcade games (Asteroids, Space Invaders)
- Modern space shooters (Geometry Wars, Resogun)
- Tower defense mechanics

### Resources
- Flame Engine Documentation
- Flutter Game Development Community

---

**Ready to defend the cosmos? Let's play Meteor Madness! 🚀**

