import 'package:flutter/material.dart';
import 'package:work_quiz_app/get/model.dart';

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
  Map<String, String> isSelectValues = {};

  void initDefaultAnswer() {
    for (var item in widget.questions[widget.questionIndex].answers.keys) {
      final elm = <String, String>{item: 'false'};
      isSelectValues.addEntries(elm.entries);
    }
  }

  @override
  void initState() {
    super.initState();
    initDefaultAnswer();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> answersWithoutNull =
        widget.questions[widget.questionIndex].answers;
    answersWithoutNull.removeWhere((key, value) => value == null);

    Map<String, dynamic> correctAnswers =
        widget.questions[widget.questionIndex].correctAnswers;

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
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(5),
          child: Text(
            'description' + widget.questions[widget.questionIndex].description,
            style: const TextStyle(fontSize: 12),
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
                    String _isChecked = isSelectValues.entries
                        .where((element) => element.key == key)
                        .first
                        .value;

                    return CheckboxListTile(
                      selected: _isChecked == 'false' ? false : true,
                      value: _isChecked == 'false' ? false : true,
                      onChanged: (_value) {
                        setState(() {
                          final elm = <String, String>{key: _value!.toString()};
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
            bool _answerisCorrect = isSelectValues.values.toString() ==
                correctAnswers.values.toString();

            widget.answerQuestion(_answerisCorrect ? 1 : 0);
            initDefaultAnswer();
          },
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  const TextStyle(color: Colors.white)),
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 241, 111, 191))),
          label: const Text(
            'Next',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
