# Meteor Madness - Detailed Gameplay Mechanics

## 🎮 Core Gameplay Systems

### 1. Player Movement System

#### Orbital Movement
The player's ship follows a circular orbit around the planet/station:

```
Orbit Radius: 200 units (pixels) from center
Angular Velocity: 180°/second (base speed)
Movement Controls:
  - Clockwise: Right arrow / Swipe right / D key
  - Counter-clockwise: Left arrow / Swipe left / A key
  - Quick Rotation: Double tap for 2x speed boost (2 seconds)
```

#### Movement Physics
- **Acceleration**: 0.5 seconds to reach max speed
- **Deceleration**: 0.3 seconds to stop
- **Momentum**: Smooth easing for natural feel
- **Collision**: Ship cannot leave orbit path

#### Advanced Movement
- **Dash Ability** (Unlocked Level 8):
  - Instant 90° rotation
  - Cooldown: 3 seconds
  - Cost: 50 energy

### 2. Targeting and Aiming System

#### Auto-Aim (Default)
```
Target Priority Algorithm:
1. Closest meteor to planet
2. Highest damage threat
3. Meteors in firing arc (±30°)
4. Special meteors (exploding, ultra-fast)
```

#### Manual Aim Mode
- **Activation**: Toggle button or hold aim key
- **Control**: Mouse/touch drag to aim
- **Laser Sight**: Visual trajectory line
- **Snap Assist**: Slight magnetic pull toward targets (15% strength)

#### Targeting Indicators
```
Color Codes:
  🔴 Red: Critical threat (< 2 seconds to impact)
  🟡 Yellow: Moderate threat (2-4 seconds)
  🟢 Green: Low threat (> 4 seconds)
  🔵 Blue: Special meteor
  🟣 Purple: Boss/elite enemy
```

### 3. Weapon Systems

#### Laser Cannon Mechanics

**Base Stats:**
```
Damage: 10 HP
Fire Rate: 5 shots/second (0.2s cooldown)
Projectile Speed: 500 units/second
Range: Infinite
Energy Cost: 2 energy/shot
Energy Regen: 10 energy/second
Max Energy: 100
```

**Firing Modes:**
1. **Single Shot**: Tap to fire once
2. **Rapid Fire**: Hold to auto-fire
3. **Charge Shot** (Level 5+): Hold 1s for 3x damage shot

**Upgrade Progression:**
```
Level 1 → 2: Fire rate 5 → 7 shots/sec (+500 points)
Level 2 → 3: Damage 10 → 15 HP (+1000 points)
Level 3 → 4: Piercing (hits 2 targets) (+2000 points)
Level 4 → 5: Heat-seeking (15° tracking) (+3500 points)
```

#### Missile Launcher Mechanics

**Base Stats:**
```
Damage: 50 HP
Fire Rate: 1 shot/2 seconds
Projectile Speed: 300 units/second (accelerates)
Splash Radius: 40 units
Tracking: Yes (45° turn rate)
Ammo: 10 missiles (regenerates 1 every 5 seconds)
```

**Missile Behavior:**
1. **Launch Phase** (0-0.5s): Slow initial speed
2. **Acceleration Phase** (0.5-1.5s): Increases to max speed
3. **Tracking Phase** (1.5s+): Homes in on target
4. **Impact**: Explosion with area damage

**Upgrade Path:**
```
Level 1: +1 ammo capacity (10 → 11)
Level 2: +20 damage (50 → 70 HP)
Level 3: Cluster missiles (splits into 3, 60% damage each)
Level 4: Nuclear warhead (2x splash radius, 150 HP damage)
```

#### Plasma Cannon (Advanced Weapon)

**Unlock Condition:** Reach Level 10

**Base Stats:**
```
Damage: 25 HP (direct) + 15 HP (splash)
Fire Rate: 3 shots/second
Projectile Speed: 400 units/second
Splash Radius: 20 units
Detonation: Auto at 250 units OR on impact
Energy Cost: 5 energy/shot
```

**Special Properties:**
- Area denial: Leaves plasma cloud for 2 seconds
- Cloud damage: 5 HP/second to meteors inside
- Chain lightning: Arcs to nearby meteors (3 targets max)

### 4. Meteor Behavior AI

#### Spawn System
```
Spawn Zones: 8 sectors (45° each) around screen edge
Spawn Distance: 400 units from planet
Spawn Rate Formula: 
  Base Rate = 1 meteor/2 seconds
  Wave Modifier = Wave# × 0.1
  Final Rate = Base Rate × (1 + Wave Modifier)
```

#### Movement Patterns

**Standard Meteors:**
```javascript
// Pseudo-code
Vector target = planet.center
Vector direction = normalize(target - meteor.position)
meteor.velocity = direction × meteor.speed
```

**Special Patterns:**

1. **Zigzag Meteors** (Level 7+):
```
Sine Wave Pattern:
  Amplitude: 50 units
  Frequency: 2 Hz
  Base direction: Toward planet
```

2. **Orbiting Meteors** (Level 12+):
```
Spiral Pattern:
  Initial orbital radius: 350 units
  Decay rate: -5 units/second
  Angular velocity: 90°/second
```

3. **Kamikaze Meteors** (Level 15+):
```
Acceleration Pattern:
  Initial speed: Slow (50 units/sec)
  Acceleration: 20 units/sec²
  Max speed: 400 units/sec
  Warning: Red trail effect
```

#### Collision Detection
```
Collision Layers:
1. Weapon → Meteor (damage calculation)
2. Meteor → Planet (health reduction)
3. Explosion → Nearby Meteors (area damage)
4. Shield → Meteor (absorption)

Hit Detection:
  Circle-to-circle collision (radius-based)
  AABB pre-check for optimization
```

### 5. Damage Calculation System

#### Base Damage Formula
```
Actual Damage = Base Damage × Multipliers × Resistances

Multipliers:
- Critical Hit (5% chance): 2.0x
- Weapon Level: 1.0x + (Level × 0.1)
- Overcharge Power-Up: 2.0x
- Combo Bonus: 1.0x + (Combo × 0.05), max 1.5x

Resistances:
- Armored Meteor vs Laser: 0.5x (50% reduction)
- Armored Meteor vs Missile: 1.0x (no reduction)
- Shield vs Any: 0.0x (complete absorption)
```

#### Meteor Health System
```
Health States:
1. Full Health: 100-75% → Normal appearance
2. Damaged: 74-40% → Cracks appear
3. Critical: 39-1% → Heavy cracks, pieces breaking off
4. Destroyed: 0% → Explosion animation

Visual Feedback:
- Flash white on hit
- Shake based on damage % (small shake for 10%, large for 50%+)
- Particle emission increases with damage
```

### 6. Power-Up System

#### Power-Up Spawning
```
Drop Chance:
  Small Meteor: 5%
  Medium Meteor: 10%
  Large Meteor: 20%
  Boss Meteor: 100% (guaranteed)

Power-Up Types (Equal Weight):
- Health Pack: Restores 20 HP
- Shield Orb: Activates shield power-up
- Speed Boost: +50% movement for 10s
- Weapon Upgrade: Temporary weapon level +1
- Point Multiplier: 2x points for 15s
```

#### Power-Up Collection
```
Collection Radius: 30 units from ship
Auto-Collect: Power-ups drift toward ship when close
Duration: 15 seconds before despawn
Visual: Pulsing glow with icon indicator
```

#### Active Power-Up Management
```
Power-Up Slots: 4 maximum
Activation: Number keys 1-4 or touch icons
Cooldown System:
  - Individual cooldowns per power-up
  - Visual timer ring around icon
  - Audio cue when ready
  - Haptic feedback on activation (mobile)
```

### 7. Combo and Scoring System

#### Combo Mechanics
```
Combo Timer: 1.5 seconds
Combo Increment: +1 per meteor destroyed
Combo Reset: Timer expires OR meteor hits planet

Multiplier Calculation:
  Multiplier = 1.0 + (Combo Count × 0.1)
  Max Multiplier = 5.0x (at 40 combo)

Combo Tiers:
  10 Combo: "Good!" + sparkle effect
  20 Combo: "Great!" + trail effect
  30 Combo: "Awesome!" + screen glow
  40 Combo: "Legendary!" + full screen effect
```

#### Score Calculation
```javascript
// Per Meteor
basePoints = meteor.pointValue
damageBonus = (damage dealt) × 0.1
speedBonus = max(0, (expectedTime - actualTime) × 10)
accuracyBonus = (hits / shots) × 50

meteorScore = (basePoints + damageBonus + speedBonus + accuracyBonus) × comboMultiplier

// Wave Completion
waveBonus = 500 × waveNumber
perfectBonus = planetHealth == maxHealth ? 1000 : 0
timeBonus = remainingTime × 10

totalScore += allMeteorScores + waveBonus + perfectBonus + timeBonus
```

### 8. Health and Damage System

#### Planet Health Mechanics
```
Max Health: 100 HP (base) + (Level × 5) [caps at 200 HP]

Damage Reception:
1. Check for active shield → absorb if active
2. Apply damage resistance (if upgraded)
3. Subtract from health pool
4. Visual damage state update
5. Warning alert if health < 30%

Critical State (< 30% Health):
- Red screen vignette pulsing
- Alarm sound looping
- Screen shake on each hit
- Emergency repair power-up appears
```

#### Shield System
```
Shield Types:

1. Basic Shield (Power-Up)
   - Absorbs 3 hits
   - Duration: 10 seconds or until depleted
   - Visual: Blue energy dome

2. Advanced Shield (Upgrade)
   - Absorbs 5 hits
   - Duration: 15 seconds
   - Visual: Golden energy dome
   - Reflects 20% damage back to meteors

3. Regenerating Shield (Legendary Upgrade)
   - Absorbs infinite hits
   - Duration: 8 seconds
   - Regenerates 1 hit capacity per second
   - Visual: Pulsing rainbow dome
```

### 9. Boss Fight Mechanics

#### Boss Phase System
```
Phase Triggers:
  Phase 1: 100-66% Health
  Phase 2: 65-33% Health
  Phase 3: 32-0% Health

Phase 1 Behaviors:
- Standard attacks
- Slow movement
- Spawns basic meteors

Phase 2 Behaviors:
- Increased attack speed
- Defensive state (50% damage reduction for 5s intervals)
- Spawns special meteors
- New attack patterns

Phase 3 Behaviors (Enrage):
- Maximum attack speed
- Desperate attacks (high damage)
- Summons multiple meteor waves
- Movement becomes erratic
```

#### Example Boss: Titan Meteor

**Phase 1 (100-66% HP):**
```
Pattern A: Spawns 3 small meteors every 5 seconds
Pattern B: Slow movement toward planet (30 units/sec)
Vulnerable Spots: 3 glowing cores (10% bonus damage)
```

**Phase 2 (65-33% HP):**
```
Pattern A: Spawns 5 small + 2 medium meteors every 4 seconds
Pattern B: Rotates while moving (reveals/hides weak spots)
Pattern C: Shockwave attack every 10 seconds (clears bullets)
Vulnerable Spots: Only visible during rotation
```

**Phase 3 (32-0% HP):**
```
Pattern A: Meteor storm (10 meteors every 3 seconds)
Pattern B: Ramming attack (charges at planet, can be dodged)
Pattern C: Core explosion (area damage if too close)
Vulnerable Spot: Central core exposed (30% bonus damage)
```

### 10. Upgrade and Progression System

#### Experience and Leveling
```
Experience Sources:
- Meteor destruction: 1 XP per point earned
- Wave completion: 100 XP
- Boss defeat: 500 XP
- Achievements: Variable (50-500 XP)

Level Up Formula:
  XP Required = 1000 × (currentLevel^1.5)
  
  Level 1→2: 1,000 XP
  Level 2→3: 2,828 XP
  Level 3→4: 5,196 XP
  Level 5→6: 11,180 XP

Level Up Rewards:
- +1 Skill Point
- Unlock new upgrade tier
- Bonus: 500 points
```

#### Skill Tree System
```
Skill Points: 1 per level up
Max Skills: 50 (level cap: 50)

Skill Categories:

1. Offense Tree (Red)
   ├── Increased Damage (5 levels, +10% each)
   ├── Fire Rate Boost (5 levels, +15% each)
   ├── Critical Chance (5 levels, +5% each)
   └── Ammo Capacity (5 levels, +2 missiles each)

2. Defense Tree (Blue)
   ├── Max Health (5 levels, +20 HP each)
   ├── Shield Duration (5 levels, +2s each)
   ├── Damage Reduction (5 levels, +5% each)
   └── Auto-Repair (1 level, regen 1 HP/sec)

3. Utility Tree (Green)
   ├── Movement Speed (5 levels, +15% each)
   ├── Power-Up Duration (5 levels, +20% each)
   ├── Cooldown Reduction (5 levels, -10% each)
   └── Point Multiplier (5 levels, +10% each)

4. Special Tree (Purple) [Requires Level 10]
   ├── Meteor Slowdown Aura (passive -10% meteor speed)
   ├── Lucky Strike (5% double points on kill)
   ├── Second Wind (auto-revive at 1 HP once per game)
   └── Meteor Magnet (increased power-up drop rate)
```

### 11. Difficulty Scaling System

#### Dynamic Difficulty Adjustment
```
Performance Tracking:
- Accuracy: hits / total shots
- Average Wave Completion Time
- Damage Taken per Wave
- Combo Consistency

Difficulty Modifiers:
If player performing well (accuracy > 80%, fast clear):
  + 10% meteor speed
  + 20% meteor count
  + Better rewards (+15% points)

If player struggling (accuracy < 40%, slow clear):
  - 10% meteor speed
  - 10% meteor health
  + Emergency power-up spawn
```

#### Difficulty Modes
```
1. Easy Mode
   - Meteor speed: -30%
   - Meteor health: -20%
   - Planet health: +50%
   - Power-up drop rate: +50%
   - Points multiplier: 0.75x

2. Normal Mode (Default)
   - Standard values
   - Points multiplier: 1.0x

3. Hard Mode (Unlocked Level 10)
   - Meteor speed: +30%
   - Meteor health: +50%
   - Planet health: -25%
   - Power-up drop rate: -30%
   - Points multiplier: 1.5x

4. Nightmare Mode (Unlocked Level 20)
   - Meteor speed: +60%
   - Meteor health: +100%
   - Planet health: -50%
   - No auto-aim
   - Limited power-ups
   - Points multiplier: 2.5x
```

### 12. Special Game Modes

#### Survival Mode
```
Objective: Last as long as possible
Rules:
  - Infinite waves (increasing difficulty)
  - No level progression
  - Limited lives (3 planets)
  - Score-based competition
  
Leaderboard: Top 100 longest survival times
Rewards: Exclusive survival mode skins
```

#### Time Attack Mode
```
Objective: Clear level as fast as possible
Rules:
  - All weapons unlocked
  - Unlimited power-ups (cooldown only)
  - Time bonus points
  - No health damage penalty
  
Leaderboard: Fastest completion times per level
Rewards: Speed-themed ship skins
```

#### Boss Rush Mode
```
Objective: Defeat all bosses in sequence
Rules:
  - No normal waves
  - Health carries between bosses
  - Limited healing items
  - Progressive difficulty
  
Leaderboard: Fastest boss rush completion
Rewards: Boss-themed weapons and skins
```

---

## 🎯 Advanced Strategies

### Resource Management
1. **Power-Up Priority**: Shield > Overcharge > Time Freeze for survival
2. **Point Optimization**: Save exploding meteors for chain reactions
3. **Ammo Conservation**: Use lasers for small, missiles for large only

### Positioning Tactics
1. **Sector Control**: Stay in sector with fewest spawns
2. **Quick Response**: Position between two active spawn zones
3. **Boss Positioning**: Maintain distance but stay in optimal firing range

### Combo Maintenance
1. **Target Selection**: Always have next target ready
2. **Spray Strategy**: During dense waves, shoot into crowd
3. **Reset Prevention**: Use missiles for guaranteed hits

---

*End of Gameplay Mechanics Document*

