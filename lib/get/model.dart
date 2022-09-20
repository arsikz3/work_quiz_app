import 'dart:convert';
import 'package:http/http.dart' as http;

class Quest {
  Quest(
      {required this.id,
      required this.question,
      required this.category,
      required this.difficulty,
      required this.description,
      required this.multipleCorrectAnswers,
      required this.answers,
      required this.correctAnswers});

  int id;
  String question;
  String category;
  String difficulty;
  String description;
  String multipleCorrectAnswers;
  Map<String, dynamic> answers;
  Map<String, dynamic> correctAnswers;

  factory Quest.fromJson(Map<String, dynamic> json) => Quest(
        id: json["id"],
        question: json["question"],
        category: json["category"],
        description: json["description"],
        multipleCorrectAnswers: json["category"],
        difficulty: json["difficulty"],
        answers: {},
        correctAnswers: {},
      );
}

Future<List<Quest>> fetchQuests(
    String category, String difficulty, String qty) async {
  final List<Quest> quests = [];
  //final url = Uri.parse('https://quizapi.io/api/v1/questions?apiKey=j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa&category=linux&limit=3');
  /*
  print(category + difficulty);
  final url = Uri.parse(
      'https://quizapi.io/api/v1/questions?apiKey=j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa&category=devops&limit=3');
  final response = await http.get(url);
  */

  final queryParameters = {
    'apiKey': 'j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa'
  };

  queryParameters.addEntries({'category': category}.entries);
  if (difficulty != 'Any') {
    queryParameters.addEntries({'difficulty': difficulty}.entries);
  }
  queryParameters.addEntries({'limit': qty}.entries);

  final url = Uri.https('quizapi.io', '/api/v1/questions', queryParameters);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    List res = json.decode(response.body);

    for (var element in res) {
      Map<String, dynamic> _answers = {};
      Map<String, dynamic> _correctAnswers = {};

      _answers.addAll(element['answers']);
      _correctAnswers.addAll(element['correct_answers']);
      quests.add(Quest(
          id: element['id'],
          question: element['question'],
          category: element['category'],
          description: element['description'] ?? '',
          difficulty: element['multiple_correct_answers'],
          multipleCorrectAnswers: element['difficulty'],
          answers: _answers,
          correctAnswers: _correctAnswers));
    }

    return quests;
  } else {
    return [];

    //throw Exception('Failed to load data Error: ${response.statusCode}');
  }
}
