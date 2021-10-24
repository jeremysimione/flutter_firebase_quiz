import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_cubit/presentation/pages/add_question_form.dart';

class ButtonToForm extends StatelessWidget {
  const ButtonToForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddQuestionFormPage(),
              )),
          child: const Icon(
            Icons.add,
            size: 26.0,
          ),
        ));
  }
}
