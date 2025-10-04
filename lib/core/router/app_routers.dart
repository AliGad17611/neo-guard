import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/core/di/service_locator.dart' as di;
import 'package:neo_guard/core/router/routes.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/cubit/impact_calculator_cubit.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/pages/asteroid_impact_page.dart';
import 'package:neo_guard/features/education/presentation/screens/definitions_screen.dart';
import 'package:neo_guard/features/education/presentation/screens/education_screen.dart';
import 'package:neo_guard/features/education/presentation/screens/videos_screen.dart';
import 'package:neo_guard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:neo_guard/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:neo_guard/features/nasa_eyes/presentation/cubit/nasa_eyes_cubit.dart';
import 'package:neo_guard/features/nasa_eyes/presentation/pages/nasa_eyes_page.dart';
import 'package:neo_guard/features/meteor_madness/presentation/cubit/meteor_madness_cubit.dart';
import 'package:neo_guard/features/meteor_madness/presentation/screens/meteor_madness_page.dart';
import 'package:neo_guard/features/meteor_madness/presentation/screens/level_selection_page.dart';
import 'package:neo_guard/features/home/presentation/pages/home_page.dart';
import 'package:neo_guard/features/quiz/presentation/screens/quiz_level_screen.dart';

class AppRoutes {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => di.sl<DashboardCubit>(),
            child: const DashboardPage(),
          ),
        );
      case Routes.asteroidImpact:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => di.sl<ImpactCalculatorCubit>(),
            child: const AsteroidImpactPage(),
          ),
        );
      case Routes.nasaEyes:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => di.sl<NasaEyesCubit>(),
            child: const NasaEyesPage(),
          ),
        );
      case Routes.meteorMadness:
        return MaterialPageRoute(builder: (_) => const LevelSelectionPage());
      case Routes.meteorMadnessPlay:
        final difficulty =
            settings.arguments as GameDifficulty? ?? GameDifficulty.normal;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => di.sl<MeteorMadnessCubit>(),
            child: MeteorMadnessPage(difficulty: difficulty),
          ),
        );
      case Routes.quiz:
        return MaterialPageRoute(builder: (_) => const QuizLevelScreen());
      case Routes.education:
        return MaterialPageRoute(builder: (_) => const EducationScreen());
      case Routes.educationDefinitions:
        return MaterialPageRoute(builder: (_) => const DefinitionsScreen());
      case Routes.educationVideos:
        return MaterialPageRoute(builder: (_) => const VideosScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
