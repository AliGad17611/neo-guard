# 🌌 NASA Eyes on Asteroids

An integrated WebView feature that embeds NASA's Eyes on Asteroids interactive visualization directly into the app.

## 📋 Features

### ✨ Core Functionality
- **NASA Eyes Integration**: Full WebView embedding of NASA's Eyes on Asteroids
- **State Management**: Cubit-based state management for loading, error, and success states
- **Error Handling**: Graceful error handling with retry functionality
- **Loading States**: Visual feedback during page load
- **Refresh Capability**: Manual refresh of the WebView content

### 🎨 Visual Features
- **Loading Animation**: Circular progress indicator with loading message
- **Error Display**: User-friendly error messages with retry button
- **Dark Theme**: Consistent black background matching space theme
- **App Bar Actions**: Quick access to refresh functionality

### 🏗️ Architecture

This feature follows **Clean Architecture** principles with **Cubit** state management:

```
nasa_eyes/
├── presentation/
│   ├── cubit/
│   │   ├── nasa_eyes_cubit.dart       # State management
│   │   └── nasa_eyes_state.dart       # State definitions
│   ├── pages/
│   │   └── nasa_eyes_page.dart        # Main page
│   └── widgets/
│       ├── error_view.dart            # Error display widget
│       ├── loading_view.dart          # Loading display widget
│       └── webview_actions.dart       # App bar actions
```

## 🧩 Components

### States
- **NasaEyesInitial**: Initial state before loading
- **NasaEyesLoading**: WebView is loading content
- **NasaEyesLoaded**: WebView content loaded successfully
- **NasaEyesError**: Error occurred during loading

### Widgets
- **LoadingView**: Displays circular progress indicator with message
- **ErrorView**: Shows error message with retry button
- **WebViewActions**: App bar refresh button

### Cubit
- **NasaEyesCubit**: Manages WebView controller and states
  - `reload()`: Reloads the current page
  - `retry()`: Retries loading after an error

## 🚀 Usage

The NASA Eyes page is accessible through the app router:

```dart
Navigator.pushNamed(context, Routes.nasaEyes);
```

The Cubit is automatically provided via BlocProvider in the router configuration.

## 🔧 Configuration

### Dependency Injection
The cubit is registered in `service_locator.dart`:

```dart
sl.registerFactory(() => NasaEyesCubit());
```

### Routing
Route configuration in `app_routers.dart`:

```dart
case Routes.nasaEyes:
  return MaterialPageRoute(
    builder: (_) => BlocProvider(
      create: (_) => di.sl<NasaEyesCubit>(),
      child: const NasaEyesPage(),
    ),
  );
```

## 📱 WebView Configuration

- **JavaScript**: Enabled (unrestricted mode)
- **Background**: Black color for space theme
- **URL**: `https://eyes.nasa.gov/apps/asteroids/#/home`
- **Navigation Delegate**: Handles page lifecycle and errors

## 🎯 Integration Points

This feature integrates with:
- **Asteroid Impact Calculator**: Accessible via app bar icon from Impact page
- **Home Page**: Direct navigation to NASA Eyes visualization
- **App Router**: Centralized routing configuration
