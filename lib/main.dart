import 'package:basic_navigation_go_route/route/route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final route = MyRoutes().routes;
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: route.routerDelegate,
      routeInformationParser: route.routeInformationParser,
      routeInformationProvider: route.routeInformationProvider,
    );
  }
}
