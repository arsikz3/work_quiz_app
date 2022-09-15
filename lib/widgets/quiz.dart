import 'package:flutter/material.dart';
import 'package:work_quiz_app/get/model.dart';
//import './question.dart';

class Quiz extends StatefulWidget {
  //final List<Map<String, Object>> questions;
  final List<Quest> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //var _value = false;
  List<bool> _isSelect = [];

  void setDefisSelected() {
    _isSelect.clear();
    for (var item in widget.questions[widget.questionIndex].answers.values) {
      _isSelect.add(false);
    }
  }

  @override
  void initState() {
    super.initState();
    setDefisSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: Text(
            widget.questions[widget.questionIndex].question,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        Column(
          children: [
            /*
            Question(
              //questions[questionIndex]['questionText'].toString(),
              questionIndex.toString(),
            ),
            */

            /*
            ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
                .map((answer) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    answerQuestion(answer['score']);
                  },
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 241, 111, 191))),
                  child: Text(answer['text'].toString()),
                ),
              );
            }).toList()
            */

            SizedBox(
              height: 400,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      widget.questions[widget.questionIndex].answers.length,
                  itemBuilder: (context, index) {
                    final answer = widget
                        .questions[widget.questionIndex].answers.values
                        .elementAt(index);
                    String key = widget
                        .questions[widget.questionIndex].answers.keys
                        .elementAt(index);

                    return CheckboxListTile(
                      selected: _isSelect.elementAt(index),
                      value: _isSelect.elementAt(index),
                      onChanged: (_value) {
                        setState(() {
                          _isSelect[index] = _value!;

                          print(_isSelect.toString());
                        });
                      },
                      title: Text(
                        answer.toString(),
                        style: const TextStyle(fontSize: 14),
                      ),
                      subtitle: Text(key.toString()),
                    );
                  }),
            ),
          ],
        ),
        ElevatedButton.icon(
          icon: const Icon(Icons.navigate_next),
          onPressed: () {
            setDefisSelected();
            widget.answerQuestion(1);
          },
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white)),
              backgroundColor: MaterialStateProperty.all(
                  Color.fromARGB(255, 241, 111, 191))),
          label: const Text(
            'Next',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
