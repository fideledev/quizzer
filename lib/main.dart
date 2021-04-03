import 'package:flutter/material.dart';
import 'package:quizzer/quiz_brain.dart';

void main() {
  runApp(MaterialApp(
    home: App(),
  ));
}

QuizBrain quizBrain = QuizBrain();

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SafeArea(
        child: QuizApp(),
      ),
    );
  }
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Expanded> scoreHolder = [];

  void checkAnswer(bool answer) {
    bool result = quizBrain.getQuestionAnswer();
    setState(() {
      if (quizBrain.isDone()) {
        quizBrain.clear();
        scoreHolder.clear();
        return false;
      }
      if (result == answer) {
        scoreHolder.add(Expanded(
          child: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ));
      } else {
        scoreHolder.add(Expanded(
          child: Icon(
            Icons.close,
            color: Colors.red,
          ),
        ));
      }
      quizBrain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              flex: 8,
              child: Container(
                child: Center(
                  child: Text(
                    '${quizBrain.getQuestionText()}',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
          Expanded(
            child: Container(
              child: FlatButton(
                onPressed: () {
                  checkAnswer(true);
                },
                color: Colors.green,
                child: Text(
                  'True',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              child: FlatButton(
                onPressed: () {
                  checkAnswer(false);
                },
                color: Colors.red,
                child: Text(
                  'False',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Row(
            children: scoreHolder,
          ),
        ],
      ),
    );
  }
}
