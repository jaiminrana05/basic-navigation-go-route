import 'package:basic_navigation_go_route/pages/login/login_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<LogInStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: const InputDecoration(hintText: 'Email'),
                controller: store.email,
              ),
              TextField(
                decoration: const InputDecoration(hintText: 'Password'),
                controller: store.password,
                obscureText: true,
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () => store.signIn(context),
                child: const Text('LogIn'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
