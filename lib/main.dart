import 'package:basic_navigation_go_route/pages/login/login_store.dart';
import 'package:basic_navigation_go_route/pages/profile/profile_store.dart';
import 'package:basic_navigation_go_route/route/route.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
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
