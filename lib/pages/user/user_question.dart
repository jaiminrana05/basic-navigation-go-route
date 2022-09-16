import 'package:basic_navigation_go_route/pages/user/custom_app_bar.dart';
import 'package:basic_navigation_go_route/pages/user/question_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
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

  late QuestionStore store = Provider.of<QuestionStore>(context);

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _controller.forward();
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
                          horizontal: isXl
                              ? 250
                              : nowCenter
                                  ? 100
                                  : isCenter
                                      ? 240
                                      : 0),
                      child: Observer(builder: (context) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 10,
                              ),
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
                              height:
                                  ResponsiveWrapper.of(context).equals(MOBILE)
                                      ? 620
                                      : 550,
                              decoration: const BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Observer(builder: (context) {
                                return PageView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: pageController,
                                  children: List.generate(
                                    store.mcqQuestions.length,
                                    (index) => MainQuestionScreen(
                                        currentQuestion: index),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: store.currentPage != 0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (store.currentPage != 0) {
                                        pageController.animateToPage(
                                            --store.currentPage,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut);
                                      }
                                    },
                                    child: const Text('Previous'),
                                  ),
                                ),
                                Visibility(
                                  visible: store.currentPage ==
                                      store.mcqQuestions.length - 1,
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
                                  visible: store.currentPage !=
                                      store.mcqQuestions.length - 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (store.currentPage <
                                          store.mcqQuestions.length - 1) {
                                        pageController.animateToPage(
                                            ++store.currentPage,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut);
                                      }
                                    },
                                    child: const Text('Next'),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                    ),
                  ),
                  ResponsiveVisibility(
                    visible: true,
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
                                itemCount: store.mcqQuestions.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      store.currentPage = index;
                                      pageController.animateToPage(
                                          store.currentPage,
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeInOut);
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
                                children: [
                                  Text(
                                      'Total Question : ${store.mcqQuestions.length}'),
                                  const Text('Question Unvisited: 3'),
                                  const Text('Question Visited: 3'),
                                  const Text('Question Answered: 3'),
                                  const Text('Question Bookmarks: 1'),
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
                        store.isCollapsible = !store.isCollapsible;
                        store.isCollapsible
                            ? _controller.reverse()
                            : _controller.forward();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Observer(builder: (context) {
                            return Icon(
                              store.isCollapsible
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                            );
                          }),
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
      store.isCollapsible == true;

  bool get nowCenter =>
      isCenter && ResponsiveWrapper.of(context).isSmallerThan('BIGDESKTOP');

  bool get isXl =>
      ResponsiveWrapper.of(context).isLargerThan('XL') &&
      store.isCollapsible == true;
}
