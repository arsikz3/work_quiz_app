import 'package:flutter/material.dart';
import 'package:work_quiz_app/get/data_list.dart';
import 'package:work_quiz_app/get/model.dart';
import 'package:work_quiz_app/question_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: WelcomPage());
  }
}

class WelcomPage extends StatefulWidget {
  const WelcomPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WelcomPageState();
  }
}

class _WelcomPageState extends State<WelcomPage> {
  String dropdownvalue = categories.first;

  @override
  void initState() {
    super.initState();
  }

  void startQuiz(String dropdownvalue) async {
    List<Quest> quest;
    //quest = fetchQuests(dropdownvalue);
    quest = await fetchQuests(dropdownvalue);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => QuestionPage(
                curtheme: dropdownvalue,
                questions: quest,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz API'),
        backgroundColor: Color.fromARGB(255, 241, 111, 191),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text('Выберите категорию:'),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton(
                    value: dropdownvalue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: categories.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 241, 111, 191))),
                  onPressed: () {
                    // ignore: avoid_print
                    print(dropdownvalue);
                    startQuiz(dropdownvalue);
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Начать тест'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 241, 111, 191),
        onPressed: () async {
          List<Quest> quest;
          //quest = fetchQuests(dropdownvalue);
          quest = await fetchQuests(dropdownvalue);
        },
        child: const Icon(
          Icons.query_builder,
        ),
      ),
    );
  }
}
