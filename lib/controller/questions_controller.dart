import 'package:fast_trivia/model/questions_model.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';
import 'package:fast_trivia/view/question/question_page_state.dart';
import 'package:flutter/material.dart';

class QuestionsController {
  final QuestionsRepository repository;

  QuestionsController(this.repository);

  final notifier = ValueNotifier<QuestionPageState>(QuestionPageInitialState());
  QuestionPageState get state => notifier.value;

  Future<List<Question>> getQuestions() async {
    notifier.value = QuestionPageLoadingState();
    try {
      final result = await repository.getQuestions();
      if (result.isEmpty) {
        notifier.value = QuestionPageEmptyState();
      } else {
        notifier.value = QuestionPageSuccessState(result);
      }
      return result;
    } catch (e) {
      notifier.value = QuestionPageErrorState(e.toString());
      rethrow;
    }
  }
}
