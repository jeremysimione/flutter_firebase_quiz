import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_cubit/business_logic/state/theme_state.dart';
import 'package:quiz_cubit/data/models/quiz_model.dart';
import 'package:quiz_cubit/data/provider/question_provider.dart';
import 'package:quiz_cubit/business_logic/state/quiz_state.dart';
import 'package:quiz_cubit/data/repository/question_repository.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuestionRepository _QuizRepository;

  QuizCubit(this._QuizRepository) : super(const QuizInitial());

  Future<QuizModel?> getQuiz(String quizName) async {
    try {
      emit(const QuizLoading());
      final Quiz = await _QuizRepository.getQuiz(quizName: quizName);
      emit(QuizLoaded(Quiz));
    } on MyNetworkException {
      emit(const QuizError("Impossible de récupérer les données"));
    }
  }

  Future<void> addQuestion(String questionText, bool isCorrect, String imageUrl,
      String thematique, String quizName) async {
    try {
      await _QuizRepository.addQuestion(
          Question(
              questionText: questionText,
              isCorrect: isCorrect,
              imageUrl: imageUrl,
              thematique: thematique),
          quizName);
      final Quiz = await _QuizRepository.getQuiz(quizName: quizName);
      emit(QuizModified(Quiz));
    } on MyNetworkException {}
  }

  Future<QuizModel?> getQuestionByThematique(String thematique) async {
    try {
      emit(const QuizLoading());
      final Quiz = await _QuizRepository.getQuestionByThematique(thematique);
      emit(QuizLoaded(Quiz));
    } on MyNetworkException {
      emit(const QuizError("Impossible de récupérer les données"));
    }
  }
}

class MyNetworkException implements Exception {}
