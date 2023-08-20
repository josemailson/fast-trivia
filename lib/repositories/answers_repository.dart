import 'dart:convert';
import 'package:fast_trivia/model/answers_model.dart';
import 'package:http/http.dart' as http;

abstract class AnswersRepository {
  Future<List<Answer>> getAnswers();
}

class AnswersRepositoryHttp implements AnswersRepository {
  final baseUrl = 'https://64e24048ab0037358818dfdd.mockapi.io/fastquiz';

  @override
  Future<List<Answer>> getAnswers() async {
    final response = await http.get(Uri.parse('$baseUrl/respostas'));
    
    if (response.statusCode == 200) {
      final List<dynamic> answersJson = json.decode(response.body);
      List<Answer> answers = [];

      if (answersJson.isNotEmpty) {
        for (var answerJson in answersJson) {
          Answer answer = Answer.fromJson(answerJson);
          answers.add(answer);
        }
      }

      return answers;
    } else {
      throw Exception('Failed to load answers');
    }
  }
}