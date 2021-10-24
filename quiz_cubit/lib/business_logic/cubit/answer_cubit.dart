import 'package:bloc/bloc.dart';

class QuestionAnswerCubit extends Cubit<int> {
  QuestionAnswerCubit() : super(0);

  void correct() => emit(1);
  void incorrect() => emit(2);
  void reset() => emit(0);
}
