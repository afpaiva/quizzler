import 'dart:ffi';
import 'quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain questions = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
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
  int points = 0;
  List<Icon> scores = [];
  void checkAnswer(bool selectedAnswer) {
    if (questions.getQuestionNumber() == 0) {
      scores = [];
    }
    if (questions.getQuestionAnswer() == selectedAnswer) {
      questions.addScore();
      scores.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),
      );
    } else {
      scores.add(
        Icon(
          Icons.cancel,
          color: Colors.red,
        ),
      );
    }
    if (questions.getQuestionNumber() >=
        questions.getQuestionBankLenght() - 1) {
      points = questions.getScore();
      Alert(
        context: context,
        title: "GAME OVER",
        desc: "You get $points points!",
      ).show();
      questions.resetScore();
      scores = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(true);
                });
                questions.nextQuestion();
              },
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                setState(() {
                  checkAnswer(false);
                });
                questions.nextQuestion();
              },
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: 30.0,
            )
          ]..addAll(scores),
        ),
        SizedBox(
          height: 20.0,
        )
      ],
    );
  }
}
