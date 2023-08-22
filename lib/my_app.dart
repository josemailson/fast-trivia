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
     theme: ThemeData.dark(),
      home: const HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/answers') {
          final int? quizId = settings.arguments as int?;
          return MaterialPageRoute(
            builder: (_) => AnswersPage(quizId: quizId ?? 0),
          );
        } else if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (_) => const HomePage(),
          );
        } else if (settings.name == '/question') {
          return MaterialPageRoute(
            builder: (_) => const QuestionPage(),
          );
        } else if (settings.name == '/results') {
          return MaterialPageRoute(
            builder: (_) => const ResultsPage(),
          );
        }
        return null;
      },
    );
  }
}