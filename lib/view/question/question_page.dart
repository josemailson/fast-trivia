import 'package:fast_trivia/controller/answers_constroller.dart';
import 'package:fast_trivia/controller/questions_controller.dart';
import 'package:fast_trivia/model/answers_model.dart';
import 'package:fast_trivia/model/questions_model.dart';
import 'package:fast_trivia/repositories/Answers_repository.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';
import 'package:fast_trivia/view/question/question_page_state.dart';
import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  final questionsController = QuestionsController(QuestionsRepositoryHttp());
  final answersController = AnswersController(AnswersRepositoryHttp());
  int _currentQuestionIndex = 0;
  int _selectedOptionIndex = -1;
  List<String> _options = [];
  final List<Questao> _answeredQuestions = [];

  List<Question>? _questions;

  @override
  void initState() {
    super.initState();
    questionsController.notifier.addListener(() {
      final state = questionsController.state;
      if (state is QuestionPageSuccessState) {
        setState(() {
          _questions = state.questions;
          _loadQuestion(_currentQuestionIndex);
        });
      }
    });
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      await questionsController
          .getQuestions();
    } catch (e) {
      // Lidar com erro
    }
  }

  void _loadQuestion(int index) {
    final currentQuestion = _questions![index];
    _options = currentQuestion.alternativas
        .map((alternative) => alternative.titulo)
        .toList();
    _selectedOptionIndex = -1;
  }

  void _selectOption(int index) {
  setState(() {
    _selectedOptionIndex = index;
    final selectedQuestaoId = _questions![_currentQuestionIndex].id;
    final selectedResposta = _selectedOptionIndex + 1;
    _answeredQuestions.add(Questao(id: selectedQuestaoId, resposta: selectedResposta));
  });
}

  void _nextQuestion() {
    if (_selectedOptionIndex < 0) {
      _showAlertDialog(
          'Atenção', 'Você deve selecionar uma alternativa antes de avançar.');
    } else if (_currentQuestionIndex < _questions!.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _loadQuestion(_currentQuestionIndex);
      });
    } else {
      Navigator.of(context).pushNamed('/results');
    }
  }

  void _submitAnswers() async {
  if (_answeredQuestions.length == _questions!.length) {
    final answerDetails = AnswerDetails(id: 1, questoes: _answeredQuestions);
    final answer = Answer(id: '1', respostas: answerDetails);
    await answersController.createAnswers(answer);
  } else {
    _showAlertDialog('Atenção', 'Você deve responder todas as questões antes de enviar.');
  }
}


  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

Widget _buildButton(BuildContext context) {
  if (_currentQuestionIndex < _questions!.length - 1) {
    return ElevatedButton(
      onPressed: _nextQuestion,
      child: const Text('Próxima'),
    );
  } else {
    return ElevatedButton(
      onPressed: () {
        _submitAnswers();
        Navigator.of(context).pushNamedAndRemoveUntil('/results', (route) => false);
      },
      child: const Text('Enviar'),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    if (_questions == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final currentQuestion = _questions![_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Trivia'),
      ),
      body: ValueListenableBuilder(
        valueListenable: questionsController.notifier,
        builder: (context, state, _) {
          if (state is QuestionPageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuestionPageErrorState) {
            return Center(
              child: TextButton(
                child: const Text('Tentar Novamente'),
                onPressed: () async {
                  await questionsController.getQuestions();
                },
              ),
            );
          } else if (state is QuestionPageEmptyState) {
            return Center(
              child: TextButton(
                child: const Text('Sem questões, tente novamente mais tarde'),
                onPressed: () async {
                  await questionsController.getQuestions();
                },
              ),
            );
          } else if (state is QuestionPageSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Questão ${currentQuestion.id}/10',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    (currentQuestion.pergunta),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                        
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: _options
                        .asMap()
                        .map((index, option) => MapEntry(
                              index,
                              GestureDetector(
                                onTap: () => _selectOption(index),
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _selectedOptionIndex == index
                                          ? Colors.blue
                                          : Colors.grey,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Text(
                                      option,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ))
                        .values
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  _buildButton(context),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
