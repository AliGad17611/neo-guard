import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/features/quiz/data/models/question.dart';
import 'package:neo_guard/features/quiz/presentation/cubit/quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final List<Question> _questions;
  int _currentQuestionIndex = 0;
  int _score = 0;

  QuizCubit({required List<Question> questions}) : _questions = questions, super(QuizInitial());

  void startQuiz() {
    if (_questions.isNotEmpty) {
      _currentQuestionIndex = 0;
      _score = 0;
      emit(QuizLoaded(
        question: _questions[_currentQuestionIndex],
        currentQuestionNumber: _currentQuestionIndex + 1,
        totalQuestions: _questions.length,
      ));
    }
  }

  void answerQuestion(int selectedAnswerIndex) {
    final currentQuestion = _questions[_currentQuestionIndex];
    final bool wasCorrect = currentQuestion.correctAnswerIndex == selectedAnswerIndex;

    if (wasCorrect) {
      _score++;
    }

    emit(QuizAnswered(
      question: currentQuestion,
      currentQuestionNumber: _currentQuestionIndex + 1,
      totalQuestions: _questions.length,
      selectedAnswerIndex: selectedAnswerIndex,
      wasCorrect: wasCorrect,
      score: _score,
    ));
  }

  void nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      emit(QuizLoaded(
        question: _questions[_currentQuestionIndex],
        currentQuestionNumber: _currentQuestionIndex + 1,
        totalQuestions: _questions.length,
      ));
    } else {
      emit(QuizFinished(score: _score, totalQuestions: _questions.length));
    }
  }
}
