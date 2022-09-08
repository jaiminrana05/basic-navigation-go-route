import 'dart:math';

class QuizData {
  QuizData({
    required this.name,
    required this.quizNo,
  });

  final String name;
  final int quizNo;
}

class Quiz {
  static final data = [
    QuizData(name: 'Aptitude Quiz', quizNo: 1),
    QuizData(name: 'DSA Quiz', quizNo: 2),
    QuizData(name: 'Programming Quiz', quizNo: 3)
  ];
}

class Repository {
  static final rnd = Random();

  Future<List<QuizData>> getFamilies() async {
    // simulate network delay
    await Future<void>.delayed(
      const Duration(seconds: 3),
    );

    // simulate error
    //if (rnd.nextBool()) throw Exception('error fetching families');

    // return async_data "fetched over the network"
    return Quiz.data;
  }
}
