import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuestionnaireHome extends StatefulWidget {
  const QuestionnaireHome({Key? key}) : super(key: key);

  @override
  State<QuestionnaireHome> createState() => _QuestionnaireHomeState();
}

class _QuestionnaireHomeState extends State<QuestionnaireHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                UserSimplePreferences().setTestStatus(status: true);
                context.goNamed('start',
                    params: {'tab': 'questionnaire'},
                    queryParams: {'id': 'test123'});
              },
              child: const Text('Start'),
            )
          ],
        ),
      ),
    );
  }
}
