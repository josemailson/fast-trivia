import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast Trivia'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
             Navigator.of(context).pushNamed('/question');
          },
          child: const Text('Novo Quetionário'),
        ),
      ),
    );
  }
}
