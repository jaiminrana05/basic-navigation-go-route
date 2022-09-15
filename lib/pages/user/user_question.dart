import 'package:basic_navigation_go_route/pages/user/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'custom_app_bar.dart';
import 'main_question_screen.dart';

class UserQuestion extends StatefulWidget {
  const UserQuestion({Key? key}) : super(key: key);

  @override
  State<UserQuestion> createState() => _UserQuestionState();
}

class _UserQuestionState extends State<UserQuestion>
    with SingleTickerProviderStateMixin {
  var pageController = PageController();

  int _currentPage = 0;

  bool collapsible = false;

  late final AnimationController _controller;

  var pages = List.generate(
    10,
    (index) => MainQuestionScreen(
      currentQuestion: index + 1,
    ),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: nowCenter
                              ? 100
                              : isCenter
                                  ? 240
                                  : 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 10),
                            child: Text(
                              'Simform Aptitude Test',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: ResponsiveWrapper.of(context).equals(MOBILE)
                                ? 620
                                : 550,
                            decoration: const BoxDecoration(
                              color: Colors.white54,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: PageView(
                              controller: pageController,
                              children: [...pages],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: _currentPage != 0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_currentPage != 0) {
                                      pageController.animateToPage(
                                          --_currentPage,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut);
                                    }
                                    setState(() {});
                                  },
                                  child: const Text('Previous'),
                                ),
                              ),
                              Visibility(
                                visible: _currentPage == pages.length - 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Are you sure you want to submit the Test?'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Cancle'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: const Text('Submit'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: const Text('Finish'),
                                ),
                              ),
                              Visibility(
                                visible: _currentPage != pages.length - 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_currentPage < pages.length - 1) {
                                      pageController.animateToPage(
                                          ++_currentPage,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeInOut);
                                    }
                                    setState(() {});
                                  },
                                  child: const Text('Next'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  ResponsiveVisibility(
                    hiddenWhen: const [Condition.smallerThan(name: DESKTOP)],
                    child: SizeTransition(
                      axis: Axis.horizontal,
                      sizeFactor: _controller,
                      child: Container(
                        margin: const EdgeInsets.only(left: 30),
                        //duration: const Duration(milliseconds: 300),
                        width: 400,
                        child: Column(
                          children: [
                            const Text(
                              'Quiz Summary',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              height: 500,
                              width: 400,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Colors.white54,
                              ),
                              child: GridView.builder(
                                clipBehavior: Clip.hardEdge,
                                padding: const EdgeInsets.all(10),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5,
                                  //maxCrossAxisExtent: 70,
                                  childAspectRatio: 4 / 3,
                                ),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _currentPage = index;
                                        pageController.animateToPage(
                                            _currentPage,
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut);
                                      });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black26,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              height: 250,
                              width: 400,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: const [
                                  Text('Total Question : 10'),
                                  Text('Question Unvisited: 3'),
                                  Text('Question Visited: 3'),
                                  Text('Question Answered: 3'),
                                  Text('Question Bookmarks: 1'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ResponsiveVisibility(
                    hiddenWhen: const [Condition.smallerThan(name: DESKTOP)],
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          !collapsible
                              ? _controller.forward()
                              : _controller.reverse();
                          collapsible = !collapsible;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Icon(
                            collapsible
                                ? Icons.chevron_left
                                : Icons.chevron_right,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isCenter =>
      ResponsiveWrapper.of(context).isLargerThan(TABLET) &&
      collapsible == false;

  bool get nowCenter =>
      isCenter && ResponsiveWrapper.of(context).isSmallerThan('BIGDESKTOP');
}
