# 🌍 NASA Asteroid Impact Calculator

A comprehensive, scientifically-accurate asteroid impact simulator with stunning visual effects and real-time calculations.

## 📋 Features

### ✨ Core Functionality
- **Real-time Preview**: Calculations update as you type (300ms debounced)
- **Physics-Based Simulations**: Accurate impact calculations using real physics formulas
- **Multiple Impact Scenarios**: Land and ocean impact support
- **Cinematic Animations**: 2-second impact sequence with multiple visual effects
- **Severity Classification**: 5 threat levels from Local Damage to Extinction Level
- **Tsunami Detection**: Automatic warnings for ocean impacts

### 🎨 Visual Effects
- **Animated Starfield**: 150+ twinkling stars for space atmosphere
- **Radar Sweep**: Continuous scanning animation
- **Falling Asteroid**: Realistic falling animation with rotation and particle trail
- **Screen Shake**: Impact feedback on collision
- **Explosion Effects**: Multi-layered explosion with shockwaves and particles
- **Tsunami Animation**: Wave propagation effect for ocean impacts

### 🏗️ Architecture

This feature follows **Clean Architecture** principles with **Cubit** state management:

```
asteroid_impact/
├── domain/                      # Business Logic Layer
│   ├── entities/
│   │   ├── asteroid_parameters.dart    # Input parameters
│   │   └── impact_result.dart          # Calculation results
│   ├── usecases/
│   │   └── calculate_impact.dart       # Use case
│   └── repositories/
│       └── impact_calculator_repository.dart  # Repository interface
│
├── data/                        # Data Layer
│   ├── models/
│   │   └── impact_result_model.dart    # Data model
│   ├── datasources/
│   │   └── impact_calculation_service.dart  # Physics calculations
│   └── repositories/
│       └── impact_calculator_repository_impl.dart  # Repository implementation
│
└── presentation/                # Presentation Layer
    ├── cubit/
    │   ├── impact_calculator_cubit.dart     # State management
    │   └── impact_calculator_state.dart     # States
    ├── pages/
    │   └── asteroid_impact_page.dart        # Main page
    └── widgets/
        ├── input_panel.dart                 # Input controls
        ├── impact_visualization.dart        # Animation canvas
        ├── stats_display.dart               # Results display
        ├── severity_badge.dart              # Threat level badge
        └── tsunami_warning.dart             # Ocean impact warning
```

## 🧮 Physics Calculations

### Mass Calculation
```dart
// Assumes spherical rocky asteroid with density = 2500 kg/m³
volume = (4/3) × π × (diameter/2)³
mass = volume × 2500
```

### Kinetic Energy
```dart
// Convert km/s to m/s
velocityMs = velocity × 1000
kineticEnergy = 0.5 × mass × velocityMs²
```

### TNT Equivalent
```dart
// Energy per kg of TNT = 4.184 × 10⁹ Joules
tntEquivalent = kineticEnergy / 4.184e9
megatons = tntEquivalent / 1e9
```

### Crater Diameter
```dart
craterDiameter = (kineticEnergy / 1e15)^0.25 × 100 meters
```

### Damage Radius
```dart
damageRadius = √megatons × 5 kilometers
```

## 🎯 Severity Levels

| Level | Megatons | Color | Icon | Description |
|-------|----------|-------|------|-------------|
| Local Damage | < 1 MT | Green-Blue | ⚠️ | Limited local destruction |
| City Destruction | 1-10 MT | Blue-Purple | 🏙️ | Major urban damage |
| Major Disaster | 10-100 MT | Yellow-Orange | 🔥 | Regional devastation |
| Regional Catastrophe | 100-1000 MT | Orange-Red | 🌋 | Continental impact |
| Extinction Level | > 1000 MT | Red-Dark Red | 💀 | Global extinction event |

## 🎬 Animation Sequence

1. **Initial State** (0s)
   - Starfield animation active
   - Radar sweep continuous
   - Crosshair marks impact point

2. **Asteroid Fall** (0-1.5s)
   - Asteroid enters from top of screen
   - Rotates during descent
   - 20 particle trail behind asteroid
   - Curved trajectory toward target

3. **Impact** (1.5s)
   - Screen shake effect
   - Flash of light
   - Sound trigger point

4. **Explosion** (1.5-3s)
   - 4 expanding shockwave rings
   - 20 explosion particles
   - Glowing core with blur
   - Color transition (white → yellow → orange → red)

5. **Aftermath** (3s+)
   - Results displayed
   - Explosion fades
   - Reset available

## 🎨 Color Scheme

### Primary Gradient
```dart
LinearGradient(
  colors: [0xFF4F46E5, 0xFF7C3AED, 0xFF2563EB]  // Indigo-Purple-Blue
)
```

### Background
```dart
LinearGradient(
  colors: [0xFF0F172A, 0xFF1E1B4B, 0xFF312E81]  // Dark space theme
)
```

### Glassmorphism
- Backdrop blur: 10px
- White overlay: 5-10% opacity
- Border: 20% white opacity

## 🚀 Usage

### Navigation
```dart
Navigator.of(context).pushNamed(Routes.asteroidImpact);
```

### Direct Usage
```dart
import 'package:neo_guard/features/asteroid_impact/presentation/pages/asteroid_impact_page.dart';

// In your widget tree
AsteroidImpactPage()
```

## 📱 Responsive Design

- **Mobile**: Single column layout (< 900px width)
- **Tablet/Desktop**: Two column layout (≥ 900px width)
  - Left: Input + Results
  - Right: Visualization

## ⚡ Performance Optimizations

1. **Debouncing**: Preview calculations debounced by 300ms
2. **Particle Limits**: Max 20 particles in explosion
3. **CustomPainter**: Hardware-accelerated rendering
4. **Lazy Star Generation**: Stars generated once on init
5. **Animation Controllers**: Properly disposed to prevent memory leaks

## 🧪 Testing Scenarios

### Test Cases

1. **Small Asteroid**
   - Diameter: 10m, Velocity: 10 km/s
   - Expected: Local Damage

2. **Medium Asteroid**
   - Diameter: 100m, Velocity: 20 km/s
   - Expected: City Destruction

3. **Large Asteroid**
   - Diameter: 1000m, Velocity: 30 km/s
   - Expected: Regional Catastrophe

4. **Chicxulub-like**
   - Diameter: 10,000m, Velocity: 20 km/s
   - Expected: Extinction Level

5. **Ocean Impact**
   - Any size + Ocean location
   - Expected: Tsunami warning visible

## 🔮 Future Enhancements

- [ ] Save/load impact scenarios
- [ ] Compare multiple asteroids side-by-side
- [ ] 3D visualization using Flutter 3D
- [ ] Historical impact database (Tunguska, Chicxulub, etc.)
- [ ] Export results as PDF/image
- [ ] Multi-language support (Arabic included)
- [ ] Share to social media
- [ ] Sound effects
- [ ] Haptic feedback on mobile
- [ ] Dark/Light theme toggle
- [ ] Advanced parameters (composition, angle, etc.)

## 📚 Dependencies

Required packages (already in pubspec.yaml):
- `flutter_bloc: ^8.1.6` - State management
- `equatable: ^2.0.5` - Value equality

## 🎓 Educational Value

This calculator demonstrates:
- **Physics**: Kinetic energy, momentum, impact mechanics
- **Astronomy**: Asteroid properties, orbital mechanics
- **Geology**: Crater formation
- **Mathematics**: Exponential calculations, square roots

Perfect for:
- STEM education
- NASA outreach programs
- Science museums
- Educational apps

## 📄 License

Part of the NEO Guard App - NASA Space Apps Challenge 2025

---

**Built with ❤️ using Flutter & Clean Architecture**



