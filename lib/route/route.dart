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
    initialLocation: '/HomeScreen',
    routes: [
      GoRoute(
        path: '/HomeScreen',
        name: 'Home',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomePage(),
        ),

        ///Sub-Route of HomeScreen
        routes: [
          GoRoute(
            path: 'FirstScreen',
            name: 'First',
            pageBuilder: (context, state) => const MaterialPage(
              child: FirstPage(),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: ErrorPage(error: state.error),
    ),
  );
}
