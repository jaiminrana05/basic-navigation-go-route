import 'package:basic_navigation_go_route/pages/profile/profile_page.dart';
import 'package:basic_navigation_go_route/pages/questionnaire/questionnaire_home.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _index;

  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //context.goNamed('HomeScreen',params: {'tab': 'profile'});
    super.didChangeDependencies();
  }

  void onSelectionChange(int val) {
    setState(
      () {
        _index = val;
        switch (val) {
          case 0:
            context.goNamed('HomeScreen', params: {'tab': 'profile'});
            break;
          case 1:
            context.goNamed('HomeScreen', params: {'tab': 'questionnaire'});
        }
      },
    );
  }

  var pages = [const ProfilePage(), const QuestionnaireHome()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraint) {
            return SizedBox.expand(
              child: Row(
                children: [
                  NavigationRail(
                    destinations: const [
                      NavigationRailDestination(
                        label: Text('Profile'),
                        icon: Icon(Icons.person),
                      ),
                      NavigationRailDestination(
                        label: Text('Questionnaire'),
                        icon: Icon(Icons.list_alt),
                      )
                    ],
                    selectedIndex: _index,
                    onDestinationSelected: onSelectionChange,
                  ),
                  Expanded(
                    child: pages[_index!],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
