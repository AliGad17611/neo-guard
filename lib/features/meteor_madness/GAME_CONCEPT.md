# Meteor Madness - Game Concept Document

## 🎮 Overview

**Meteor Madness** is an action-packed 2D/3D space defense game where players protect Earth or a space station from waves of incoming meteors and alien threats. Combining strategic resource management with fast-paced action, players must defend their base while upgrading weapons and unlocking new defensive capabilities.

---

## 🎯 Core Objective

**Primary Goal**: Protect the planet/space station from meteor impacts by destroying incoming threats before they cause critical damage.

**Win Condition**: Survive all waves in a level and defeat the boss stage.

**Lose Condition**: Planet/station health reaches zero.

---

## 🕹️ Gameplay Mechanics

### Player Control System
The player controls a **Space Defense Ship** that orbits around the planet/station:

- **Movement**: 360° orbital rotation around the protected object
- **Aiming**: Auto-aim with manual override option
- **Shooting**: Tap/click to fire lasers, hold for missiles
- **Special Abilities**: Swipe gestures for power-ups

### Defense Target
**Planet/Space Station Health System**:
- Starting Health: 100 HP (increases with level progression)
- Visual damage indicators (cracks, fires, debris)
- Shield system that absorbs first few hits
- Emergency repair power-up available every 30 seconds

### Meteor System

#### Standard Meteors
1. **Small Meteors** (Fast)
   - Speed: High (3-5 units/sec)
   - Health: 10 HP
   - Damage: 5 HP
   - Points: 10

2. **Medium Meteors** (Moderate)
   - Speed: Medium (2-3 units/sec)
   - Health: 30 HP
   - Damage: 15 HP
   - Points: 25

3. **Large Meteors** (Slow)
   - Speed: Low (1-2 units/sec)
   - Health: 60 HP
   - Damage: 30 HP
   - Points: 50

#### Special Meteors

1. **Exploding Meteors** 💥
   - When destroyed, creates shockwave damaging nearby meteors
   - Radius: 50 units
   - Damage: 20 HP to nearby meteors
   - Strategic value: Chain reactions possible

2. **Ultra-Fast Meteors** ⚡
   - Speed: Very High (6-8 units/sec)
   - Brief warning indicator before appearance
   - Requires quick reflexes
   - Bonus points if destroyed: 100 points

3. **Armored Meteors** 🛡️
   - Resistant to lasers (50% damage reduction)
   - Requires missiles for efficient destruction
   - Health: 80 HP
   - Unlocked after Level 5

4. **Split Meteors** 🪨
   - Splits into 3 smaller meteors when destroyed
   - Requires follow-up shots
   - Tactical challenge element

---

## 🎚️ Levels and Progression

### Level Structure
Each level consists of **5 waves** + 1 **Boss Stage**

#### Wave Progression (Example Level 1)
- **Wave 1**: 5 small meteors
- **Wave 2**: 3 small + 2 medium meteors
- **Wave 3**: 5 medium meteors + 1 exploding meteor
- **Wave 4**: 2 large + 3 medium + 2 small meteors
- **Wave 5**: 1 ultra-fast + 3 large + 5 small meteors
- **Boss Wave**: Mega Meteor or Alien Destroyer

### Difficulty Scaling
- **Meteor Speed**: Increases 10% every 2 levels
- **Meteor Count**: +2 meteors per wave every level
- **Meteor Health**: +5% every level
- **New Mechanics**: Introduced every 3 levels

### Boss Stages

#### Level 5 Boss: "Titan Meteor"
- Massive slow-moving meteor with 500 HP
- Spawns small meteors periodically
- Has vulnerable spots (glowing cores)
- Defeat rewards: 1000 points + rare upgrade

#### Level 10 Boss: "Alien Destroyer Ship"
- Mobile enemy that shoots back
- 800 HP with shields (200 HP shield)
- Deploys drone meteors
- Defeat rewards: 2000 points + legendary weapon upgrade

#### Level 15 Boss: "Meteor Storm"
- Swarm of interconnected meteors
- Must destroy connection points to separate them
- Total health pool: 1500 HP
- Defeat rewards: 3000 points + ultimate ability unlock

---

## 🔫 Weapons and Upgrades

### Primary Weapons

#### 1. Laser Cannon (Default)
- **Fire Rate**: 5 shots/second
- **Damage**: 10 HP per shot
- **Range**: Unlimited
- **Best For**: Small to medium meteors
- **Upgrades**:
  - Level 1: +2 fire rate (Cost: 500 points)
  - Level 2: +5 damage (Cost: 1000 points)
  - Level 3: Piercing shots - hits 2 targets (Cost: 2000 points)
  - Level 4: Heat-seeking lasers (Cost: 3500 points)

#### 2. Missile Launcher
- **Fire Rate**: 1 shot/2 seconds
- **Damage**: 50 HP per missile
- **Range**: Unlimited with tracking
- **Best For**: Large meteors, bosses
- **Upgrades**:
  - Level 1: +1 fire rate (Cost: 600 points)
  - Level 2: +20 damage (Cost: 1200 points)
  - Level 3: Cluster missiles - splits into 3 (Cost: 2500 points)
  - Level 4: Nuclear warhead - area damage (Cost: 4000 points)

#### 3. Plasma Cannon (Unlocked Level 10)
- **Fire Rate**: 3 shots/second
- **Damage**: 25 HP per shot
- **Range**: Medium (auto-detonates at range)
- **Best For**: Groups of meteors
- **Special**: Area splash damage (20 unit radius)

### Power-Ups (Temporary Boosts)

#### Active Power-Ups
1. **Energy Shield** 🛡️
   - Duration: 10 seconds
   - Protects planet from 3 hits
   - Cooldown: 45 seconds
   - Cost: 300 points

2. **Time Freeze** ⏰
   - Duration: 5 seconds
   - Slows all meteors by 80%
   - Player can still shoot normally
   - Cooldown: 60 seconds
   - Cost: 500 points

3. **Weapon Overcharge** ⚡
   - Duration: 8 seconds
   - Doubles fire rate and damage
   - Cooldown: 40 seconds
   - Cost: 400 points

4. **Auto-Turrets** 🔫
   - Duration: 15 seconds
   - Deploys 2 AI turrets that auto-fire
   - Cooldown: 50 seconds
   - Cost: 600 points

5. **Meteor Magnet** 🧲
   - Duration: 6 seconds
   - Attracts all meteors to center for easier targeting
   - Cooldown: 70 seconds
   - Cost: 700 points

### Permanent Upgrades

#### Ship Enhancements
- **Movement Speed**: 5 levels, +15% per level (Costs: 400, 800, 1600, 3200, 6400)
- **Max Health Boost**: 5 levels, +20 HP per level (Costs: 500, 1000, 2000, 4000, 8000)
- **Critical Hit Chance**: 5 levels, +5% per level (Costs: 600, 1200, 2400, 4800, 9600)

#### Defensive Systems
- **Auto-Repair**: Regenerates 1 HP/second when no damage taken for 5 seconds (Cost: 5000)
- **Advanced Shields**: Increases shield capacity by 50% (Cost: 3000)
- **Damage Reduction**: Reduces damage from meteors by 20% (Cost: 4000)

---

## 🎨 Visuals and Effects

### Background Environment
- **Animated Starfield**: Parallax scrolling stars at 3 depths
- **Nebula Clouds**: Slowly moving colorful gas clouds (purple, blue, pink)
- **Planet/Station**: Central object with rotation animation
- **Dynamic Lighting**: Light sources from explosions and lasers

### Meteor Visual Design

#### Size Indicators
- **Small**: 20-30 pixel sprites, rocky texture
- **Medium**: 40-60 pixel sprites, cracked surface
- **Large**: 80-120 pixel sprites, detailed with craters

#### Special Visual Markers
- **Exploding Meteors**: Red pulsing glow
- **Ultra-Fast Meteors**: Blue speed trails
- **Armored Meteors**: Metallic shine with plating
- **Split Meteors**: Fractured appearance with cracks

### Particle Effects

#### Explosion Effects
- **Small Meteor Destruction**: 20-30 orange particles, 0.5s duration
- **Large Meteor Destruction**: 50-100 particles with debris chunks, 1.5s duration
- **Boss Destruction**: Screen shake + 200+ particles + shockwave ring

#### Weapon Effects
- **Laser**: Bright beam with glow trail
- **Missile**: Smoke trail + heat distortion
- **Plasma**: Energy ball with electric arcs

### UI Visual Elements
- **Health Bar**: Gradient from green → yellow → red
- **Score Counter**: Animated number increase with combo multiplier display
- **Power-Up Icons**: Glowing borders when available, greyed when on cooldown
- **Warning Indicators**: Red flashing arrows for ultra-fast meteors

---

## 🔊 Sound Design

### Weapon Sounds
- **Laser Fire**: "Pew pew" - sharp electronic zap (0.1s)
- **Missile Launch**: Deep "whoosh" with ignition sound (0.3s)
- **Plasma Shot**: Electric crackle with bass (0.2s)

### Impact & Destruction
- **Small Explosion**: Quick pop with debris sounds
- **Medium Explosion**: Louder bang with rumble
- **Large Explosion**: Deep boom with reverb tail
- **Boss Destruction**: Epic explosion sequence (2-3s) with music sting

### Power-Up Sounds
- **Shield Activation**: Crystalline shimmer with hum
- **Time Freeze**: Clock ticking sound with pitch drop
- **Overcharge**: Electric surge with rising pitch
- **Turret Deploy**: Mechanical assembly sounds

### Ambient & Music
- **Background Music Layers**:
  - Layer 1: Ambient space drone (always playing)
  - Layer 2: Percussion (starts at wave 2)
  - Layer 3: Melody (starts at wave 4)
  - Layer 4: Bass & intensity (boss fights)
  
- **Tension System**: Music tempo increases with planet damage
- **Victory Fanfare**: Triumphant brass and strings
- **Defeat Sound**: Somber piano with warning sirens

### UI Sounds
- **Menu Selection**: Soft beep
- **Purchase/Upgrade**: Cash register + positive chime
- **Level Complete**: Success jingle
- **Countdown**: Tick-tock with final beep

---

## 🎮 Gameplay Loop

### Core Loop (Per Wave)
1. **Wave Start** → Countdown (3, 2, 1, GO!)
2. **Meteor Spawning** → Random positions at screen edge
3. **Player Defense** → Aim and shoot incoming meteors
4. **Resource Management** → Decide when to use power-ups
5. **Wave Clear** → Points awarded, brief break (3 seconds)
6. **Repeat** → Next wave with increased difficulty
7. **Boss Fight** → Every 6th wave
8. **Level Complete** → Upgrade screen

### Session Loop
1. **Main Menu** → Select difficulty, view leaderboard
2. **Level Selection** → Choose starting level (if unlocked)
3. **Gameplay** → Complete waves and boss
4. **Upgrade Screen** → Spend points on permanent upgrades
5. **Continue or Quit** → Save progress and return to menu

### Progression Hooks
- **Daily Challenges**: Special conditions for bonus rewards
- **Achievement System**: Unlock cosmetic skins and titles
- **Competitive Rankings**: Weekly leaderboard resets
- **Unlockables**: New ships, weapons, and planets to defend

---

## 🏆 Scoring System

### Base Points
- Small Meteor: 10 points
- Medium Meteor: 25 points
- Large Meteor: 50 points
- Special Meteors: 75-100 points
- Boss Meteors: 500-3000 points

### Multiplier System
- **Combo Multiplier**: Increases by 0.1x for each consecutive hit within 1 second
- **Max Combo**: 5.0x multiplier
- **Perfect Wave Bonus**: +500 points (no damage taken)
- **Speed Bonus**: +100 points for clearing wave 20% faster than par time

### Special Achievements (Bonus Points)
- **Marksman**: 95%+ accuracy in a wave (+200 points)
- **Chain Reaction**: Destroy 5+ meteors with one exploding meteor (+300 points)
- **Last Second Save**: Destroy meteor 0.2s before impact (+150 points)
- **Pacifist Shield**: Complete wave using only shields (+400 points)

---

## 📱 User Interface Layout

### In-Game HUD

#### Top Section
```
┌─────────────────────────────────────────────┐
│  ❤️ Planet Health: ████████░░ 80/100        │
│  ⭐ Score: 12,450  🎯 Combo: x2.5           │
│  🌊 Wave: 4/5                               │
└─────────────────────────────────────────────┘
```

#### Side Panel (Right)
```
┌──────────────┐
│ Power-Ups:   │
│ 🛡️ Shield    │
│ ⏰ 35s       │
│              │
│ ⚡ Overcharge│
│ ⏰ Ready!    │
│              │
│ 🔫 Turrets   │
│ ⏰ 12s       │
└──────────────┘
```

#### Bottom Section
```
┌─────────────────────────────────────────────┐
│  [LASER] ████████ 100%     [MISSILE] ██░░ 50% │
│                                               │
│  Controls: [TAP] Fire  [SWIPE] Power-Up      │
└─────────────────────────────────────────────┘
```

### Upgrade Screen Layout
```
╔══════════════════════════════════════════════╗
║           UPGRADE STATION                    ║
║  Available Points: 2,500                     ║
╠══════════════════════════════════════════════╣
║                                              ║
║  WEAPONS              DEFENSE                ║
║  ┌──────────────┐    ┌──────────────┐      ║
║  │ Laser Lvl 2  │    │ Shield Lvl 1 │      ║
║  │ → Lvl 3      │    │ → Lvl 2      │      ║
║  │ Cost: 1000   │    │ Cost: 1500   │      ║
║  │ [UPGRADE]    │    │ [UPGRADE]    │      ║
║  └──────────────┘    └──────────────┘      ║
║                                              ║
║  SHIP SPEED           POWER-UPS             ║
║  ┌──────────────┐    ┌──────────────┐      ║
║  │ Speed Lvl 1  │    │ Auto-Turret  │      ║
║  │ → Lvl 2      │    │ LOCKED       │      ║
║  │ Cost: 800    │    │ Unlock: Lvl 5│      ║
║  │ [UPGRADE]    │    │              │      ║
║  └──────────────┘    └──────────────┘      ║
║                                              ║
║  [CONTINUE TO NEXT LEVEL]                   ║
╚══════════════════════════════════════════════╝
```

### Main Menu Layout
```
╔══════════════════════════════════════════════╗
║                                              ║
║         🌠 METEOR MADNESS 🌠                ║
║                                              ║
║            [START GAME]                      ║
║            [LEADERBOARD]                     ║
║            [SETTINGS]                        ║
║            [ACHIEVEMENTS]                    ║
║                                              ║
║  Your High Score: 45,230                     ║
║  Current Rank: #127                          ║
╚══════════════════════════════════════════════╝
```

---

## 💡 Player Strategy Guide

### Beginner Strategies
1. **Prioritize Threats**: Focus on meteors closest to planet first
2. **Save Power-Ups**: Use shields during heavy waves, not early
3. **Upgrade Lasers First**: More versatile for early levels
4. **Learn Patterns**: Meteors spawn from predictable sectors

### Advanced Tactics
1. **Combo Building**: Keep shooting continuously for multiplier
2. **Exploding Meteor Positioning**: Let them get near other meteors before destroying
3. **Missile Conservation**: Save for large meteors and bosses
4. **Movement Efficiency**: Position between spawn zones to minimize rotation
5. **Power-Up Synergy**: Combine Time Freeze + Overcharge for maximum damage

### Expert Techniques
1. **Damage Optimization**: Calculate when to let small meteors through to focus on large ones
2. **Resource Cycling**: Rotate power-ups to always have one available
3. **Boss Patterns**: Memorize boss attack sequences for perfect dodging
4. **Point Farming**: Use exploding meteors to create chain reactions for max points
5. **Perfect Accuracy**: Aim for 100% hit rate to maximize ammo efficiency

---

## 🌟 Additional Features

### Leaderboard System
- **Global Rankings**: Top 100 players worldwide
- **Friends Rankings**: Compare with connected players
- **Weekly Challenges**: Rotating special conditions
- **Categories**: 
  - Highest Score
  - Fastest Level Completion
  - Best Accuracy
  - Longest Survival

### Achievements
- 🏅 **Meteor Hunter**: Destroy 1,000 meteors
- 🏅 **Perfect Defense**: Complete 5 levels without planet damage
- 🏅 **Chain Master**: Create a 10-meteor chain reaction
- 🏅 **Speed Demon**: Complete level under 2 minutes
- 🏅 **Boss Slayer**: Defeat all bosses
- 🏅 **Ultimate Defender**: Reach level 20

### Customization
- **Ship Skins**: Unlock 15+ visual styles
- **Planet Themes**: Defend Earth, Mars, Ice Planet, etc.
- **Weapon Skins**: Colorful laser trails and missile designs
- **Background Themes**: Different space environments

### Control Options
- **Touch Controls**: Tap to shoot, swipe to rotate
- **Gyroscope**: Tilt device to aim
- **Auto-Aim Toggle**: Accessibility option
- **Sensitivity Settings**: Customizable for all control types
- **Button Layout**: Customizable UI positioning

### Accessibility Features
- **Colorblind Mode**: Alternative color schemes
- **Reduced Motion**: Minimal particle effects option
- **High Contrast UI**: Enhanced visibility
- **Haptic Feedback**: Vibration on impacts and shots
- **Audio Cues**: Sound indicators for visual events

---

## 🚀 Future Expansion Ideas

### Potential Updates
1. **Multiplayer Mode**: Cooperative defense with friends
2. **PvP Arena**: Compete against other players
3. **Story Mode**: Narrative-driven campaign
4. **Endless Mode**: Survival for high scores
5. **Ship Builder**: Create custom ships with modular parts
6. **Seasonal Events**: Halloween meteors, Christmas themes, etc.

### Content Additions
- New weapon types (gravity gun, black hole launcher)
- More boss varieties with unique mechanics
- Additional power-ups and upgrades
- New planets and space stations to defend
- Challenge modes with special rules

---

## 📊 Technical Considerations

### Performance Targets
- **Frame Rate**: 60 FPS minimum
- **Load Time**: < 2 seconds for level start
- **Memory Usage**: < 200 MB
- **Battery Efficiency**: Optimized for mobile devices

### Platform Support
- **iOS**: iPhone 7 and newer
- **Android**: Android 8.0 and newer
- **Web**: Modern browsers (Chrome, Firefox, Safari)
- **Desktop**: Windows, macOS, Linux

### Save System
- **Auto-Save**: Progress saved after each wave
- **Cloud Sync**: Cross-device progression (optional)
- **Offline Play**: Full game available without internet
- **Data Persistence**: Upgrades and achievements saved locally

---

## 🎯 Core Game Loop Summary

**Meteor Madness** creates an engaging cycle of:
1. **Action** → Fast-paced shooting and dodging
2. **Strategy** → Resource and power-up management
3. **Progression** → Upgrades and unlocks
4. **Mastery** → Skill improvement and competition

The game balances accessibility for casual players with depth for hardcore gamers, ensuring long-term engagement through its upgrade systems, competitive leaderboards, and increasingly challenging gameplay.

---

*End of Game Concept Document*

