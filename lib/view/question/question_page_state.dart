import 'package:fast_trivia/model/questions_model.dart';

abstract class QuestionPageState {}

class QuestionPageInitialState implements QuestionPageState {}

class QuestionPageLoadingState implements QuestionPageState {}

class QuestionPageEmptyState implements QuestionPageState {}

class QuestionPageSuccessState implements QuestionPageState {
  final List<Question> questions;

  QuestionPageSuccessState(this.questions);
}

class QuestionPageErrorState implements QuestionPageState {
  final String message;

  QuestionPageErrorState(this.message);
}