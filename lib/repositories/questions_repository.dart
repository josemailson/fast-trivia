import 'dart:convert';
import 'package:fast_trivia/model/questions_model.dart';
import 'package:http/http.dart' as http;

abstract class QuestionsRepository {
  Future<List<Question>> getQuestions();
}

class QuestionsRepositoryHttp implements QuestionsRepository {
  final baseUrl = 'https://64e24048ab0037358818dfdd.mockapi.io/fastquiz';

  @override
  Future<List<Question>> getQuestions() async {
    final response = await http.get(Uri.parse('$baseUrl/questionario'));

    if (response.statusCode == 200) {
      final String responseBody =
          utf8.decode(response.bodyBytes); // Decodifica para UTF-8
      final List<dynamic> questionsJson = json.decode(responseBody);
      List<Question> questions = [];

      if (questionsJson.isNotEmpty) {
        for (var questionJson in questionsJson) {
          Question question = Question.fromJson(questionJson);
          questions.add(question);
        }
      }

      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
