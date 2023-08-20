import 'package:fast_trivia/model/answers_model.dart';

abstract class AnswerPageState {}

class AnswerPageInitialState implements AnswerPageState {}

class AnswerPageLoadingState implements AnswerPageState {}

class AnswerPageEmptyState implements AnswerPageState {}

class AnswerPageSuccessState implements AnswerPageState {
  final List<Answer> answers;

  AnswerPageSuccessState(this.answers);
}

class AnswerPageErrorState implements AnswerPageState {
  final String message;

  AnswerPageErrorState(this.message);
}