import 'package:fast_trivia/controller/answers_constroller.dart';
import 'package:fast_trivia/controller/questions_controller.dart';
import 'package:fast_trivia/model/answers_model.dart';
import 'package:fast_trivia/model/questions_model.dart';
import 'package:fast_trivia/repositories/Answers_repository.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';
import 'package:flutter/material.dart';

class AnswersPage extends StatefulWidget {
  final int quizId;

  const AnswersPage({required this.quizId, Key? key}) : super(key: key);

  @override
  State<AnswersPage> createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  final questionsController = QuestionsController(QuestionsRepositoryHttp());
  final answersController = AnswersController(AnswersRepositoryHttp());
  List<Question>? _questions;
  Answer? _quizAnswer;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await questionsController.getQuestions();

      final answers = await answersController.getAnswers();
      _quizAnswer = answers.firstWhere(
        (answer) => answer.id == widget.quizId.toString(),
        orElse: () => Answer(id: '0', respostas: AnswerDetails(id: 0, questoes: [])),
      );

      setState(() {
        _questions = questions;
      });
    } catch (e) {
      // Verificar erro
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
        child: _buildQuestionsList(),
      ),
    );
  }

  Widget _buildQuestionsList() {
    if (_questions == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: _questions!.length,
      itemBuilder: (context, questionIndex) {
        final question = _questions![questionIndex];
        final selectedAnswerId = _quizAnswer!.respostas.questoes[questionIndex].resposta;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${question.id}: ${question.pergunta}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: question.alternativas.map((alternative) {
                final isCorrect = alternative.id == question.gabarito;

                final isSelectedAnswerDifferent = selectedAnswerId != question.gabarito && selectedAnswerId == alternative.id;

                return Container(
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green : isSelectedAnswerDifferent ? Colors.red : Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    alternative.titulo,
                    style: TextStyle(
                      color: isCorrect || isSelectedAnswerDifferent ? Colors.white : Colors.black,
                      fontSize: 16,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}