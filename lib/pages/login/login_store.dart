import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LogInStore = LogInBase with _$LogInStore;

abstract class LogInBase with Store {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signIn(BuildContext context) {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      UserSimplePreferences().setUser(userLogInStatus: true);
      context.goNamed('HomeScreen');
      dispose();
    }
  }

  void dispose() {
    email.clear();
    password.clear();
  }
}
