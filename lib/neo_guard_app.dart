import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neo_guard/core/router/app_routers.dart';

class NeoGuardApp extends StatelessWidget {
  const NeoGuardApp({super.key, required this.appRoutes});

  final AppRoutes appRoutes;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'NeoGuard App',
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          onGenerateRoute: appRoutes.generateRoute,
        );
      },
    );
  }
}
