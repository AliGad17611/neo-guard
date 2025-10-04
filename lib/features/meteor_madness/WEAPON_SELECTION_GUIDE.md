# Weapon Selection System

## Overview
The Meteor Madness game now features a comprehensive weapon selection system with 6 unique weapons, each unlocking at different wave milestones. Players can switch between weapons during gameplay to adapt their strategy!

## Available Weapons

### 1. **Standard Laser** 🔵
- **Unlock Wave:** 1 (Starting weapon)
- **Fire Rate:** 0.15s
- **Base Damage:** 15
- **Projectile Speed:** 500
- **Special:** Balanced performance
- **Color:** Cyan Blue
- **Best For:** General purpose, learning the game

### 2. **Rapid Fire** ⚡
- **Unlock Wave:** 3
- **Fire Rate:** 0.08s (Very Fast!)
- **Base Damage:** 8
- **Projectile Speed:** 600
- **Special:** Fastest shooting weapon
- **Color:** Gold/Yellow
- **Best For:** High DPS, crowd control

### 3. **Heavy Cannon** 🔥
- **Unlock Wave:** 5
- **Fire Rate:** 0.35s (Slow)
- **Base Damage:** 40 (Highest!)
- **Projectile Speed:** 400
- **Projectile Size:** 1.5x larger
- **Special:** Massive single-target damage
- **Color:** Orange/Red
- **Best For:** Large meteors, boss-like targets

### 4. **Spread Shot** 💜
- **Unlock Wave:** 8
- **Fire Rate:** 0.20s
- **Base Damage:** 10 per projectile
- **Projectile Count:** 5 (Five-way spread)
- **Spread Angle:** Wide coverage
- **Special:** Area denial
- **Color:** Purple
- **Best For:** Multiple targets, area coverage

### 5. **Piercing Laser** 💚
- **Unlock Wave:** 10
- **Fire Rate:** 0.18s
- **Base Damage:** 12
- **Pierce Count:** 5 (Hits 6 meteors!)
- **Projectile Size:** 1.2x
- **Special:** Goes through multiple enemies
- **Color:** Turquoise/Cyan
- **Best For:** Lined-up targets, efficiency

### 6. **Plasma Cannon** 💖
- **Unlock Wave:** 15
- **Fire Rate:** 0.25s
- **Base Damage:** 18 per projectile
- **Projectile Count:** 3 (Triple shot)
- **Pierce Count:** 2 (Hits 3 meteors each)
- **Spread Angle:** Medium
- **Projectile Size:** 1.3x
- **Special:** Combines spread and pierce
- **Color:** Magenta/Pink
- **Best For:** Ultimate weapon, all situations

## Wave Scaling

All weapons scale with wave progression:
- **Damage:** Increases by 20% every 5 waves
- **Speed:** Increases by 10% every 10 waves

### Example Scaling (Plasma Cannon):
- Wave 1: 18 damage, 500 speed
- Wave 5: 18 damage, 500 speed
- Wave 10: 21 damage, 550 speed
- Wave 15: 25 damage, 550 speed
- Wave 20: 28 damage, 600 speed

## How to Use Weapon Selector

### Opening the Selector
1. During gameplay, look for the weapon indicator in the top-left area
2. Tap the **weapon button** (shows current weapon name and icon)
3. The weapon selector will appear

### Selecting a Weapon
1. View all unlocked weapons in the grid
2. Each weapon shows:
   - Icon and name
   - Current damage (scaled for wave)
   - Special attributes (shots, pierce)
3. Tap any weapon to equip it
4. Ship and laser colors change immediately
5. Close selector by tapping X or tapping outside

### During Combat
- Weapon changes are instant
- No cooldown for switching
- Can change weapons between shots
- Strategic switching is encouraged!

## Visual Indicators

### Ship Appearance
- **Color:** Matches current weapon
- **Size:** Scales with weapon power
- **Glow:** Intensity shows weapon tier
- **Indicators:**
  - Yellow dots = Number of projectiles
  - Rings at nose = Pierce count

### Laser Projectiles
- **Color:** Unique per weapon
- **Size:** Varies by weapon
- **Glow:** More intense for powerful weapons
- **Core:** White core for high-tier weapons

### HUD Display
The weapon selector button shows:
- Current weapon icon
- Weapon name
- Current damage value
- Number of shots (if multi-shot)
- Swap icon (indicates tap to change)

## Strategy Guide

### Early Game (Waves 1-4)
- **Standard Laser** only
- Focus on accuracy and positioning

### Wave 3-7
- **Rapid Fire** unlocked
  - Use for small, fast meteors
  - High DPS but requires good aim
- **Heavy Cannon** unlocked at Wave 5
  - Save for large meteors
  - Timing is crucial

### Wave 8-14
- **Spread Shot** unlocked
  - Great for multiple meteors
  - Less precise but covers area
- **Piercing Laser** unlocked at Wave 10
  - Excellent efficiency
  - Position for line shots

### Wave 15+
- **Plasma Cannon** unlocked
  - Ultimate weapon
  - Balance of power and coverage
  - Can handle any situation

### Weapon Combos
- **Spread + Rapid** = Maximum coverage
- **Heavy + Piercing** = Efficient high damage
- **Plasma** = When you can't decide!

## Tips & Tricks

1. **Switch Frequently**
   - Different waves need different weapons
   - Adapt to meteor patterns

2. **Positioning Matters**
   - Pierce weapons: Line up shots
   - Spread weapons: Center yourself

3. **Damage vs Fire Rate**
   - DPS = Damage ÷ Fire Rate
   - Rapid Fire: 100 DPS
   - Heavy Cannon: 114 DPS
   - Consider your accuracy!

4. **Unlock Strategy**
   - Try each weapon when unlocked
   - Find your favorites
   - Master 2-3 weapons minimum

5. **Visual Clarity**
   - Weapon colors help track shots
   - Different colors = easier to see

## Technical Details

### Projectile Physics
- All projectiles use same collision system
- Pierce projectiles continue after hit
- Spread maintains equal spacing
- Speed affects reaction time

### Performance
- Switching weapons has no performance cost
- All weapons optimized equally
- Visual effects scale appropriately

### Balancing
Each weapon has trade-offs:
- **Fire Rate** ↔ **Damage**
- **Spread** ↔ **Accuracy**
- **Pierce** ↔ **Direct Damage**

## Future Enhancements

Potential additions:
- Weapon upgrades within type
- Combo bonuses for switching
- Weapon-specific achievements
- Custom weapon loadouts
- Temporary power-ups
- New weapon types

## Files Added/Modified

### New Files
- `weapon_system.dart` - Weapon data and registry
- `weapon_selector.dart` - Selection UI widget

### Modified Files
- `player_component.dart` - Weapon integration
- `laser_projectile.dart` - Color customization
- `meteor_madness_game.dart` - Weapon management
- `game_hud.dart` - Weapon selector button
- `meteor_madness_page.dart` - UI integration

## Enjoy the Arsenal! 🚀

Experiment with different weapons, find your playstyle, and dominate the meteor waves!

