import 'package:basic_navigation_go_route/pages/login/login_page.dart';
import 'package:basic_navigation_go_route/pages/profile/profile_page.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/question_into.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/questionnaire_home.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/user_info_page.dart';
import 'package:basic_navigation_go_route/pages/quiz/quiz_list_page.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/error_page.dart';
import '../pages/home_page.dart';
import '../pages/profile/single_profile_page.dart';
import '../pages/questionnaire/test_page.dart';
import '../pages/quiz/quiz_result_page.dart';

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
        path: '/',
        redirect: (_) => 'HomeScreen/Profile',
      ),
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
          GoRoute(
            path: 'quizList',
            name: 'QuizList',
            pageBuilder: (context, state) => const MaterialPage(
              child: QuizListPage(),
            ),
            routes: [
              //http://localhost:53894/home/quizResult?currentQuiz=9
              GoRoute(
                path: 'quizResult',
                name: 'QuizResult',
                pageBuilder: (context, state) {
                  final currentQuizResult =
                      int.parse(state.queryParams['currentQuiz'] ?? '100');
                  if (currentQuizResult >= 0 && currentQuizResult <= 9) {
                    return MaterialPage(
                      child: QuizResultPage(
                        quiz: currentQuizResult,
                      ),
                    );
                  } else {
                    throw 'Result of Quiz : $currentQuizResult Not Found!';
                  }
                },

                ///just other way to handle error page when data not found
                // redirect: (state) {
                //   final currentQuizResult =
                //       int.parse(state.queryParams['currentQuiz'] ?? '100');
                //   if (currentQuizResult < 0 || currentQuizResult > 10) {
                //     return state.namedLocation('QuizList');
                //   }
                //   return null;
                // },
              ),
            ],
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
  );
}
