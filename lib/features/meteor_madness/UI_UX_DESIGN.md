# Meteor Madness - UI/UX Design Specifications

## 🎨 Visual Design System

### Color Palette

#### Primary Colors
```
Space Navy:      #0A0E27  (Background)
Deep Blue:       #1B2845  (UI Elements)
Cosmic Purple:   #5C4B99  (Accents)
Electric Blue:   #00D4FF  (Player/Lasers)
Neon Pink:       #FF006E  (Alerts/Danger)
Stellar White:   #F0F4FF  (Text/UI)
```

#### Meteor Colors
```
Standard Rock:   #8B7355  (Brown/Gray)
Exploding:       #FF4500  (Orange-Red with glow)
Ultra-Fast:      #00BFFF  (Deep Sky Blue)
Armored:         #C0C0C0  (Silver/Metallic)
Boss:            #9400D3  (Dark Violet)
```

#### UI State Colors
```
Health Full:     #00FF88  (Bright Green)
Health Medium:   #FFD700  (Gold)
Health Low:      #FF4444  (Red)
Energy:          #00D4FF  (Cyan)
Shield:          #8A2BE2  (Blue Violet)
```

### Typography

```yaml
Font Family: 
  Primary: "Orbitron" (Futuristic, technical)
  Secondary: "Rajdhani" (Clean, readable)
  Numbers: "Share Tech Mono" (Monospaced for scores)

Font Sizes:
  Title: 48px (bold)
  Heading: 32px (semi-bold)
  Subheading: 24px (medium)
  Body: 18px (regular)
  Caption: 14px (light)
  
Letter Spacing:
  Title: 2px
  Heading: 1.5px
  Body: 0.5px
```

---

## 📱 Screen Layouts

### 1. Main Menu Screen

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│              🌠  METEOR MADNESS  🌠                     │
│                                                         │
│                 ╔═══════════════╗                      │
│                 ║  START GAME   ║                      │
│                 ╚═══════════════╝                      │
│                                                         │
│                 ╔═══════════════╗                      │
│                 ║  LEADERBOARD  ║                      │
│                 ╚═══════════════╝                      │
│                                                         │
│                 ╔═══════════════╗                      │
│                 ║  ACHIEVEMENTS ║                      │
│                 ╚═══════════════╝                      │
│                                                         │
│                 ╔═══════════════╗                      │
│                 ║   SETTINGS    ║                      │
│                 ╚═══════════════╝                      │
│                                                         │
│   ────────────────────────────────────────────────     │
│   Your High Score: 45,230        Rank: #127            │
│   Last Played: 2 hours ago                             │
│                                                         │
└─────────────────────────────────────────────────────────┘

Design Elements:
- Animated starfield background with parallax
- Pulsing glow effect on buttons on hover
- Meteor animations flying across screen
- Subtle particle effects
- Background ambient space music
```

### 2. Game Screen - In-Game HUD

```
┌─────────────────────────────────────────────────────────┐
│  ❤️ PLANET  ████████░░  80/100    ⭐ SCORE  12,450     │
│  🌊 Wave 4/5              COMBO x2.5 🔥                 │
├─────────────────────────────────────────────────────────┤
│                                                         │
│                        🌍                           ┌─┐ │
│                                                     │P│ │
│                                                     │O│ │
│            💫     🪨                                │W│ │
│                                                     │E│ │
│      🪨                🚀                           │R│ │
│                                                     │ │ │
│                                                     │🛡│ │
│            💥         🌑                            │⏰│ │
│                                                     │  │ │
│                                                     │⚡│ │
│      🪨        💫                                   │✓│ │
│                                                     │  │ │
│                                                     │🔫│ │
│                                                     │45│ │
│                                                     └─┘ │
├─────────────────────────────────────────────────────────┤
│  LASER  ████████████ 100%      MISSILE  ████░░ 6/10    │
│                                                         │
│     [TAP TO FIRE]    [HOLD FOR MISSILE]                │
└─────────────────────────────────────────────────────────┘

Layout Breakdown:

Top Bar (Fixed):
  - Left: Planet Health with visual bar (gradient green→yellow→red)
  - Right: Score display with combo multiplier
  - Center: Wave indicator with progress

Right Panel (Floating):
  - Power-up slots (4 items)
  - Each shows icon, cooldown timer, and activation state
  - Glowing border when ready
  - Grayed out when on cooldown
  - Touch/click to activate

Bottom Bar (Fixed):
  - Weapon status bars
  - Current weapon highlighted
  - Ammo/energy indicators
  - Control hints (contextual based on platform)
```

### 3. Upgrade Screen

```
┌─────────────────────────────────────────────────────────┐
│                   UPGRADE STATION                       │
│                                                         │
│              💰 Available Points: 2,500                 │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌────────────────────┐      ┌────────────────────┐   │
│  │  ⚡ LASER CANNON   │      │  🚀 MISSILES       │   │
│  │                    │      │                    │   │
│  │  Current: Level 2  │      │  Current: Level 1  │   │
│  │  ┌──────────────┐  │      │  ┌──────────────┐  │   │
│  │  │ Fire Rate +2 │  │      │  │ +1 Capacity  │  │   │
│  │  │ (5→7/sec)    │  │      │  │ (10→11)      │  │   │
│  │  └──────────────┘  │      │  └──────────────┘  │   │
│  │                    │      │                    │   │
│  │  Cost: 1,000 💎    │      │  Cost: 600 💎      │   │
│  │  ┌──────────────┐  │      │  ┌──────────────┐  │   │
│  │  │   UPGRADE    │  │      │  │   UPGRADE    │  │   │
│  │  └──────────────┘  │      │  └──────────────┘  │   │
│  └────────────────────┘      └────────────────────┘   │
│                                                         │
│  ┌────────────────────┐      ┌────────────────────┐   │
│  │  🛡️ SHIELD SYSTEM  │      │  ⚡ SHIP SPEED     │   │
│  │                    │      │                    │   │
│  │  Current: Level 1  │      │  Current: Level 2  │   │
│  │  ┌──────────────┐  │      │  ┌──────────────┐  │   │
│  │  │ Duration +2s │  │      │  │ Speed +15%   │  │   │
│  │  │ (10→12 sec)  │  │      │  │              │  │   │
│  │  └──────────────┘  │      │  └──────────────┘  │   │
│  │                    │      │                    │   │
│  │  Cost: 1,500 💎    │      │  Cost: 800 💎      │   │
│  │  ┌──────────────┐  │      │  ┌──────────────┐  │   │
│  │  │   UPGRADE    │  │      │  │   UPGRADE    │  │   │
│  │  └──────────────┘  │      │  └──────────────┘  │   │
│  └────────────────────┘      └────────────────────┘   │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│              ┌─────────────────────────┐               │
│              │  CONTINUE TO NEXT LEVEL │               │
│              └─────────────────────────┘               │
│                                                         │
└─────────────────────────────────────────────────────────┘

Interaction:
- Hover effects on upgrade cards (lift shadow, glow)
- Disabled state for unaffordable upgrades (grayed out)
- Locked upgrades show requirements
- Preview of upgrade benefits before purchase
- Confirmation animation on purchase
```

### 4. Leaderboard Screen

```
┌─────────────────────────────────────────────────────────┐
│                     🏆 LEADERBOARD 🏆                   │
│                                                         │
│   [GLOBAL]  [FRIENDS]  [WEEKLY]                        │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│   #   Player                    Score         Level    │
│  ─────────────────────────────────────────────────     │
│                                                         │
│  🥇  StarDestroyer99          125,430          18      │
│  🥈  CosmicDefender           98,750           16      │
│  🥉  MeteorHunter             87,320           15      │
│   4  AstroWarrior             76,540           14      │
│   5  SpaceGuardian            68,920           13      │
│   ...                                                   │
│  127 YOU                      45,230           10  ⭐  │
│  ...                                                    │
│                                                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│         Your Best Stats                                │
│         ──────────────────────                         │
│         Highest Score: 45,230                          │
│         Best Wave: 12                                  │
│         Total Meteors Destroyed: 1,247                 │
│         Longest Combo: x18                             │
│                                                         │
│              [BACK TO MENU]                            │
│                                                         │
└─────────────────────────────────────────────────────────┘

Features:
- Smooth scrolling list
- Highlighted player position
- Medal icons for top 3
- Tab navigation for different leaderboards
- Pull to refresh on mobile
- Animated rank changes
```

### 5. Wave Complete Overlay

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                                                         │
│                   ✨ WAVE COMPLETE! ✨                  │
│                                                         │
│                  ╔═══════════════════╗                 │
│                  ║                   ║                 │
│                  ║  Base Score: 850  ║                 │
│                  ║  Time Bonus: 120  ║                 │
│                  ║  Perfect: +1000   ║                 │
│                  ║  ───────────────  ║                 │
│                  ║  Total: +1,970    ║                 │
│                  ║                   ║                 │
│                  ║  Score: 14,420    ║                 │
│                  ║                   ║                 │
│                  ╚═══════════════════╝                 │
│                                                         │
│                  ┌─────────────────┐                   │
│                  │   NEXT WAVE     │                   │
│                  └─────────────────┘                   │
│                                                         │
│                     Starting in 3...                   │
│                                                         │
└─────────────────────────────────────────────────────────┘

Animation:
- Fade in with scale effect
- Confetti particle animation
- Score numbers count up animation
- Pulse effect on "Next Wave" button
- Auto-advance after countdown
```

### 6. Boss Intro Screen

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                                                         │
│              ⚠️  WARNING  ⚠️                            │
│                                                         │
│              BOSS APPROACHING                          │
│                                                         │
│          ┌─────────────────────┐                       │
│          │                     │                       │
│          │   ╔═══════════╗     │                       │
│          │   ║           ║     │                       │
│          │   ║  👹 BOSS  ║     │                       │
│          │   ║           ║     │                       │
│          │   ╚═══════════╝     │                       │
│          │                     │                       │
│          │  TITAN METEOR       │                       │
│          │                     │                       │
│          │  Health: ████ 500   │                       │
│          └─────────────────────┘                       │
│                                                         │
│                                                         │
│          PREPARE YOUR DEFENSES!                        │
│                                                         │
│                                                         │
└─────────────────────────────────────────────────────────┘

Effects:
- Screen shake effect
- Red pulsing border
- Dramatic music sting
- Boss silhouette reveal animation
- 3 second display before starting
```

### 7. Game Over Screen

```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│                   💥 GAME OVER 💥                       │
│                                                         │
│              The planet has been destroyed!            │
│                                                         │
│                  ╔═══════════════════╗                 │
│                  ║                   ║                 │
│                  ║  Final Score:     ║                 │
│                  ║     12,450        ║                 │
│                  ║                   ║                 │
│                  ║  Wave Reached: 8  ║                 │
│                  ║  Meteors: 156     ║                 │
│                  ║  Accuracy: 73%    ║                 │
│                  ║                   ║                 │
│                  ╚═══════════════════╝                 │
│                                                         │
│                  New Achievement! 🏅                    │
│                  "First Defense"                       │
│                                                         │
│          ┌──────────────┐  ┌──────────────┐           │
│          │  RETRY       │  │  MAIN MENU   │           │
│          └──────────────┘  └──────────────┘           │
│                                                         │
└─────────────────────────────────────────────────────────┘

Features:
- Stats summary
- Achievement notifications
- High score indicator if achieved
- Social share button (optional)
- Save score to leaderboard automatically
```

---

## 🎯 Interactive Elements

### Button Styles

#### Primary Button
```css
Background: Linear gradient(#00D4FF, #5C4B99)
Border: 2px solid #F0F4FF
Border-radius: 8px
Padding: 16px 32px
Font: Orbitron, 20px, bold
Text-color: #F0F4FF
Shadow: 0 4px 12px rgba(0, 212, 255, 0.4)

Hover:
  - Lift effect (transform: translateY(-2px))
  - Increase shadow
  - Slight scale (1.05)
  - Glow animation

Active:
  - Press effect (transform: translateY(1px))
  - Reduce shadow
```

#### Secondary Button
```css
Background: Transparent
Border: 2px solid #00D4FF
Border-radius: 8px
Padding: 12px 24px
Font: Rajdhani, 18px, medium
Text-color: #00D4FF

Hover:
  - Fill background (#00D4FF)
  - Text color to #0A0E27
```

#### Icon Button (Power-ups)
```css
Size: 64x64px
Background: Radial gradient(#1B2845, #0A0E27)
Border: 2px solid #5C4B99
Border-radius: 50%
Icon-size: 32px

States:
  Ready: Border-color #00FF88, pulsing glow
  Cooldown: Grayscale, radial timer overlay
  Active: Bright glow, particle effects
```

### Progress Bars

#### Health Bar
```css
Height: 24px
Width: 200px
Background: #1B2845
Border: 2px solid #F0F4FF
Border-radius: 12px

Fill:
  - Gradient based on percentage:
    100-75%: #00FF88 → #32CD32 (Green)
    74-40%:  #FFD700 → #FFA500 (Yellow-Orange)
    39-0%:   #FF4444 → #DC143C (Red)
  - Smooth transition between states
  - Pulse animation when low (< 30%)

Label: HP text overlay, white with shadow
```

#### Energy/Ammo Bar
```css
Height: 20px
Width: 180px
Background: #0A0E27
Border: 1px solid #00D4FF

Fill:
  - Solid color: #00D4FF (Cyan)
  - Shimmer effect when full
  - Depletion animation when used

Segments:
  - Divided into 10 equal segments for visual clarity
  - Each segment lights up individually
```

### Combo Counter

```css
Container:
  Position: Top-center of screen
  Background: Semi-transparent (#0A0E27, 80%)
  Border: 2px solid #FF006E
  Border-radius: 20px
  Padding: 8px 16px

Text:
  Font: Share Tech Mono, 28px, bold
  Color: #FF006E
  Text-shadow: 0 0 10px #FF006E (glow effect)

Animation:
  - Scale pulse on increment (1.0 → 1.3 → 1.0)
  - Color intensity increases with combo (darker → brighter)
  - Shake effect at milestones (10x, 20x, 30x, 40x)
  - Confetti burst at max combo (40x)
```

---

## 🎭 Animations and Transitions

### Screen Transitions

```yaml
Menu → Game:
  Duration: 800ms
  Effect: Fade out menu, zoom into planet

Game → Upgrade:
  Duration: 600ms
  Effect: Slide up from bottom, blur background

Wave → Wave:
  Duration: 400ms
  Effect: Quick fade with score tally

Game → Game Over:
  Duration: 1200ms
  Effect: Slow-motion destruction, screen shake, fade to red
```

### Micro-interactions

#### Meteor Destruction
```
1. Impact flash (white, 50ms)
2. Explosion particle burst (300-500 particles)
3. Debris scatter animation (500ms)
4. Score popup (+10, floating upward, fading)
5. Sound effect synchronized
```

#### Weapon Fire
```
Laser:
  - Muzzle flash (bright cyan)
  - Beam trail with fade (200ms lifetime)
  - Impact spark on hit
  
Missile:
  - Launch smoke puff
  - Spiral trail particles
  - Explosion on impact (larger radius)
```

#### Power-up Activation
```
1. Button press animation (scale down)
2. Circular ripple effect from button
3. Full-screen overlay based on power-up type:
   - Shield: Blue energy dome materializes
   - Time Freeze: Screen tint, slow-motion effect
   - Overcharge: Red energy aura around ship
4. Audio cue (unique per power-up)
5. HUD indicator appears
```

#### Damage Feedback
```
Player Hit:
  - Screen flash (red vignette)
  - Controller vibration / haptic feedback
  - Health bar shake
  - Warning sound

Planet Hit:
  - Screen shake (intensity based on damage)
  - Crack appears on planet sprite
  - Damage number floats up
  - Alert sound if health < 30%
```

---

## 📐 Responsive Design

### Mobile (Portrait)

```
Layout Adjustments:
- HUD elements positioned at edges (safe for thumbs)
- Power-ups at bottom-right corner (4x1 grid)
- Health bar top-left (smaller)
- Score top-right (smaller)
- Weapon switcher bottom-left

Controls:
- Tap anywhere to shoot at location
- Swipe left/right edge to rotate ship
- Double-tap power-up to activate
- Pinch to pause (optional)
```

### Mobile (Landscape)

```
Layout:
- Standard layout as designed above
- HUD at top
- Power-ups at right
- Weapon status at bottom

Controls:
- Virtual joystick left (movement)
- Fire button right
- Power-up buttons right side
```

### Tablet

```
Layout:
- Larger game area (center)
- More spacing in HUD
- Bigger text and icons
- Power-up panel can show details on hover

Controls:
- Support both touch and external controller
```

### Desktop/Web

```
Layout:
- Full widescreen support
- Extended game area
- Additional stats panel on left
- Detailed tooltips on hover

Controls:
- WASD / Arrow keys for movement
- Mouse aim and click to fire
- Number keys for power-ups
- Space for weapon switch
```

---

## ♿ Accessibility Features

### Visual Accessibility

```yaml
Colorblind Modes:
  Protanopia: Red → Orange/Brown
  Deuteranopia: Green → Blue/Yellow
  Tritanopia: Blue → Red/Pink

High Contrast Mode:
  - Increase border thickness (2px → 4px)
  - Stronger colors (remove pastels)
  - Solid backgrounds (no gradients)
  - Clear icon outlines

Text Scaling:
  - Support 100% - 200% scale
  - Maintain layout integrity
  - Minimum font size: 12px

Motion Reduction:
  - Disable parallax backgrounds
  - Reduce particle effects (50%)
  - Remove screen shake
  - Slower transitions
```

### Audio Accessibility

```yaml
Visual Sound Indicators:
  - Meteor approaching: Directional arrow + icon
  - Weapon fire: Muzzle flash emphasis
  - Power-up ready: Border pulse
  - Low health: Screen border color

Subtitles:
  - Boss dialogue/warnings
  - Achievement notifications
  - Audio cue text descriptions

Volume Controls:
  - Master volume
  - Music volume
  - SFX volume
  - Voice volume (if applicable)
```

### Control Accessibility

```yaml
Input Options:
  - Touch controls
  - Keyboard
  - Gamepad (Xbox, PlayStation, Switch)
  - Mouse
  - External switch devices (mobile)

Auto-aim Assistance:
  - Level 1: Slight magnetic pull (15%)
  - Level 2: Moderate assistance (30%)
  - Level 3: Strong lock-on (60%)

Customization:
  - Remap all controls
  - Adjust sensitivity
  - Toggle hold vs. tap
  - Button size adjustment (mobile)
```

---

## 🎪 Special Effects

### Particle Systems

#### Meteor Explosion
```yaml
Particle Count: 30-100 (based on size)
Colors: Orange, yellow, red, brown
Size: 4-12px
Velocity: 100-300 units/sec (random direction)
Lifetime: 0.5-1.5 seconds
Gravity: Light downward pull
Fade: Exponential fade-out
```

#### Starfield Background
```yaml
Layer 1 (Far):
  Stars: 200
  Size: 1-2px
  Speed: 10 units/sec
  Parallax: 0.1x

Layer 2 (Mid):
  Stars: 150
  Size: 2-3px
  Speed: 20 units/sec
  Parallax: 0.3x

Layer 3 (Near):
  Stars: 100
  Size: 3-4px
  Speed: 40 units/sec
  Parallax: 0.6x
  Twinkle: Random fade in/out
```

#### Weapon Trails
```yaml
Laser Trail:
  Segments: 10
  Length: 100px
  Fade: Linear (100% → 0%)
  Color: Cyan with white core
  Lifetime: 200ms

Missile Trail:
  Particle Spawn: 10/second
  Color: Orange-yellow smoke
  Size: 8-16px (grows over time)
  Lifetime: 1 second
  Fade: Exponential
```

### Screen Effects

#### Boss Entrance
```yaml
Sequence:
  1. Screen freeze (200ms)
  2. Zoom into boss location (500ms)
  3. Boss reveal with lightning (300ms)
  4. Screen shake (800ms, decay)
  5. Red vignette pulse (1000ms)
  6. Return to gameplay (400ms)

Total Duration: 3.2 seconds
```

#### Critical Health Warning
```yaml
Visual:
  - Red vignette pulsing (1 Hz)
  - Screen desaturation (80%)
  - Crack overlay on edges
  
Audio:
  - Alert siren (looping)
  - Heartbeat sound (synced to pulse)
  
Haptic:
  - Pulse vibration (mobile)
  - Match visual pulse frequency
```

---

## 🎬 User Flow Diagram

```
    [Main Menu]
         |
         | [Start Game]
         ↓
    [Level Select] ─→ [Tutorial] (first time)
         |
         | [Begin]
         ↓
    [Wave Start]
         |
         | [Countdown 3-2-1]
         ↓
    [Active Gameplay] ←──────┐
         |                   │
         | [Wave Complete]   │
         ↓                   │
    [Score Summary]          │
         |                   │
         ├─→ [Next Wave] ────┘
         |
         | [Every 6 waves]
         ↓
    [Boss Intro]
         |
         ↓
    [Boss Fight] ────┐
         |           │
         | [Defeat]  | [Victory]
         ↓           ↓
    [Game Over]  [Boss Reward]
         |           |
         |           ↓
         |      [Upgrade Screen]
         |           |
         |           ↓
         |      [Continue/Exit]
         |           |
         ↓           ↓
    [Leaderboard] [Main Menu]
```

---

## 🎯 Best Practices

### Performance Guidelines

```yaml
Frame Rate Target: 60 FPS minimum

Optimization:
  - Object pooling for particles/projectiles
  - Sprite batching for similar objects
  - Limit active particles to 500 max
  - Cull off-screen objects
  - Use sprite atlases (texture packing)
  
Memory:
  - Preload common assets
  - Unload unused assets per screen
  - Compress audio files (MP3/OGG)
  - Use appropriate image resolutions
```

### Loading Experience

```yaml
Initial Load:
  - Show animated logo (2 seconds)
  - Progress bar for asset loading
  - Preload critical assets only
  - Lazy load non-critical content

Between Levels:
  - Background loading during upgrade screen
  - Subtle progress indicator
  - Seamless transition (no loading screen)
```

### User Guidance

```yaml
First-Time Experience:
  - Interactive tutorial (skippable)
  - Highlight HUD elements with tooltips
  - Practice wave with hints
  - Unlock features gradually

Tooltips:
  - Auto-show once per feature
  - Manual access via "?" button
  - Context-sensitive help
  - Clear, concise language (< 20 words)
```

---

## 📊 Metrics and Analytics (Optional)

### Track User Engagement

```yaml
Gameplay Metrics:
  - Session duration
  - Waves completed per session
  - Average score per session
  - Retry rate (game overs / sessions)
  - Power-up usage frequency
  - Weapon preference (laser vs missile %)

Progression Metrics:
  - Level reached distribution
  - Upgrade purchase patterns
  - Achievement unlock rate
  - Time to first boss defeat

Technical Metrics:
  - Load times
  - Frame rate drops
  - Crash reports
  - Device performance distribution
```

---

*End of UI/UX Design Specifications*

