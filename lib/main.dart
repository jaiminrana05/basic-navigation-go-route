import 'package:basic_navigation_go_route/pages/login/login_store.dart';
import 'package:basic_navigation_go_route/route/route.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await UserSimplePreferences().initLocalStorage();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

NavigatorState get navigator => navigatorKey.currentState!;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final route = MyRoutes().routes;
    return Provider(
      create: (BuildContext context) => LogInStore(),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerDelegate: route.routerDelegate,
        routeInformationParser: route.routeInformationParser,
        routeInformationProvider: route.routeInformationProvider,
      ),
    );
  }
}
