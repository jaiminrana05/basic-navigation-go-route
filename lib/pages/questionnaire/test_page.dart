import 'package:basic_navigation_go_route/main.dart';
import 'package:basic_navigation_go_route/utils/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var pageController = PageController();

  int _currentPage = 0;

  var pages = [
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 1"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 2"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 3"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 4"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            height: double.infinity,
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Test Page'),
                const SizedBox(height: 10),
                SizedBox(
                  height: 500,
                  width: 500,
                  child: PageView(
                    controller: pageController,
                    children: [...pages],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage != 0) {
                          pageController.animateToPage(--_currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                        setState(() {});
                      },
                      child: const Text('Previous'),
                    ),
                    Visibility(
                      visible: _currentPage == pages.length - 1,
                      child: ElevatedButton(
                        onPressed: () {
                          UserSimplePreferences().setTestStatus(status: false);
                          Router.neglect(context, () {
                            context.goNamed(
                              'HomeScreen',
                              params: {'tab': 'profile'},
                            );
                          });
                        },
                        child: const Text('Finish'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage < pages.length - 1) {
                          pageController.animateToPage(++_currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                        setState(() {});
                      },
                      child: const Text('Next'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
