class QuizModel {
  late List<Question> questions = [];

  QuizModel({required this.questions});
}

class Question {
  late String questionText;
  late bool isCorrect;
  late String imageUrl;
  late String thematique;
  Question(
      {required this.questionText,
      required this.isCorrect,
      required this.imageUrl,
      required this.thematique});
  Question.fromJson(Map<String, dynamic> json) {
    questionText = json['questionText'];
    isCorrect = json['isCorrect'];
    imageUrl = json['imageUrl'];
    thematique = json['thematique'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["questionText"] = questionText;
    data["isCorrect"] = isCorrect;
    data["imageUrl"] = imageUrl;
    data['thematique'] = thematique;
    return data;
  }
}
