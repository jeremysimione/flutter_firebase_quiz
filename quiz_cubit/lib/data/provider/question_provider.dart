import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_cubit/data/models/theme_model.dart';
import '../models/quiz_model.dart';

class QuestionProvider {
  Future<QuizModel> getQuiz({required String quizName}) {
    return FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizName)
        .collection("questions")
        .withConverter<Question>(
          fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
          toFirestore: (question, _) => question.toJson(),
        )
        .get()
        .then((snapshot) {
      final List<Question> questions = [];
      for (var doc in snapshot.docs) {
        questions.add(doc.data() as Question);
      }

      final QuizModel quiz = QuizModel(questions: questions);
      return quiz;
    });
  }

  Future<QuizModel> getQuestionsByThematique({required String thematique}) {
    return FirebaseFirestore.instance
        .collection('quiz')
        .doc("Quizz1")
        .collection("questions")
        .where("thematique", isEqualTo: thematique)
        .withConverter<Question>(
          fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
          toFirestore: (question, _) => question.toJson(),
        )
        .get()
        .then((snapshot) {
      final List<Question> questions = [];
      for (var doc in snapshot.docs) {
        questions.add(doc.data() as Question);
      }
      final QuizModel quiz = QuizModel(questions: questions);
      return quiz;
    });
  }

  Future<ThemeModel> getAllThematiques() {
    return FirebaseFirestore.instance
        .collection('quiz')
        .doc("Quizz1")
        .collection("questions")
        .withConverter<Question>(
          fromFirestore: (snapshot, _) => Question.fromJson(snapshot.data()!),
          toFirestore: (question, _) => question.toJson(),
        )
        .get()
        .then((snapshot) {
      final List<String> thematiques = [];
      for (var doc in snapshot.docs) {
        if (!thematiques.contains(doc.data().thematique)) {
          thematiques.add(doc.data().thematique);
          // print("ici" + doc.data().thematique);
        }
      }
      final ThemeModel theme = ThemeModel(thematiques: thematiques);
      return theme;
    });
  }

  Future<void> addQuestion(Question q, String quizName) async {
    return FirebaseFirestore.instance
        .collection('quiz')
        .doc(quizName)
        .collection("questions")
        .doc()
        .set(q.toJson());
  }
}
