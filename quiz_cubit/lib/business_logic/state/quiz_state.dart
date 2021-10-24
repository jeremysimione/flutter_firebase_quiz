import 'package:flutter/cupertino.dart';
import 'package:quiz_cubit/data/models/quiz_model.dart';

@immutable
abstract class QuizState {
  const QuizState();
}

class QuizInitial extends QuizState {
  const QuizInitial();
}

class QuizLoading extends QuizState {
  const QuizLoading();
}

class QuizLoaded extends QuizState {
  final QuizModel Quiz;
  const QuizLoaded(this.Quiz);
}

class QuizError extends QuizState {
  final String message;
  const QuizError(this.message);
}

class QuizModified extends QuizState {
  final QuizModel Quiz;
  const QuizModified(this.Quiz);
}
