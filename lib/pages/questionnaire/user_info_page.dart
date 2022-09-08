import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserInfoPage extends StatefulWidget {
  final String? id;

  const UserInfoPage({Key? key, this.id}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: double.infinity,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter your info'),
                const SizedBox(height: 50),
                TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Enter Username', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    context.replaceNamed(
                      'Test',
                      params: {'tab': 'questionnaire'},
                      queryParams: {'id': widget.id},
                    );
                    if (kIsWeb) {
                      Router.neglect(context, () {
                        context.goNamed(
                          'Test',
                          params: {'tab': 'questionnaire'},
                          queryParams: {'id': widget.id},
                        );
                      });
                    }
                  },
                  child: const Text('Start Test info'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
