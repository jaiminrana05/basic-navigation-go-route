import 'package:basic_navigation_go_route/pages/log_out_overlay.dart';
import 'package:basic_navigation_go_route/pages/login/login_page.dart';
import 'package:basic_navigation_go_route/pages/profile/profile_page.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/question_into.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/questionnaire_home.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/user_info_page.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/profile/single_profile_page.dart';
import '../pages/questionnaire/test_page.dart';

class MyRoutes {
  MyRoutes._internal();

  static final MyRoutes _instance = MyRoutes._internal();

  factory MyRoutes() {
    return _instance;
  }

  final routes = GoRouter(
    urlPathStrategy: UrlPathStrategy.path,
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/login',
        name: 'LogIn',
        pageBuilder: (context, state) => const MaterialPage(
          child: LogInPage(),
        ),
      ),
      GoRoute(
        path: '/HomeScreen/:tab(profile|questionnaire)',
        name: 'HomeScreen',
        pageBuilder: (context, state) => const MaterialPage(
          child: HomePage(),
        ),

        ///Sub-Route of HomeScreen
        routes: [
          GoRoute(
            path: 'questionnaire',
            name: 'Questionnaire',
            pageBuilder: (context, state) => const MaterialPage(
              child: QuestionnaireHome(),
            ),
          ),
          GoRoute(
            path: 'start',
            name: 'Start',
            builder: (context, state) {
              final id = state.queryParams['id'];
              return QuestionIntroScreen(id: id);
            },
            redirect: (state) {
              if (state.queryParams['id'] != 'test123') {
                return '/HomeScreen/profile';
              }
              if (!UserSimplePreferences().getTestStatus()) {
                return '/HomeScreen/profile';
              }
              return null;
            },
            routes: [
              GoRoute(
                path: 'user-info',
                name: 'User-Info',
                builder: (context, state) {
                  final id = state.queryParams['id'];
                  return UserInfoPage(id: id);
                },
                redirect: (state) {
                  if (state.queryParams['id'] != 'test123') {
                    return '/HomeScreen/profile';
                  }
                  if (!UserSimplePreferences().getTestStatus()) {
                    return '/HomeScreen/profile';
                  }
                  return null;
                },
              ),
              GoRoute(
                path: 'test',
                name: 'Test',
                pageBuilder: (context, state) => const MaterialPage(
                  child: TestPage(),
                ),
                redirect: (state) {
                  if (state.queryParams['id'] != 'test123') {
                    return '/HomeScreen/profile';
                  }
                  if (!UserSimplePreferences().getTestStatus()) {
                    return '/HomeScreen/profile';
                  }
                  return null;
                },
              ),
            ],
          ),
          GoRoute(
            path: 'profile',
            name: 'Profile',
            pageBuilder: (context, state) => const MaterialPage(
              child: ProfilePage(),
            ),
          ),
          GoRoute(
            path: 'singleProfile',
            name: 'SingleProfile',
            pageBuilder: (context, state) {
              final id = int.parse(state.queryParams['id'] ?? '0');
              return MaterialPage(
                child: SingleProfilePage(
                  profileId: id,
                ),
              );
            },
          ),
        ],
      ),
    ],
    redirect: (state) {
      final loginLoc = state.namedLocation('LogIn');
      final loggingIn = state.subloc == loginLoc;
      final rootLoc =
          state.namedLocation('HomeScreen', params: {'tab': 'profile'});
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
    navigatorBuilder: (context, state, child) {
      final userLogInStatus = UserSimplePreferences().getUser();
      return userLogInStatus ? LogOutOverlay(child: child) : child;
    },
  );
}
