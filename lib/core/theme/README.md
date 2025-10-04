# 🎨 NeoGuard App Theme System

NASA-themed design system based on the Asteroid Impact Calculator specifications.

## 📁 Files Structure

```
lib/core/theme/
├── app_colors.dart      # Complete color palette
├── app_theme.dart       # Theme configuration
└── README.md           # This file
```

## 🎨 Color Palette

### Primary Colors (Purple-Blue NASA Theme)
```dart
AppColors.primaryIndigo     // #4F46E5
AppColors.primaryPurple     // #7C3AED
AppColors.primaryBlue       // #2563EB
AppColors.primaryGradient   // Gradient of above
```

### Background Colors (Dark Space Theme)
```dart
AppColors.backgroundDarkest  // #0F172A
AppColors.backgroundDark     // #1E1B4B
AppColors.backgroundMedium   // #312E81
AppColors.backgroundGradient // Gradient of above
```

### Severity Level Colors (Threat Classification)

#### Extinction Level (> 1000 MT)
```dart
AppColors.extinctionRed      // #DC2626
AppColors.extinctionDarkRed  // #991B1B
AppColors.extinctionGradient
```

#### Regional Catastrophe (100-1000 MT)
```dart
AppColors.regionalOrange     // #EA580C
AppColors.regionalRed        // #DC2626
AppColors.regionalGradient
```

#### Major Disaster (10-100 MT)
```dart
AppColors.majorYellow        // #CA8A04
AppColors.majorOrange        // #EA580C
AppColors.majorGradient
```

#### City Destruction (1-10 MT)
```dart
AppColors.cityBlue           // #2563EB
AppColors.cityPurple         // #7C3AED
AppColors.cityGradient
```

#### Local Damage (< 1 MT)
```dart
AppColors.localGreen         // #059669
AppColors.localBlue          // #2563EB
AppColors.localGradient
```

### Tsunami Warning Colors
```dart
AppColors.tsunamiCyan        // #0EA5E9
AppColors.tsunamiBlue        // #0284C7
AppColors.tsunamiGradient
```

### Action Colors
```dart
AppColors.successGreen       // #059669
AppColors.successLightGreen  // #10B981
AppColors.successGradient
```

### Accent Colors
```dart
AppColors.accentCyan         // #06B6D4
AppColors.accentAmber        // #FBBF24
AppColors.accentOrange       // #F97316
AppColors.accentRed          // #EF4444
AppColors.accentPurple       // #8B5CF6
AppColors.accentYellow       // #EAB308
AppColors.accentPink         // #F472B6
AppColors.accentSkyBlue      // #60A5FA
AppColors.accentLavender     // #A78BFA
```

### Text Colors
```dart
AppColors.textPrimary        // White
AppColors.textSecondary      // #E5E7EB
AppColors.textTertiary       // #9CA3AF
AppColors.textDisabled       // #6B7280
```

### Glassmorphism Colors
```dart
AppColors.glassLight         // White with 10% opacity
AppColors.glassDark          // White with 5% opacity
AppColors.glassBorder        // White with 20% opacity
AppColors.glassGradient
```

### Status Colors
```dart
AppColors.errorRed           // #DC2626
AppColors.warningAmber       // #F59E0B
AppColors.infoBlue           // #3B82F6
AppColors.successEmerald     // #10B981
```

## 🎯 Usage Examples

### Using Colors
```dart
// Direct color
Container(
  color: AppColors.primaryIndigo,
)

// Gradient
Container(
  decoration: BoxDecoration(
    gradient: AppColors.primaryGradient,
  ),
)

// Helper methods
Container(
  decoration: BoxDecoration(
    gradient: AppColors.getSeverityGradient(1500), // Auto-selects based on MT
  ),
)
```

### Using Theme
```dart
// In MaterialApp
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.dark, // NASA theme is dark by default
)

// Access theme in widgets
Text(
  'Hello',
  style: Theme.of(context).textTheme.headlineLarge,
)

// Use predefined decorations
Container(
  decoration: AppTheme.glassCard,
  child: Text('Glassmorphism card'),
)
```

### Custom Widgets with Theme
```dart
// Severity badge
Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: AppColors.getSeverityColors('EXTINCTION LEVEL')
        .map((color) => Color(color))
        .toList(),
    ),
    borderRadius: BorderRadius.circular(16),
  ),
)

// Glass panel with blur
ClipRRect(
  borderRadius: BorderRadius.circular(20),
  child: BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: Container(
      decoration: AppTheme.glassCard,
      child: YourContent(),
    ),
  ),
)
```

## 📐 Spacing Constants
```dart
AppTheme.spacingXS   // 4.0
AppTheme.spacingS    // 8.0
AppTheme.spacingM    // 16.0
AppTheme.spacingL    // 24.0
AppTheme.spacingXL   // 32.0
AppTheme.spacingXXL  // 48.0
```

## 🔘 Border Radius Constants
```dart
AppTheme.radiusS      // 8.0
AppTheme.radiusM      // 12.0
AppTheme.radiusL      // 16.0
AppTheme.radiusXL     // 20.0
AppTheme.radiusRound  // 999.0 (fully rounded)
```

## 🎨 Pre-built Decorations

### Glass Card
```dart
Container(
  decoration: AppTheme.glassCard,
  // Glassmorphism effect with blur
)
```

### Primary Gradient Card
```dart
Container(
  decoration: AppTheme.primaryGradientCard,
  // Purple-blue gradient with shadow
)
```

### Space Background
```dart
Container(
  decoration: AppTheme.spaceBackground,
  // Dark space gradient background
)
```

## 📱 Typography

All text styles use **Google Fonts - Inter** for a modern, clean look.

### Display Styles (Largest)
- `displayLarge` - 57sp, Bold
- `displayMedium` - 45sp, Bold
- `displaySmall` - 36sp, Bold

### Headline Styles
- `headlineLarge` - 32sp, Bold, 2.0 letter-spacing
- `headlineMedium` - 28sp, Bold, 1.5 letter-spacing
- `headlineSmall` - 24sp, Bold, 1.2 letter-spacing

### Title Styles
- `titleLarge` - 22sp, Bold
- `titleMedium` - 18sp, Bold, 1.5 letter-spacing
- `titleSmall` - 16sp, SemiBold

### Body Styles
- `bodyLarge` - 16sp, Regular
- `bodyMedium` - 14sp, Regular
- `bodySmall` - 12sp, Regular

### Label Styles
- `labelLarge` - 14sp, SemiBold, 0.5 letter-spacing
- `labelMedium` - 12sp, SemiBold, 0.5 letter-spacing
- `labelSmall` - 11sp, SemiBold, 0.5 letter-spacing

## 🎯 Design Principles

### 1. NASA Mission Control Aesthetic
- Dark space backgrounds
- High-tech glassmorphism effects
- Purple-blue color scheme
- Bold, clear typography

### 2. Scientific Accuracy
- Color-coded severity levels
- Clear visual hierarchy
- Professional data visualization

### 3. Accessibility
- High contrast text
- Clear focus indicators
- Semantic color usage
- Readable font sizes

### 4. Consistency
- Standardized spacing
- Consistent border radius
- Unified color palette
- Reusable components

## 🔧 Customization

To customize the theme:

1. **Modify Colors**: Edit `app_colors.dart`
2. **Adjust Typography**: Edit text theme in `app_theme.dart`
3. **Change Components**: Modify component themes in `app_theme.dart`

## 📚 Related Documentation

- [Asteroid Impact Calculator](../../features/asteroid_impact/README.md)
- [Flutter Material Design 3](https://m3.material.io/)
- [Google Fonts](https://fonts.google.com/specimen/Inter)

---

**Built for NASA Space Apps Challenge 2025** 🚀


