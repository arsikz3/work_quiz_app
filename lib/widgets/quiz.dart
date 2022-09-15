import 'package:flutter/foundation.dart';

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
  Map<String, bool> isSelectValues = {};
  Map<String, bool> RightValues = {
    'answer_a': true,
    'answer_b': false,
    'answer_c': false,
    'answer_d': false,
    'answer_e': false,
    'answer_f': false
  };

  void initDefaultAnswer() {
    for (var item in widget.questions[widget.questionIndex].answers.keys) {
      final elm = <String, bool>{item: false};
      isSelectValues.addEntries(elm.entries);
    }
  }

  @override
  void initState() {
    super.initState();
    initDefaultAnswer();
    print('Инит');
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> answersWithoutNull =
        widget.questions[widget.questionIndex].answers;
    answersWithoutNull.removeWhere((key, value) => value == null);

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
            SizedBox(
              height: 400,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: answersWithoutNull.length,
                  itemBuilder: (context, index) {
                    final answer = answersWithoutNull.values.elementAt(index);

                    String key = answersWithoutNull.keys.elementAt(index);

                    return CheckboxListTile(
                      selected: isSelectValues.entries
                          .where((element) => element.key == key)
                          .first
                          .value,
                      value: isSelectValues.entries
                          .where((element) => element.key == key)
                          .first
                          .value,
                      onChanged: (_value) {
                        setState(() {
                          final elm = <String, bool>{key: _value!};
                          isSelectValues.addEntries(elm.entries);
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
            print(isSelectValues.values.toString());
            print(RightValues.values.toString());
            //print(mapEquals(RightValues, isSelectValues));
            print(isSelectValues.values.toString() ==
                RightValues.values.toString());
            initDefaultAnswer();
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
