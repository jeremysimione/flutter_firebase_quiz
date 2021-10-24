import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_cubit/business_logic/cubit/answer_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/score_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/next_cubit.dart';
import 'package:quiz_cubit/data/models/quiz_model.dart';
import 'package:quiz_cubit/presentation/widgets/button_to_form.dart';

import 'buttons_quiz.dart';

class BuildColumnWithData extends StatelessWidget {
  const BuildColumnWithData({Key? key, required this.model}) : super(key: key);
  final QuizModel model;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<NextQuestionCubit, int>(builder: (_, index) {
        return BlocBuilder<QuizScoreCubit, int>(builder: (_, score) {
          return BlocBuilder<QuestionAnswerCubit, int>(builder: (_, answer) {
            return Column(children: <Widget>[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: 2000,
                height: 50,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Center(
                        child: Text(
                            'Question ${index + 1} / ${model.questions.length}'),
                      ),
                      Center(
                        child: Text('Score : $score'),
                      ),
                    ]),
              ),
              const SizedBox(height: 20),
              Container(
                width: 400,
                height: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)),
                child: Image(
                  image:
                      NetworkImage(model.questions.elementAt(index).imageUrl),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                width: 400,
                height: 100,
                decoration: BoxDecoration(
                    color: answer == 0
                        ? Colors.blue
                        : answer == 1
                            ? Colors.green
                            : Colors.red,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      answer == 0
                          ? Text(model.questions.elementAt(index).questionText)
                          : answer == 1
                              ? const Text("Vous avez trouvé la bonne réponse ")
                              : const Text("Mauvaise réponse"),
                    ]),
              ),
              const SizedBox(height: 20),
              QuizButtons(model: model),
            ]);
          });
        });
      }),
    );
  }
}
