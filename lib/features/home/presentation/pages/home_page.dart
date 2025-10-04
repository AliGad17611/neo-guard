import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/core/router/routes.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/widgets/animated_starfield.dart';
import 'package:neo_guard/features/home/presentation/widgets/home_header.dart';
import 'package:neo_guard/features/home/presentation/widgets/home_feature_card.dart';
import 'package:neo_guard/features/home/presentation/widgets/home_footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            // Animated starfield background
            const Positioned.fill(child: AnimatedStarfield()),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    const HomeHeader(),
                    const SizedBox(height: 60),
                    _buildFeatureCards(),
                    const SizedBox(height: 40),
                    const HomeFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCards() {
    return Column(
      children: [
        HomeFeatureCard(
          title: 'NEO DASHBOARD',
          description:
              'Track Near Earth Objects in real-time with NASA\'s official API',
          icon: Icons.space_dashboard,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.blue600.withValues(alpha: 0.8),
              AppColors.purple600.withValues(alpha: 0.8),
            ],
          ),
          borderColor: AppColors.blue400,
          route: Routes.dashboard,
        ),
        const SizedBox(height: 20),
        HomeFeatureCard(
          title: 'ASTEROID IMPACT\nCALCULATOR',
          description:
              'Calculate the devastating effects of asteroid impacts on Earth',
          icon: Icons.calculate,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.purple600.withValues(alpha: 0.8),
              AppColors.blue600.withValues(alpha: 0.8),
            ],
          ),
          borderColor: AppColors.purple400,
          route: Routes.asteroidImpact,
        ),
        const SizedBox(height: 20),
        HomeFeatureCard(
          title: 'NASA EYES ON\nASTEROIDS',
          description:
              'Explore real-time asteroid data with NASA\'s interactive 3D visualization',
          icon: Icons.remove_red_eye,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.blue600.withValues(alpha: 0.8),
              AppColors.indigo600.withValues(alpha: 0.8),
            ],
          ),
          borderColor: AppColors.blue400,
          route: Routes.nasaEyes,
        ),
        const SizedBox(height: 20),
        HomeFeatureCard(
          title: 'EDUCATION CENTER',
          description:
              'Learn about asteroids, planetary defense, and space exploration',
          icon: Icons.school,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.purple600.withValues(alpha: 0.8),
              AppColors.blue600.withValues(alpha: 0.8),
            ],
          ),
          borderColor: AppColors.purple400,
          route: Routes.education,
        ),
        const SizedBox(height: 20),
        HomeFeatureCard(
          title: 'METEOR MADNESS\nGAME',
          description:
              'Defend your planet from incoming meteors in this action-packed space defense game',
          icon: Icons.games,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.indigo600.withValues(alpha: 0.8),
              AppColors.purple600.withValues(alpha: 0.8),
            ],
          ),
          borderColor: AppColors.indigo400,
          route: Routes.meteorMadness,
        ),
      ],
    );
  }
}
