import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/core/theme/app_colors.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/widgets/animated_starfield.dart';
import 'package:neo_guard/features/quiz/data/models/question.dart';
import 'package:neo_guard/features/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:neo_guard/features/quiz/presentation/cubit/quiz_state.dart';

class QuizScreen extends StatelessWidget {
  final List<Question> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(questions: questions)..startQuiz(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),

          title: const Text('Multiple Choice Quiz',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,

          elevation: 0,
        ),
        body: Container(
          decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
          child: Stack(
            children: [
              const Positioned.fill(child: AnimatedStarfield()),
              SafeArea(
                child: LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: BlocBuilder<QuizCubit, QuizState>(
                          builder: (context, state) {
                            if (state is QuizInitial) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (state is QuizLoaded) {
                              return _buildQuizBody(context, state);
                            } else if (state is QuizFinished) {
                              return _buildFinishedBody(context, state);
                            } else {
                              return const Center(child: Text('Something went wrong!'));
                            }
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizBody(BuildContext context, QuizLoaded state) {
    final isAnswered = state is QuizAnswered;
    final progress = state.currentQuestionNumber / state.totalQuestions;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildProgressBar(progress),
          const SizedBox(height: 24),
          Text(
            state.question.questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, height: 1.4),
          ),
          const Spacer(),
          ...List.generate(state.question.options.length, (index) {
            return _buildAnswerButton(context, index, state);
          }),
          const Spacer(),
          if (isAnswered) _buildExplanationAndNext(context, state),
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Progress', style: TextStyle(color: AppColors.purple200, fontWeight: FontWeight.bold)),
            Text('${(progress * 100).toInt()}%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.purple900.withValues(alpha:0.5),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.purple400),
            minHeight: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildAnswerButton(BuildContext context, int index, QuizLoaded state) {
    final isAnswered = state is QuizAnswered;
    Color borderColor = AppColors.blue400;
    Color? iconColor;
    IconData? icon;

    if (isAnswered) {
      final answeredState = state;
      if (index == answeredState.question.correctAnswerIndex) {
        borderColor = AppColors.green400;
        iconColor = AppColors.green400;
        icon = Icons.check_circle;
      } else if (index == answeredState.selectedAnswerIndex) {
        borderColor = AppColors.red400;
        iconColor = AppColors.red400;
        icon = Icons.cancel;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: isAnswered ? null : () => context.read<QuizCubit>().answerQuestion(index),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          decoration: BoxDecoration(
            color: borderColor.withValues(alpha:0.15),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  state.question.options[index],
                  style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationAndNext(BuildContext context, QuizAnswered state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.purple900.withValues(alpha:0.4),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.purple500.withValues(alpha:0.5)),
          ),
          child: Column(
            children: [
              Text(
                state.wasCorrect ? 'CORRECT!' : 'INCORRECT',
                style: TextStyle(
                  color: state.wasCorrect ? AppColors.green400 : AppColors.red400,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                state.question.explanation,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.purple200, fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.read<QuizCubit>().nextQuestion(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orange500,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('Next Question', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildFinishedBody(BuildContext context, QuizFinished state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            state.score > state.totalQuestions / 2 ? Icons.military_tech : Icons.sentiment_very_dissatisfied,
            color: AppColors.orange500, 
            size: 80,
          ),
          const SizedBox(height: 20),
          Text(
            'Quiz Complete!', 
            style: TextStyle(color: AppColors.orange500, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Your Score: ${state.score} / ${state.totalQuestions}',
            style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            icon: const Icon(Icons.home_filled),
            label: const Text('Back to Home'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.purple500,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ],
      ),
    );
  }
}
