import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_cubit/business_logic/cubit/answer_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/quiz_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/score_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/switch_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/theme_cubit.dart';
import 'package:quiz_cubit/business_logic/cubit/next_cubit.dart';
import 'package:quiz_cubit/business_logic/state/switch_state.dart';
import 'package:quiz_cubit/business_logic/state/theme_state.dart';
import 'package:quiz_cubit/data/repository/question_repository.dart';
import 'package:quiz_cubit/presentation/widgets/build_col_with_data.dart';
import 'package:quiz_cubit/presentation/widgets/button_to_form.dart';
import 'package:quiz_cubit/business_logic/state/quiz_state.dart';
import 'package:quiz_cubit/presentation/pages/quiz_choice.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NextQuestionCubit>(
          create: (BuildContext context) => NextQuestionCubit(),
        ),
        BlocProvider<QuizScoreCubit>(
          create: (BuildContext context) => QuizScoreCubit(),
        ),
        BlocProvider<QuestionAnswerCubit>(
          create: (BuildContext context) => QuestionAnswerCubit(),
        ),
        BlocProvider<QuizCubit>(
          create: (BuildContext context) => QuizCubit(QuestionRepository()),
        ),
        BlocProvider<SwitchCubit>(
            create: (BuildContext context) => SwitchCubit()),
        BlocProvider<ThemeCubit>(
            create: (BuildContext context) => ThemeCubit(QuestionRepository())),
      ],
      child: BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.theme,
            home: const MyQuizPage(title: 'Questions/Réponses'),
          );
        },
      ),
    );
  }
}

class MyQuizPage extends StatefulWidget {
  const MyQuizPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyQuizPage> createState() => _MyQuizPageState();
}

class _MyQuizPageState extends State<MyQuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('quiz'),
        actions: <Widget>[
          ButtonToForm(),
          BlocBuilder<SwitchCubit, SwitchState>(
            builder: (context, state) {
              return Switch(
                value: state.isDarkThemeOn,
                onChanged: (newValue) {
                  context.read<SwitchCubit>().toggleSwitch(newValue);
                },
              );
            },
          ),
        ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: BlocConsumer<QuizCubit, QuizState>(
            listener: (context, state) {
              if (state is QuizError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is QuizInitial) {
                return buildInitialInput();
              } else if (state is QuizLoading) {
                return buildLoading();
              } else if (state is QuizLoaded) {
                return BuildColumnWithData(model: state.Quiz);
              } else if (state is QuizModified) {
                print("laaa");
                return BuildColumnWithData(model: state.Quiz);
              } else {
                return buildInitialInput();
              }
            },
          )),
    );
  }

  //Pas encore vraiment implémenté (je voulais get les quiz et les afficher pour que l'utilisateur puisse choisir)
  //Pour le moment nom quiz en dur
  Widget buildInitialInput() {
    final themeCubit = context.read<ThemeCubit>();
    themeCubit.getAllThematiques();
    return BlocConsumer<ThemeCubit, ThemeState>(listener: (context, state) {
      if (state is ThemeError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
          ),
        );
      }
    }, builder: (context, state) {
      if (state is ThemeLoaded) {
        return Center(child: QuizChoice(model: state.thematiques));
      } else
        return const Center();
    });
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
