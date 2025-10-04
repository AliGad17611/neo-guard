import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_guard/core/di/service_locator.dart' as di;
import 'package:neo_guard/core/router/app_routers.dart';
import 'package:neo_guard/neo_guard_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependency injection
  await di.init();
  
  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(NeoGuardApp(appRoutes: AppRoutes()));
}
