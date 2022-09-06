import 'package:flutter/material.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final int quiz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Quiz Result page'),
      ),
      body: Center(
        child: Text(
          'Result of Quiz : $quiz',
          style: const TextStyle(
            color: Colors.red,
            fontSize: 54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
