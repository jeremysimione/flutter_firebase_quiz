import 'package:bloc/bloc.dart';

class QuizScoreCubit extends Cubit<int> {
  QuizScoreCubit() : super(0);

  void increment() => emit(state + 1);
  void decrement() => emit(state - 1);
  void reset() => emit(0);
}
