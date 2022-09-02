import 'package:basic_navigation_go_route/pages/login/login_page.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/error_page.dart';
import '../pages/first_page.dart';
import '../pages/home_page.dart';

class MyRoutes {
  MyRoutes._internal();

  static final MyRoutes _instance = MyRoutes._internal();

  factory MyRoutes() {
    return _instance;
  }

  final routes = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'LogIn',
        pageBuilder: (context, state) => const MaterialPage(
          child: LogInPage(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: 'HomeScreen',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomePage(),
        ),

        ///Sub-Route of HomeScreen
        routes: [
          GoRoute(
            path: 'first',
            name: 'FirstScreen',
            pageBuilder: (context, state) => const MaterialPage(
              child: FirstPage(),
            ),
          ),
        ],
      ),
    ],
    redirect: (state) {
      final loginLoc = state.namedLocation('LogIn');
      final loggingIn = state.subloc == loginLoc;
      final rootLoc = state.namedLocation('HomeScreen');
      if (!UserSimplePreferences().getUser() && !loggingIn) {
        return loginLoc;
      }
      if (UserSimplePreferences().getUser() && loggingIn) {
        return rootLoc;
      }
      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
}
