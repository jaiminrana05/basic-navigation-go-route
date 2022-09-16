import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'question_store.dart';

class MainQuestionScreen extends StatefulWidget {
  const MainQuestionScreen({
    Key? key,
    required this.currentQuestion,
  }) : super(key: key);

  final int currentQuestion;

  @override
  State<MainQuestionScreen> createState() => _MainQuestionScreenState();
}

enum McqOptions { A, B, C, D, none }

class _MainQuestionScreenState extends State<MainQuestionScreen> {
  late QuestionStore store = Provider.of<QuestionStore>(context);

  @override
  Widget build(BuildContext context) {
    final question = store.mcqQuestions[widget.currentQuestion];
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Question ${widget.currentQuestion + 1} of ${store.mcqQuestions.length}',
                  style: const TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.bookmark,
                  size: 40,
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white54,
            child: Observer(builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    question.expandedValue,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  McqOptionTile.a(
                    option: question.optionA,
                    optionValue: McqOptions.A,
                  ),
                  McqOptionTile.b(
                    option: question.optionB,
                    optionValue: McqOptions.B,
                  ),
                  McqOptionTile.c(
                    option: question.optionC,
                    optionValue: McqOptions.C,
                  ),
                  McqOptionTile.d(
                    option: question.optionD,
                    optionValue: McqOptions.D,
                  ),
                  Visibility(
                    visible: store.selectedAns != McqOptions.none,
                    child: ListTile(
                      title: const Text(
                        'Clear Selection',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        store.selectedAns = McqOptions.none;
                      },
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class McqOptionTile extends StatelessWidget {
  const McqOptionTile.a({
    Key? key,
    required this.option,
    required this.optionValue,
  })  : mcqOptions = 'A',
        super(key: key);

  const McqOptionTile.b({
    Key? key,
    required this.option,
    required this.optionValue,
  })  : mcqOptions = 'B',
        super(key: key);

  const McqOptionTile.c({
    Key? key,
    required this.option,
    required this.optionValue,
  })  : mcqOptions = 'C',
        super(key: key);

  const McqOptionTile.d({
    Key? key,
    required this.option,
    required this.optionValue,
  })  : mcqOptions = 'D',
        super(key: key);

  final String option;
  final String mcqOptions;
  final McqOptions optionValue;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<QuestionStore>(context);
    return RadioListTile(
      title: Row(
        children: [
          Text(
            '$mcqOptions).',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(width: 5),
          Text(
            option,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
      value: optionValue,
      groupValue: store.selectedAns,
      onChanged: store.selectedMcqAnswer,
    );
  }
}
