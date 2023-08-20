import 'package:fast_trivia/controller/answers_constroller.dart';
import 'package:fast_trivia/controller/questions_controller.dart';
import 'package:fast_trivia/repositories/Answers_repository.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final answersController = AnswersController(AnswersRepositoryHttp());
  final questionsController = QuestionsController(QuestionsRepositoryHttp());

  List<Map<String, dynamic>> _quizSummaries = []; // Store quiz summaries here

  @override
  void initState() {
    super.initState();
    _loadQuizSummaries();
  }

  Future<void> _loadQuizSummaries() async {
    try {
      // Fetch quiz summaries using answersController and questionsController
      final answers = await answersController.getAnswers();
      final questions = await questionsController.getQuestions();

      // Assuming you have logic to calculate quiz results based on answers and questions
      // You can modify this part based on your actual data structure
      for (var i = 0; i < questions.length; i++) {
        final quizId = i + 1;
        final totalQuestions = questions[i].alternativas.length;
        final correctAnswers = answers.where((answer) =>
            answer.questionId == questions[i].id &&
            answer.isCorrect == true).length;

        _quizSummaries.add({
          'quizId': quizId,
          'correctAnswers': correctAnswers,
          'totalQuestions': totalQuestions,
        });
      }
    } catch (e) {
      // Handle the error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Trivia'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _quizSummaries.map((quizSummary) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('Questionário ${quizSummary['quizId']}'),
                        Text('Resultado: ${quizSummary['correctAnswers']}/${quizSummary['totalQuestions']}'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/answers');
                          },
                          child: const Text('Ver Respostas'),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}