import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogOutOverlay extends StatelessWidget {
  const LogOutOverlay({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          child,
          Positioned(
            top: 4,
            right: 4,
            child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(10),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.green),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                overlayColor: MaterialStateProperty.all(Colors.red),
              ),
              onPressed: () {
                UserSimplePreferences().setUser(userLogInStatus: false);
                context.goNamed('LogIn');
              },
              child: const Icon(
                Icons.logout,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
