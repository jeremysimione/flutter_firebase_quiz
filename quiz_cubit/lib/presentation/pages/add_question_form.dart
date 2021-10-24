// Define a custom Form widget.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_cubit/presentation/pages/quiz_page.dart';
import 'package:quiz_cubit/data/provider/question_provider.dart';
import '../../data/models/quiz_model.dart';

class AddQuestionFormPage extends StatelessWidget {
  const AddQuestionFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nouvelle question"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: const AddQuestionForm()));
  }
}

class AddQuestionForm extends StatefulWidget {
  const AddQuestionForm({Key? key}) : super(key: key);

  @override
  AddQuestionFormState createState() {
    return AddQuestionFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class AddQuestionFormState extends State<AddQuestionForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final myController = TextEditingController();
  final mySecondController = TextEditingController();
  final myThirdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool answer = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Theme input
          TextFormField(
            controller: myController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrez la question',
              labelText: 'Question',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La question est vide.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),

          Row(
            children: [
              const Text("Réponse "),
              const Text("false"),
              Switch(
                value: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value;
                    print(answer);
                  });
                },
              ),
              const Text("true"),
            ],
          ),
          TextFormField(
            key: UniqueKey(),
            controller: mySecondController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrez un lien',
              labelText: "Lien vers l'image de votre question",
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Le lien est vide';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: myThirdController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Entrez la thematique liée à votre question',
              labelText: 'Thematique',
            ),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'La question est vide.';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                final QuestionProvider provider = QuestionProvider();
                provider.addQuestion(
                    Question(
                        questionText: myController.text,
                        isCorrect: answer,
                        imageUrl: mySecondController.text,
                        thematique: myThirdController.text),
                    "Quizz1");

                // on retourne à la page d'accueil
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Ajout de la question')),
                );
              }
            },
            child: const Text('Créer la question'),
          ),
        ],
      ),
    );
  }
}
