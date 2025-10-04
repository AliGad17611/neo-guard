import 'package:flutter/material.dart';
import 'package:neo_guard/core/router/routes.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/widgets/animated_starfield.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text('Education Center',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,

        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: const Stack(
          children: [
            Positioned.fill(child: AnimatedStarfield()),
            SafeArea(
              child: EducationHub(),
            ),
          ],
        ),
      ),
    );
  }
}

class EducationHub extends StatelessWidget {
  const EducationHub({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        EducationCard(
          title: 'Definitions',
          description: 'Learn the key terms and concepts in planetary defense.',
          icon: Icons.book,
          gradient: const LinearGradient(
            colors: [AppColors.purple600, AppColors.blue600],
          ),
          borderColor: AppColors.purple400,
          route: Routes.educationDefinitions,
        ),
        EducationCard(
          title: 'Videos',
          description: 'Watch engaging videos on asteroids, comets, and space missions.',
          icon: Icons.play_circle_fill,
          gradient: const LinearGradient(
            colors: [AppColors.blue600, AppColors.indigo600],
          ),
          borderColor: AppColors.blue400,
          route: Routes.educationVideos,
        ),
        EducationCard(
          title: 'Quizzes',
          description: 'Test your knowledge and earn badges.',
          icon: Icons.quiz,
          gradient: const LinearGradient(
            colors: [AppColors.indigo600, AppColors.purple600],
          ),
          borderColor: AppColors.indigo400,
          route: Routes.quiz,
        ),
      ],
    );
  }
}

class EducationCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Gradient gradient;
  final Color borderColor;
  final String route;

  const EducationCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
    required this.borderColor,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.transparent,
      elevation: 0,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: borderColor.withValues(alpha:0.7),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: borderColor.withValues(alpha:0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(color: AppColors.purple200, fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
