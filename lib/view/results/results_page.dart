import 'package:fast_trivia/controller/answers_constroller.dart';
import 'package:fast_trivia/repositories/Answers_repository.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';
import 'package:fast_trivia/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:fast_trivia/controller/questions_controller.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key? key}) : super(key: key);

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  final questionsController = QuestionsController(QuestionsRepositoryHttp());
  final answersController = AnswersController(AnswersRepositoryHttp());

  int _correctAnswers = 0;
  int _totalQuestions = 0;

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    try {
      final questions = await questionsController.getQuestions();
      final answers = await answersController.getAnswers();

      if (answers.isNotEmpty) {
        final lastAnswer = answers.last;

        _totalQuestions = questions.length;

        for (final questao in lastAnswer.respostas.questoes) {
          final questionWithGabarito = questions.firstWhere((q) => q.id == questao.id);
          if (questao.resposta == questionWithGabarito.gabarito) {
            _correctAnswers++;
          }
        }
      }

      setState(() {});
    } catch (e) {
      // Lidar com o erro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Trivia'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Resultado',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                '$_correctAnswers/$_totalQuestions',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/question', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Novo questionário', style: AppTextStyles.button),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Página inicial', style: AppTextStyles.button),
              ),
            ),
          ],
        ),
      ),
    );
  }
}