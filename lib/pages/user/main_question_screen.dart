import 'package:flutter/material.dart';

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
  McqOptions? selectedAns = McqOptions.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
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
                    'Question ${widget.currentQuestion} of 10',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.bookmark,
                    size: 40,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries ?",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RadioListTile(
                    title: const Text(
                      'A.  Option A',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.A,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'B.  Option B',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.B,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'C.  Option C',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.C,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'D.  Option D',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.D,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  Visibility(
                    visible: selectedAns != McqOptions.none,
                    child: ListTile(
                      title: const Text(
                        'Clear Selection',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedAns = McqOptions.none;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
