# Cannon Upgrade System

## Overview
The cannon now has a comprehensive upgrade system that scales with wave progression, making the game more engaging and rewarding as you advance through levels.

## Upgrade Progression

### Level 1 (Waves 1-4) - STANDARD CANNON
- **Fire Rate:** 0.20s between shots
- **Damage:** 10 per shot
- **Projectile Speed:** 400
- **Shot Count:** 1 (Single shot)
- **Pierce:** 0
- **Visual:** Cyan color

### Level 2 (Waves 5-9) - DUAL CANNON
- **Fire Rate:** 0.17s between shots
- **Damage:** 22 per shot
- **Projectile Speed:** 500
- **Shot Count:** 2 (Double shot with spread)
- **Pierce:** 0
- **Visual:** Cyan color

### Level 3 (Waves 10-14) - TRIPLE CANNON
- **Fire Rate:** 0.14s between shots
- **Damage:** 37 per shot
- **Projectile Speed:** 625
- **Shot Count:** 3 (Triple shot with spread)
- **Pierce:** 1 (Can pierce through 2 meteors)
- **Visual:** Bright cyan color with glow effect

### Level 4 (Waves 15-19) - ADVANCED CANNON
- **Fire Rate:** 0.095s between shots
- **Damage:** 52 per shot
- **Projectile Speed:** 750
- **Shot Count:** 5 (Five-way spread shot)
- **Pierce:** 2 (Can pierce through 3 meteors)
- **Visual:** Purple color with enhanced glow

### Level 5 (Wave 20+) - ULTIMATE CANNON
- **Fire Rate:** 0.05s between shots (max)
- **Damage:** 67+ per shot (continues to increase)
- **Projectile Speed:** 800 (max)
- **Shot Count:** 5 (Five-way spread shot)
- **Pierce:** 3 (Can pierce through 4 meteors)
- **Visual:** Magenta/pink color with maximum glow and core light

## Visual Enhancements

### Cannon/Ship Visuals
- Ship grows larger with each upgrade level (up to 60% larger)
- Ship color changes based on upgrade level:
  - Level 1: Standard Cyan (#00D4FF)
  - Level 2: Cyan (#00D4FF)
  - Level 3+: Bright Cyan (#00FFFF) with glow
  - Level 4: Purple (#9D00FF) with enhanced glow
  - Level 5: Magenta (#FF00FF) with maximum glow
- Multi-cannon indicators appear as yellow dots below the ship

### Laser Projectile Visuals
- Size increases with projectile size multiplier
- Color changes based on pierce ability:
  - 0 pierce: Cyan (#00D4FF)
  - 1 pierce: Bright Cyan (#00FFFF)
  - 2 pierce: Purple (#9D00FF)
  - 3+ pierce: Magenta (#FF00FF)
- Glow intensity increases with pierce count
- High-level lasers have a white core for extra visual impact

### HUD Display
- **Cannon Level Badge:** Shows current cannon level (1-5)
- **Level Indicators:** Five dots showing upgrade progress
- **Stat Badges:** Display current damage, shot count, and pierce ability
- **Color-coded:** Badge color matches ship/laser color based on level

## Technical Implementation

### Files Modified
1. **cannon_upgrade_system.dart** (NEW)
   - Central system managing all upgrade stats
   - Wave-based progression formulas
   - Upgrade level calculation

2. **laser_projectile.dart**
   - Added damage, speed, size, and pierce parameters
   - Pierce mechanics implementation
   - Enhanced visual rendering based on upgrade level

3. **player_component.dart**
   - Integration with cannon upgrade system
   - Multi-shot spread mechanics
   - Enhanced ship visuals based on upgrade level

4. **meteor_madness_game.dart**
   - Cannon upgrade system initialization
   - Wave progression triggers upgrades

5. **game_hud.dart**
   - Cannon upgrade display widget
   - Real-time stat visualization
   - Level indicator UI

6. **meteor_madness_page.dart**
   - Pass cannon upgrades to HUD

## Upgrade Formulas

### Fire Rate
```dart
baseRate = 0.2
improvement = min(currentWave - 1, 20) * 0.0075
fireRate = max(baseRate - improvement, 0.05)
```

### Damage
```dart
damage = min(10 + (currentWave - 1) * 3, 100)
```

### Projectile Speed
```dart
baseSpeed = 400.0
improvement = min(currentWave - 1, 15) * 25.0
speed = baseSpeed + improvement
```

### Size Multiplier
```dart
sizeMultiplier = 1.0 + min(currentWave - 1, 10) * 0.1
```

## Gameplay Impact

### Early Game (Waves 1-4)
- Standard shooting mechanics
- Focus on accuracy and positioning
- Learning the game mechanics

### Mid Game (Waves 5-14)
- Double/Triple shot provides coverage
- Pierce ability starts at wave 7
- Faster fire rate for better DPS
- More forgiving gameplay

### Late Game (Wave 15+)
- Five-way spread for area coverage
- High pierce count clears multiple meteors
- Maximum fire rate for intense action
- Visual spectacle with all effects active

## Future Enhancement Ideas
- Additional upgrade tiers beyond level 5
- Special weapon modes (laser beam, missiles, etc.)
- Temporary power-ups during gameplay
- Upgrade customization options
- Sound effects for different upgrade levels

