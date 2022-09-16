import 'package:basic_navigation_go_route/pages/login/login_store.dart';
import 'package:basic_navigation_go_route/pages/profile/profile_store.dart';
import 'package:basic_navigation_go_route/pages/user/question_store.dart';
import 'package:basic_navigation_go_route/route/route.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() async {
  await UserSimplePreferences().initLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final route = MyRoutes().routes;
    return MultiProvider(
      providers: [
        Provider<LogInStore>(
          create: (context) => LogInStore(),
        ),
        Provider<ProfileStore>(
          create: (context) => ProfileStore(),
        ),
        Provider<QuestionStore>(
          create: (context) => QuestionStore(),
        ),
      ],
      child: MaterialApp.router(
        builder: (context, widget) => ResponsiveWrapper.builder(
          ClampingScrollWrapper.builder(context, widget!),
          breakpoints: const [
            ResponsiveBreakpoint.resize(500, name: MOBILE),
            ResponsiveBreakpoint.resize(850, name: TABLET),
            ResponsiveBreakpoint.resize(1150, name: DESKTOP),
            ResponsiveBreakpoint.resize(1350, name: 'BIGDESKTOP'),
            ResponsiveBreakpoint.resize(1700, name: 'XL'),
          ],
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Quiz Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routerDelegate: route.routerDelegate,
        routeInformationParser: route.routeInformationParser,
        routeInformationProvider: route.routeInformationProvider,
      ),
    );
  }
}
