import 'package:bloc/bloc.dart';

class NextQuestionCubit extends Cubit<int> {
  NextQuestionCubit() : super(0);

  void next() => emit(state + 1);
  void reset() => emit(0);
}
