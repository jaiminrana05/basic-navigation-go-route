import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LogInStore = LogInBase with _$LogInStore;

abstract class LogInBase with Store {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isLogIn = false;

  void signIn(BuildContext context) {
    if (email.text != '' && password.text != '') {
      UserSimplePreferences().setUser(userLogInStatus: true);
      context.goNamed('HomeScreen');
    }
  }
}
