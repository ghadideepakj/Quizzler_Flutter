import 'package:flutter/material.dart';
// import 'questions.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain1 = QuizBrain();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool usersAnswer) {
    bool correctAnswer = quizBrain1.getQuestionAnswer();
    //Don't use Print statement in production code
    // if (correctAnswer == true) {
    //   print("User got is right!");
    // } else {
    //   print('User got it wrong!');
    // }
    if (quizBrain1.getLastQuestionNumber()) {
      Alert(
              context: context,
              title: "Alert",
              desc: "This was the last question.")
          .show();
    } else {
      if (correctAnswer == usersAnswer) {
        scoreKeeper.add(const Icon(
          Icons.check_circle,
          color: Colors.green,
        ));
      } else {
        scoreKeeper.add(const Icon(
          Icons.cancel,
          color: Colors.red,
        ));
      }
      setState(() {
        quizBrain1.nextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain1.getQuestionText(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.greenAccent),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
                // if (quizBrain1.getLastQuestionNumber()) {
                //   Alert(
                //           context: context,
                //           title: "RFLUTTER",
                //           desc: "This was the last question.")
                //       .show();
                // }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.redAccent, primary: Colors.redAccent),
              child: const Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
