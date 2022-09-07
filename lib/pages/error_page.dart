import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error}) : super(key: key);

  final Exception? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error.toString(),
              style: const TextStyle(fontSize: 45),
            ),
            ElevatedButton(
              onPressed: () =>
                  context.goNamed('HomeScreen', params: {'tab': 'profile'}),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
