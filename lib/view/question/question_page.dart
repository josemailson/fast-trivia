import 'package:flutter/material.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int _selectedOptionIndex = -1; // Index of the selected answer, -1 means no answer selected
  final List<String> _options = [
    'Option A',
    'Option B',
    'Option C',
    'Option D',
  ];

  void _selectOption(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
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
          children: [
            const Text(
              'Question: What is the capital of France?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                              margin: const EdgeInsets.symmetric(vertical: 8),
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
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/results');
              },
              child: const Text('Responder'),
            ),
          ],
        ),
      ),
    );
  }
}