import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz List'),
      ),
      body: Column(
        children: [
          ...List.generate(
            10,
            (index) => ListTile(
              title: Text('Quiz No: $index'),
              onTap: () => context.goNamed(
                'QuizResult',
                queryParams: {
                  'currentQuiz': index.toString(),
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
