# NASA Eyes Feature - Usage Examples

## Quick Start

The NASA Eyes feature is now integrated into your app! You can access it from the Asteroid Impact page using the eye icon in the app bar.

## Navigation Examples

### 1. Simple Navigation

```dart
// Navigate to NASA Eyes from any screen
Navigator.pushNamed(context, Routes.nasaEyes);
```

### 2. Navigation with Custom Button

```dart
import 'package:flutter/material.dart';
import 'package:neo_guard/core/router/routes.dart';

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.remove_red_eye),
      label: const Text('Explore NASA Eyes'),
      onPressed: () {
        Navigator.pushNamed(context, Routes.nasaEyes);
      },
    );
  }
}
```

### 3. Navigation Drawer Integration

```dart
import 'package:flutter/material.dart';
import 'package:neo_guard/core/router/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('NeoGuard Menu'),
          ),
          ListTile(
            leading: Icon(Icons.calculate),
            title: Text('Impact Calculator'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.asteroidImpact);
            },
          ),
          ListTile(
            leading: Icon(Icons.remove_red_eye),
            title: Text('NASA Eyes on Asteroids'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.nasaEyes);
            },
          ),
        ],
      ),
    );
  }
}
```

### 4. Bottom Navigation Bar

```dart
import 'package:flutter/material.dart';
import 'package:neo_guard/core/router/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, Routes.asteroidImpact);
        break;
      case 1:
        Navigator.pushNamed(context, Routes.nasaEyes);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Impact Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_red_eye),
            label: 'NASA Eyes',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Your body content
    return Center(child: Text('Home Screen'));
  }
}
```

### 5. Card with Navigation

```dart
import 'package:flutter/material.dart';
import 'package:neo_guard/core/router/routes.dart';

class NasaEyesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.nasaEyes);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.remove_red_eye, size: 32, color: Colors.blue),
                  SizedBox(width: 12),
                  Text(
                    'NASA Eyes on Asteroids',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Explore real-time asteroid data with NASA\'s interactive 3D visualization.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward, color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

## Current Integration

The feature is already integrated into the **Asteroid Impact page**. Look for the eye icon (👁️) in the top-right corner of the app bar to access NASA Eyes on Asteroids.

## Testing the Feature

1. Run your app: `flutter run`
2. Navigate to the Asteroid Impact page (the default route)
3. Tap the eye icon in the app bar
4. The NASA Eyes on Asteroids website will load in a WebView

## Troubleshooting

### WebView not loading

- **Check internet connection**: The WebView requires an active internet connection
- **Check platform support**: WebView works best on Android and iOS
- **Network timeout**: Try tapping the refresh button in the app bar

### JavaScript not working

- JavaScript is enabled by default in this implementation
- If issues persist, check if the NASA website is accessible in your browser

### Performance issues

- The NASA Eyes visualization is resource-intensive
- Ensure your device has sufficient memory
- Close other apps if experiencing lag

## Platform-Specific Notes

### Android
- Minimum API level: 19 (Android 4.4)
- Internet permission is automatically handled by the webview_flutter package

### iOS
- Minimum iOS version: 11.0
- Network access is automatically handled by the webview_flutter package

### Web
- Limited WebView functionality on web platform
- Consider using an iframe or direct link for web deployment

## Advanced Usage with Cubit

### Accessing the Cubit directly

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/features/nasa_eyes/presentation/cubit/nasa_eyes_cubit.dart';
import 'package:neo_guard/features/nasa_eyes/presentation/cubit/nasa_eyes_state.dart';

class MyCustomNasaEyesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NasaEyesCubit, NasaEyesState>(
      builder: (context, state) {
        if (state is NasaEyesLoading) {
          return CircularProgressIndicator();
        } else if (state is NasaEyesError) {
          return Text('Error: ${state.message}');
        } else if (state is NasaEyesLoaded) {
          return Text('NASA Eyes loaded successfully!');
        }
        return Text('Initializing...');
      },
    );
  }
}
```

### Manual Reload

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/features/nasa_eyes/presentation/cubit/nasa_eyes_cubit.dart';

class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        context.read<NasaEyesCubit>().reload();
      },
    );
  }
}
```

## Additional Resources

- [NASA Eyes on Asteroids](https://eyes.nasa.gov/apps/asteroids/#/home)
- [webview_flutter documentation](https://pub.dev/packages/webview_flutter)
- [flutter_bloc documentation](https://pub.dev/packages/flutter_bloc)
