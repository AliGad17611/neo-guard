import 'package:flutter/foundation.dart';
import 'package:neo_guard/features/quiz/data/models/question.dart';

@immutable
abstract class QuizState {
  const QuizState();
}

class QuizInitial extends QuizState {}

class QuizLoaded extends QuizState {
  final Question question;
  final int currentQuestionNumber;
  final int totalQuestions;

  const QuizLoaded({
    required this.question,
    required this.currentQuestionNumber,
    required this.totalQuestions,
  });
}

class QuizAnswered extends QuizLoaded {
  final bool wasCorrect;
  final int score;
  final int selectedAnswerIndex;

  const QuizAnswered({
    required super.question,
    required super.currentQuestionNumber,
    required super.totalQuestions,
    required this.wasCorrect,
    required this.score,
    required this.selectedAnswerIndex,
  });
}

class QuizFinished extends QuizState {
  final int score;
  final int totalQuestions;

  const QuizFinished({required this.score, required this.totalQuestions});
}
