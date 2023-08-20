import 'package:fast_trivia/controller/questions_controller.dart';
import 'package:fast_trivia/repositories/questions_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = QuestionsController(QuestionsRepositoryHttp());
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
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                     Navigator.of(context).pushNamed('/question').then((_) => controller.getQuestions());
                  },
                  child: const Text('Novo Quetionário'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Questionário 1'),
                        const Text('Resultado'),
                        const Text('10/10'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/answers');
                          },
                          child: const Text('Ver Respostas'),
                        ),
                      ],
                    ),
                  )
                  ),
              ),
                          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Questionário 1'),
                        const Text('Resultado'),
                        const Text('10/10'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/answers');
                          },
                          child: const Text('Ver Respostas'),
                        ),
                      ],
                    ),
                  )
                  ),
              ),
                          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Questionário 1'),
                        const Text('Resultado'),
                        const Text('10/10'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/answers');
                          },
                          child: const Text('Ver Respostas'),
                        ),
                      ],
                    ),
                  )
                  ),
              ),
                          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Questionário 1'),
                        const Text('Resultado'),
                        const Text('10/10'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/answers');
                          },
                          child: const Text('Ver Respostas'),
                        ),
                      ],
                    ),
                  )
                  ),
              ),
                          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text('Questionário 1'),
                        const Text('Resultado'),
                        const Text('10/10'),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/answers');
                          },
                          child: const Text('Ver Respostas'),
                        ),
                      ],
                    ),
                  )
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
