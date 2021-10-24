import 'package:bloc/bloc.dart';
import 'package:quiz_cubit/business_logic/state/theme_state.dart';
import 'package:quiz_cubit/data/models/theme_model.dart';
import 'package:quiz_cubit/data/repository/question_repository.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final QuestionRepository _QuizRepository;

  ThemeCubit(this._QuizRepository) : super(const ThemeInitial());

  Future<ThemeModel?> getAllThematiques() async {
    try {
      emit(const ThemeLoading());
      final thematiques = await _QuizRepository.getAllThematiques();
      emit(ThemeLoaded(thematiques));
    } on MyNetworkException {
      emit(const ThemeError("Impossible de récupérer les données"));
    }
  }
}

class MyNetworkException implements Exception {}
