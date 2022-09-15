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
  List<String> diff = difficults;
  ValueNotifier<int> selectetDiff = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  void startQuiz(String dropdownvalue) async {
    List<Quest> quest;
    //quest = fetchQuests(dropdownvalue);
    quest = await fetchQuests(dropdownvalue, diff[selectetDiff.value]);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => QuestionPage(
                curtheme: dropdownvalue,
                questions: quest,
              )),
    );
  }

  Color getColor(int ind) {
    Color col;
    if (ind == selectetDiff.value) {
      col = Color.fromARGB(255, 248, 27, 12);
    } else {
      col = Color.fromARGB(255, 241, 111, 191);
    }
    return col;
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
                  Text('Select Category:'),
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
              const SizedBox(height: 50, child: Divider()),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text('Select Difficulty:'),
              ),
              SizedBox(
                height: 80,
                child: ListView.builder(
                    itemCount: diff.length,
                    itemExtent: 100,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(5),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext, index) {
                      return ValueListenableBuilder(
                        valueListenable: selectetDiff,
                        builder: (context, value, child) {
                          return Card(
                            shadowColor: Colors.red,
                            color: getColor(index),
                            child: ListTile(
                              onTap: () {
                                selectetDiff.value = index;
                              },
                              subtitle: Text(diff[index]),
                            ),
                          );
                        },
                      );
                    }),
              ),
              const SizedBox(height: 50, child: Divider()),
              ElevatedButton.icon(
                  style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          const TextStyle(color: Colors.white)),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 241, 111, 191))),
                  onPressed: () {
                    // ignore: avoid_print

                    startQuiz(dropdownvalue);
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Test start'))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 241, 111, 191),
        onPressed: () async {
          List<Quest> quest;
          //quest = fetchQuests(dropdownvalue);
          quest = await fetchQuests(dropdownvalue, diff[selectetDiff.value]);
        },
        child: const Icon(
          Icons.query_builder,
        ),
      ),
    );
  }
}
