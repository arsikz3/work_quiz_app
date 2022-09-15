import 'dart:convert';
import 'package:http/http.dart' as http;

class Quest {
  Quest(
      {required this.id,
      required this.question,
      required this.category,
      required this.difficulty,
      required this.answers});

  int id;
  String question;
  String category;
  String difficulty;
  Map<String, dynamic> answers;

  factory Quest.fromJson(Map<String, dynamic> json) => Quest(
        id: json["id"],
        question: json["question"],
        category: json["category"],
        difficulty: json["difficulty"],
        answers: {},
      );
}

Future<List<Quest>> fetchQuests(String category, String difficulty) async {
  final List<Quest> quests = [];
  //final url = Uri.parse('https://quizapi.io/api/v1/questions?apiKey=j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa&category=linux&limit=3');
  print(category + difficulty);
  final url = Uri.parse(
      'https://quizapi.io/api/v1/questions?apiKey=j24WhINsXuMG7PszLmbkLHqRiXRoFnjRZrHxkwDa&category=devops&limit=3');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List res = json.decode(response.body);

    for (var element in res) {
      Map<String, dynamic> answers = {};
      answers.addAll(element['answers']);

      quests.add(Quest(
          id: element['id'],
          question: element['question'],
          category: element['category'],
          difficulty: element['difficulty'],
          answers: answers));
    }

    return quests;
  } else {
    throw Exception('Failed to load Category: $category');
  }
}
