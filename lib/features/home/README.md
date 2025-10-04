# Home Page Feature

The main landing page of the NeoGuard app that provides navigation to all features.

## Overview

The home page serves as the central hub of the application, showcasing all available features with beautiful, interactive cards. It follows the app's space-themed design with animated starfield backgrounds and gradient styling.

## Design Features

### Visual Elements

- **Animated Starfield Background**: Dynamic star animation for an immersive space theme
- **Gradient Cards**: Each feature has a unique gradient color scheme
- **Glassmorphism Effect**: Frosted glass effect with backdrop blur
- **Glow Effects**: Subtle shadows and glows for depth
- **Responsive Layout**: Adapts to different screen sizes

### Color Schemes

1. **Asteroid Impact Calculator**
   - Purple to Blue gradient
   - Purple accent border

2. **NASA Eyes on Asteroids**
   - Blue to Indigo gradient
   - Blue accent border

## Structure

```
lib/features/home/
└── presentation/
    └── pages/
        └── home_page.dart    # Main home page
```

## Navigation

The home page is the default route (`/`) of the application. Users can navigate to:

1. **Asteroid Impact Calculator** (`/asteroid-impact`)
2. **NASA Eyes on Asteroids** (`/nasa-eyes`)

## Components

### Header Section
- App icon with gradient circle
- App title "NEOGUARD" with shader gradient
- System status indicator
- Tagline

### Feature Cards
Each card includes:
- Icon with background
- Feature title
- Description
- Call-to-action label
- Arrow indicator
- Tap gesture for navigation

### Footer
- Divider
- Credits text
- Security badge

## Usage

The home page is automatically displayed when the app launches. No additional setup is required.

### Modifying Feature Cards

To add a new feature card, use the `_buildFeatureCard` method:

```dart
_buildFeatureCard(
  context: context,
  title: 'YOUR FEATURE\nTITLE',
  description: 'Feature description here',
  icon: Icons.your_icon,
  gradient: LinearGradient(
    colors: [color1, color2],
  ),
  borderColor: AppColors.yourColor,
  route: Routes.yourRoute,
)
```

## Customization

### Changing Colors
Update the gradient colors in the `_buildFeatureCards` method to match your preferences.

### Modifying Layout
The cards are stacked vertically. For a grid layout on larger screens, wrap the cards in a `GridView` or use responsive layout builders.

### Adding More Features
Simply add more `_buildFeatureCard` calls in the `_buildFeatureCards` method.

## Animation

The starfield animation is reused from the Asteroid Impact feature, providing consistency across the app.

## Accessibility

- All interactive elements have appropriate tap targets
- Text uses high contrast colors for readability
- Icons provide visual cues for navigation

## Future Enhancements

Potential improvements:

1. **Card Animations**: Add entrance animations for cards
2. **Hero Transitions**: Smooth transitions when navigating to features
3. **Quick Stats**: Display quick stats about asteroids on cards
4. **Search Bar**: Add search functionality for features
5. **Settings Button**: Access to app settings from home
6. **Notifications**: Display alerts about near-Earth objects
7. **News Feed**: Show latest asteroid/space news


