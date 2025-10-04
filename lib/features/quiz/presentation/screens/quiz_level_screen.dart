import 'package:flutter/material.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/widgets/animated_starfield.dart';
import 'package:neo_guard/features/quiz/data/datasources/easy_questions.dart';
import 'package:neo_guard/features/quiz/data/datasources/hard_questions.dart';
import 'package:neo_guard/features/quiz/data/datasources/medium_questions.dart';
import 'package:neo_guard/features/quiz/data/models/question.dart';
import 'package:neo_guard/features/quiz/presentation/screens/quiz_screen.dart';

enum QuizDifficulty { easy, medium, hard }

class QuizLevelScreen extends StatelessWidget {
  const QuizLevelScreen({super.key});

  void _navigateToQuiz(BuildContext context, QuizDifficulty difficulty) {
    List<Question> questions;
    switch (difficulty) {
      case QuizDifficulty.easy:
        questions = easyQuestions;
        break;
      case QuizDifficulty.medium:
        questions = mediumQuestions;
        break;
      case QuizDifficulty.hard:
        questions = hardQuestions;
        break;
    }

    if (questions.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => QuizScreen(questions: questions),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${difficulty.name} level is not yet implemented.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text('Select Quiz Level',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,

        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Stack(
          children: [
            const Positioned.fill(child: AnimatedStarfield()),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLevelButton(
                      context,
                      title: 'Easy',
                      icon: Icons.thermostat_auto,
                      gradient: const LinearGradient(
                        colors: [AppColors.blue500, AppColors.purple500],
                      ),
                      borderColor: AppColors.blue300,
                      onTap: () => _navigateToQuiz(context, QuizDifficulty.easy),
                    ),
                    const SizedBox(height: 20),
                    _buildLevelButton(
                      context,
                      title: 'Medium',
                      icon: Icons.thermostat,
                      gradient: const LinearGradient(
                        colors: [AppColors.green400, AppColors.blue400],
                      ),
                      borderColor: AppColors.green400,
                      onTap: () => _navigateToQuiz(context, QuizDifficulty.medium),
                    ),
                    const SizedBox(height: 20),
                    _buildLevelButton(
                      context,
                      title: 'Hard',
                      icon: Icons.local_fire_department,
                      gradient: const LinearGradient(
                        colors: [AppColors.red600, AppColors.red800],
                      ),
                      borderColor: AppColors.red400,
                      onTap: () => _navigateToQuiz(context, QuizDifficulty.hard),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelButton(BuildContext context, {required String title, required IconData icon, required Gradient gradient, required Color borderColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 32, color: Colors.white),
                const SizedBox(width: 16),
                Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 28),
          ],
        ),
      ),
    );
  }
}
