import 'package:flutter/material.dart';

import 'package:work_quiz_app/get/model.dart';

import 'widgets/quiz.dart';

import 'result_page.dart';

class QuestionPage extends StatefulWidget {
  String curtheme;
  List<Quest> questions;
  QuestionPage({Key? key, required this.curtheme, required this.questions})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _QuestionPageState();
  }
}

class _QuestionPageState extends State<QuestionPage> {
  var _questionIndex = 0;
  var _totalScore = 0;

  var _questions;

  @override
  void initState() {
    super.initState();
    //printCategory();
    _questions = widget.questions;
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;
    // ignore: avoid_print
    print('Total $_totalScore!');

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);

    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quiz API: ${widget.curtheme}'),
          backgroundColor: Color.fromARGB(255, 241, 111, 191),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  questions: _questions,
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                )
              : Result(_totalScore, _resetQuiz),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
