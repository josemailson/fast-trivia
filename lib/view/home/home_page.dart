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

  @override
  void initState() {
    super.initState();
    answersController.getAnswers();
  }

  Future<List<Map<String, dynamic>>> _loadQuizSummaries() async {
    try {
      final answers = await answersController.getAnswers();
      final questions = await questionsController.getQuestions();

      final quizSummaries = <Map<String, dynamic>>[];

      for (var i = 0; i < answers.length; i++) {
        final answer = answers[i];
        final quizId = i + 1;
        final totalQuestions = answer.respostas.questoes.length;

        // Calculate the correct answers
        int correctAnswers = 0;
        for (var questao in answer.respostas.questoes) {
          final questaoId = questao.id;
          final questionWithGabarito =
              questions.firstWhere((q) => q.id == questaoId);
          if (questao.resposta == questionWithGabarito.gabarito) {
            correctAnswers++;
          }
        }

        quizSummaries.add({
          'quizId': quizId,
          'correctAnswers': correctAnswers,
          'totalQuestions': totalQuestions,
        });
      }

      return quizSummaries;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Trivia'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/question');
              },
              child: const Text('Iniciar Novo Questionário'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                await answersController.deleteAllAnswers();
                setState(() {});
              },
              child: const Text('Apagar Histórico'),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _loadQuizSummaries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                      child: Text('Nenhum questionário respondido.'));
                }

                final quizSummaries = snapshot.data!;

                return ListView.builder(
                  itemCount: quizSummaries.length,
                  itemBuilder: (context, quizIndex) {
                    final quiz = quizSummaries[quizIndex];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text('Questionário ${quiz['quizId']}'),
                              Text(
                                  'Resultado: ${quiz['correctAnswers']}/${quiz['totalQuestions']}'),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/answers',
                                      arguments: quizIndex + 1);
                                },
                                child: const Text('Ver Respostas'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
