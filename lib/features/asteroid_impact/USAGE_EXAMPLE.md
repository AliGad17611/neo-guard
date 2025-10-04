# 🚀 Asteroid Impact Calculator - Usage Examples

## Quick Start Guide

### 1. Basic Navigation

Add the asteroid impact calculator to your app's navigation:

```dart
// In main.dart or your router
import 'package:neo_guard/core/router/routes.dart';

// Navigate to calculator
Navigator.of(context).pushNamed(Routes.asteroidImpact);

// Or use MaterialPageRoute
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AsteroidImpactPage(),
  ),
);
```

### 2. Adding a Navigation Button

```dart
// Example: Add button to home screen
ElevatedButton(
  onPressed: () {
    Navigator.of(context).pushNamed(Routes.asteroidImpact);
  },
  child: Row(
    children: [
      Icon(Icons.public),
      SizedBox(width: 8),
      Text('Asteroid Impact Calculator'),
    ],
  ),
)
```

### 3. Programmatic Usage

If you want to use the calculator logic in your own custom UI:

```dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/features/asteroid_impact/domain/entities/asteroid_parameters.dart';
import 'package:neo_guard/features/asteroid_impact/data/datasources/impact_calculation_service.dart';
import 'package:neo_guard/features/asteroid_impact/data/repositories/impact_calculator_repository_impl.dart';
import 'package:neo_guard/features/asteroid_impact/domain/usecases/calculate_impact.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/cubit/impact_calculator_cubit.dart';

class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final service = ImpactCalculationService();
        final repository = ImpactCalculatorRepositoryImpl(service);
        final useCase = CalculateImpact(repository);
        return ImpactCalculatorCubit(
          calculateImpactUseCase: useCase,
          calculationService: service,
        );
      },
      child: BlocBuilder<ImpactCalculatorCubit, ImpactCalculatorState>(
        builder: (context, state) {
          // Your custom UI here
          return Container(
            child: Text('Custom impact calculator UI'),
          );
        },
      ),
    );
  }
}
```

### 4. Direct Calculation (Without UI)

```dart
import 'package:neo_guard/features/asteroid_impact/domain/entities/asteroid_parameters.dart';
import 'package:neo_guard/features/asteroid_impact/data/datasources/impact_calculation_service.dart';

void calculateImpactExample() async {
  final service = ImpactCalculationService();
  
  final parameters = AsteroidParameters(
    diameter: 100, // meters
    velocity: 20,  // km/s
    isOceanImpact: false,
  );
  
  final result = await service.calculateImpact(parameters);
  
  print('Impact Energy: ${result.megatons.toStringAsFixed(2)} MT');
  print('Crater Diameter: ${result.craterDiameter.toStringAsFixed(2)} m');
  print('Damage Radius: ${result.damageRadius.toStringAsFixed(2)} km');
  print('Severity: ${result.severityLevel}');
}
```

## 📝 Example Scenarios

### Scenario 1: Small Meteorite (Chelyabinsk-like)
```dart
final parameters = AsteroidParameters(
  diameter: 20,      // 20 meters
  velocity: 19,      // 19 km/s
  isOceanImpact: false,
);
// Expected: Local Damage, ~0.5 MT
```

### Scenario 2: City Killer
```dart
final parameters = AsteroidParameters(
  diameter: 100,     // 100 meters
  velocity: 25,      // 25 km/s
  isOceanImpact: false,
);
// Expected: City Destruction, 5-10 MT
```

### Scenario 3: Regional Catastrophe (Tunguska-like)
```dart
final parameters = AsteroidParameters(
  diameter: 200,     // 200 meters
  velocity: 20,      // 20 km/s
  isOceanImpact: false,
);
// Expected: Major Disaster, ~50 MT
```

### Scenario 4: Ocean Impact with Tsunami
```dart
final parameters = AsteroidParameters(
  diameter: 500,     // 500 meters
  velocity: 30,      // 30 km/s
  isOceanImpact: true,  // Ocean impact!
);
// Expected: Regional Catastrophe + Tsunami Warning
```

### Scenario 5: Dinosaur Killer (Chicxulub)
```dart
final parameters = AsteroidParameters(
  diameter: 10000,   // 10 km
  velocity: 20,      // 20 km/s
  isOceanImpact: false,
);
// Expected: Extinction Level, 100,000+ MT
```

## 🎮 Interactive Testing

### Test the Preview Mode
1. Open the calculator
2. Start typing values in the inputs
3. Watch results update in real-time (debounced 300ms)
4. No need to press "Calculate" for preview

### Test the Full Animation
1. Enter valid parameters
2. Press "🚀 CALCULATE IMPACT"
3. Watch the 2-second animation sequence:
   - Crosshair appears
   - Asteroid falls
   - Explosion on impact
   - Screen shakes
   - Results displayed

### Test Tsunami Warning
1. Enter any valid asteroid size
2. Select "🌊 OCEAN" as impact location
3. Press calculate
4. Observe animated tsunami warning appears

### Test Different Severity Levels
Try these combinations to see all severity badges:

| Diameter | Velocity | Expected Severity |
|----------|----------|-------------------|
| 10m | 10 km/s | Local Damage (Green) |
| 50m | 20 km/s | City Destruction (Blue) |
| 200m | 25 km/s | Major Disaster (Orange) |
| 1000m | 20 km/s | Regional Catastrophe (Red) |
| 10000m | 20 km/s | Extinction Level (Dark Red) |

## 🔧 Customization Examples

### Custom Color Scheme

To customize colors, modify the severity colors in `impact_result.dart`:

```dart
List<int> get severityColors {
  switch (severityLevel) {
    case 'EXTINCTION LEVEL':
      return [0xFFYOURCOLOR1, 0xFFYOURCOLOR2];
    // ... etc
  }
}
```

### Custom Animation Duration

Modify timing in `impact_calculator_cubit.dart`:

```dart
// Change total animation time
await Future.delayed(const Duration(milliseconds: YOUR_TIME));
```

### Custom Particle Count

In `impact_visualization.dart`, change the loop count:

```dart
// Instead of 20 particles:
for (int i = 0; i < YOUR_COUNT; i++) {
  // particle drawing code
}
```

## 🐛 Troubleshooting

### Issue: Calculations not updating
**Solution**: Ensure parameters are valid (diameter > 0, velocity > 0)

### Issue: Animation not playing
**Solution**: Check that you pressed "Calculate Impact" button, not just typing values

### Issue: Tsunami warning not showing
**Solution**: Make sure "Ocean" location is selected

### Issue: Route not found
**Solution**: Verify route is added to `app_routers.dart`:
```dart
case Routes.asteroidImpact:
  return MaterialPageRoute(
    builder: (_) => const AsteroidImpactPage(),
  );
```

## 📊 Performance Tips

1. **Avoid rapid recalculations**: The 300ms debounce handles this automatically
2. **Don't create multiple instances**: Use BlocProvider to share state
3. **Dispose properly**: The cubit handles cleanup automatically
4. **Use const constructors**: Already implemented in all widgets

## 🎯 Integration with Other Features

### Example: Add to Dashboard
```dart
// In your dashboard grid
GridView.count(
  children: [
    DashboardCard(
      title: 'Impact Calculator',
      icon: Icons.public,
      onTap: () => Navigator.pushNamed(
        context,
        Routes.asteroidImpact,
      ),
    ),
    // ... other cards
  ],
)
```

### Example: Add to NEO Details Page
```dart
// Show calculator with pre-filled data from a real NEO
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AsteroidImpactPage(
          initialDiameter: neo.diameter,
          initialVelocity: neo.velocity,
        ),
      ),
    );
  },
  child: Text('Simulate Impact'),
)
```

---

**Need more help?** Check the main README.md or the inline code documentation.



