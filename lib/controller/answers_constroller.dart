import 'package:fast_trivia/model/answers_model.dart';
import 'package:fast_trivia/repositories/Answers_repository.dart';
import 'package:fast_trivia/view/answers/anwers_page_state.dart';
import 'package:flutter/material.dart';

class AnswersController {
  final AnswersRepository repository;

  AnswersController(this.repository);

  final notifier = ValueNotifier<AnswerPageState>(AnswerPageInitialState());
  AnswerPageState get state => notifier.value;

  Future<List<Answer>> getAnswers() async {
    notifier.value = AnswerPageLoadingState();
    try {
      final result = await repository.getAnswers();
      if (result.isEmpty) {
        notifier.value = AnswerPageEmptyState();
      } else {
        notifier.value = AnswerPageSuccessState(result);
      }
      return result;
    } catch (e) {
      notifier.value = AnswerPageErrorState(e.toString());
      rethrow;
    }
  }

  Future<void> createAnswers(Answer answer) async {
    try {
      final result = await repository.createAnswers(answer);
      if (result) {
        // Successfully created
        print("Answer created successfully!");
      } else {
        // Failed to create
        print("Failed to create answer.");
      }
    } catch (e) {
      print("Error creating answer: $e");
    }
  }

  Future<void> deleteAllAnswers() async {
    try {
      final result = await repository.deleteAllAnswers();
      if (result) {
        // Successfully deleted
        print("All answers deleted successfully!");
      } else {
        // Failed to delete
        print("Failed to delete all answers.");
      }
    } catch (e) {
      print("Error deleting all answers: $e");
    }
  }
}