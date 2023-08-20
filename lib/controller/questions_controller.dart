import 'package:fast_trivia/model/questions_model.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';

class QuestionsController {
  final QuestionsRepository repository;

  QuestionsController(this.repository);

  Future<List<Question>> getQuestions() async {
    final result = await repository.getQuestions();
    return result;
  }
}