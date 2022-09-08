import 'package:basic_navigation_go_route/async_data/quiz_data.dart';
import 'package:flutter/material.dart';

class QuizList extends StatefulWidget {
  QuizList({Key? key}) : super(key: key);

  final repo = Repository();

  @override
  QuizListState createState() => QuizListState();
}

class QuizListState extends State<QuizList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.repo.getFamilies(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading...'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Error'),
            ),
            body: const Center(
              child: Text(
                'Something Went Wrong!',
              ),
            ),
          );
        }

        final List<QuizData> quiz = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Quiz Data'),
          ),
          body: ListView.builder(
              itemCount: quiz.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(quiz[index].name),
                  leading: Text(quiz[index].quizNo.toString()),
                );
              }),
        );
      },
    );
  }
}
