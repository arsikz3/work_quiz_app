import 'package:flutter/material.dart';
import 'package:work_quiz_app/welcome_page.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;
  const Result(this.resultScore, this.resetHandler, {Key? key})
      : super(key: key);

  String get resultPhrase {
    String resultText;

    if (resultScore >= 41) {
      resultText = 'You are awesome!';

      print(resultScore);
    } else if (resultScore >= 31) {
      resultText = 'Pretty likeable!';
      print(resultScore);
    } else if (resultScore >= 21) {
      resultText = 'You need to work more!';
    } else if (resultScore >= 1) {
      resultText = 'You need to work hard!';
    } else {
      resultText = 'This is a poor score!';
      print(resultScore);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Result!'),
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            'Score ' '$resultScore',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.restart_alt),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (BuildContext context) => MyApp()),
              );
              resetHandler();
            },
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.white)),
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 241, 111, 191))),
            label: const Text(
              'Restart Quiz',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
