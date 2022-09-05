import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionIntroScreen extends StatefulWidget {
  final String? id;

  const QuestionIntroScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<QuestionIntroScreen> createState() => _QuestionIntroScreenState();
}

class _QuestionIntroScreenState extends State<QuestionIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'Questionnaire will being once you press below button'),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  context.goNamed('User-Info',
                      params: {'tab': 'questionnaire'},
                      queryParams: {'id': widget.id});
                },
                child: const Text('Start Test'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
