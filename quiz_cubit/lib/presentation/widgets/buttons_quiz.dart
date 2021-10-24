import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_cubit/business_logic/cubit/answer_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/score_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/next_cubit.dart';
import 'package:quiz_cubit/data/models/quiz_model.dart';

class QuizButtons extends StatelessWidget {
  const QuizButtons({
    Key? key,
    required this.model,
  }) : super(key: key);

  final QuizModel model;

  void checkIfFalse(BuildContext context, int index, int score, bool answer) {
    if (answer == false) {
      context.read<QuizScoreCubit>().increment();
      context.read<QuestionAnswerCubit>().correct();
    } else if (score > 0) {
      context.read<QuizScoreCubit>().decrement();
      context.read<QuestionAnswerCubit>().incorrect();
    } else {
      context.read<QuestionAnswerCubit>().incorrect();
    }
  }

  void checkIfTrue(BuildContext context, int index, int score, bool answer) {
    if (answer == true) {
      context.read<QuizScoreCubit>().increment();
      context.read<QuestionAnswerCubit>().correct();
    } else if (score > 0) {
      context.read<QuizScoreCubit>().decrement();
      context.read<QuestionAnswerCubit>().incorrect();
    } else {
      context.read<QuestionAnswerCubit>().incorrect();
    }
  }

  void reinitialize(BuildContext context) {
    context.read<NextQuestionCubit>().reset();
    context.read<QuestionAnswerCubit>().reset();
    context.read<QuizScoreCubit>().reset();
  }

  void next(BuildContext context, int index, int maxIndex) {
    if (index + 1 < maxIndex) {
      context.read<NextQuestionCubit>().next();
      context.read<QuestionAnswerCubit>().reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NextQuestionCubit, int>(builder: (_, index) {
      return BlocBuilder<QuizScoreCubit, int>(builder: (_, score) {
        return BlocBuilder<QuestionAnswerCubit, int>(builder: (_, answer) {
          return Container(
              width: 2000,
              height: 50,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: answer != 0
                          ? null
                          : () => checkIfTrue(context, index, score,
                              model.questions.elementAt(index).isCorrect),
                      child: const Text("Vrai")),
                  ElevatedButton(
                      onPressed: answer != 0
                          ? null
                          : () => checkIfFalse(context, index, score,
                              model.questions.elementAt(index).isCorrect),
                      child: const Text("Faux")),
                  ElevatedButton(
                      onPressed: answer == 0
                          ? null
                          : () => next(context, index, model.questions.length),
                      child: const Text("Suivant")),
                  ElevatedButton(
                      onPressed:
                          answer != 0 ? () => reinitialize(context) : null,
                      child: const Text("Réessayer")),
                ],
              ));
        });
      });
    });
  }
}
