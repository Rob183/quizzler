// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'questionBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
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

  Icon check = Icon(Icons.check, color: Colors.green);
  Icon close = Icon(Icons.close, color: Colors.red);

  QuestionBrain questionBrain = QuestionBrain();

  void checkAnswer(bool pickedAnswer) {
    setState(() {
      if (pickedAnswer == questionBrain.getAnswer()) {
        scoreKeeper.add(check);
      } else {
        scoreKeeper.add(close);
      }
      if (questionBrain.isFinished() == true) {
        Alert(
          context: context,
          title: "FLUTTER",
          desc: "Flutter is awesome.",
        ).show();
        scoreKeeper.clear();
        questionBrain.setFinished();
      } else {
        questionBrain.incQuestionNum();
      }
    });
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
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBrain.getQuestion(),
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
                backgroundColor: Colors.green,
              ),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
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
