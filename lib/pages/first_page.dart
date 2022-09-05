import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.pop(),
          child: const Text('Go back to Home Page'),
        ),
      ),
    );
  }
}
