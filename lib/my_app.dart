import 'package:fast_trivia/view/answers/answers_page.dart';
import 'package:fast_trivia/view/home/home_page.dart';
import 'package:fast_trivia/view/question/question_page.dart';
import 'package:fast_trivia/view/results/results_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Trivia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
       routes: {
        '/home': (_) => const QuestionPage(),
        '/signin': (_) => const ResultsPage(),
        '/signup': (_) => const AnswersPage(),
      },
    );
  }
}