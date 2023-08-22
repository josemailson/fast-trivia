import 'dart:convert';
import 'package:fast_trivia/model/answers_model.dart';
import 'package:http/http.dart' as http;

abstract class AnswersRepository {
  Future<List<Answer>> getAnswers();
  Future<bool> createAnswers(Answer answer);
  Future<bool> deleteAllAnswers();
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
  
  @override
  Future<bool> createAnswers(Answer answer) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/respostas'),
        body: json.encode(answer.toJson()),
        headers: {
          "content-type": "application/json",
          "accept": "application/json"
        },
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deleteAllAnswers() async {
    try {
      final List<Answer> answers = await getAnswers();

      for (var answer in answers) {
        final response = await http.delete(
          Uri.parse('$baseUrl/respostas/${answer.id}'),
        );

        if (response.statusCode != 200) {
          return false;
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}