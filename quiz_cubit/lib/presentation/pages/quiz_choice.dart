import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:quiz_cubit/business_logic/cubit/quiz_cubit.dart';
import 'package:quiz_cubit/business_logic/state/theme_state.dart';
import 'package:quiz_cubit/data/models/theme_model.dart';
import 'package:quiz_cubit/data/repository/question_repository.dart';

//Pas encore réellement implementé, nom du quizz en dur (je voulais renvoyer la liste de tout les quiz disponibles)
class QuizChoice extends StatelessWidget {
  final ThemeModel model;

  const QuizChoice({Key? key, required this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (var i = 0; i < model.thematiques.length; i++) {
      list.add(ElevatedButton(
          onPressed: () => getQuestionByThematiques(
              context, model.thematiques.elementAt(i).toString()),
          child: Text(model.thematiques.elementAt(i).toString())));
      list.add(const SizedBox(height: 10));
    }
    return Column(children: [for (var item in list) item]);
  }

  getQuestionByThematiques(BuildContext context, String quizName) {
    final quizCubit = context.read<QuizCubit>();
    quizCubit.getQuestionByThematique(quizName);
  }
}
