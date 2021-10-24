import 'package:quiz_cubit/data/models/quiz_model.dart';
import 'package:quiz_cubit/data/models/theme_model.dart';
import 'package:quiz_cubit/data/provider/question_provider.dart';

class QuestionRepository {
  final QuestionProvider _dataProvider = QuestionProvider();

  Future<QuizModel> getQuiz({required String quizName}) async =>
      await _dataProvider.getQuiz(quizName: quizName);

  Future<void> addQuestion(Question q, String quizName) async =>
      await _dataProvider.addQuestion(q, quizName);

  Future<QuizModel> getQuestionByThematique(String thematique) async =>
      await _dataProvider.getQuestionsByThematique(thematique: thematique);

  Future<ThemeModel> getAllThematiques() async =>
      await _dataProvider.getAllThematiques();
}
