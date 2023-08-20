import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fast Trivia'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Lógica para ação do botão "Nova Pergunta"
          },
          child: Text('Nova Pergunta'),
        ),
      ),
    );
  }
}
