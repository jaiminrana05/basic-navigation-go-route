import 'package:basic_navigation_go_route/pages/user/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_app_bar.dart';

class UserQuestion extends StatefulWidget {
  const UserQuestion({Key? key}) : super(key: key);

  @override
  State<UserQuestion> createState() => _UserQuestionState();
}

enum McqOptions { A, B, C, D, none }

class _UserQuestionState extends State<UserQuestion> {
  var pageController = PageController();

  int _currentPage = 0;

  var pages = List.generate(
    10,
    (index) => MainQuestionScreen(
      currentQuestion: index + 1,
    ),
  );

  bool collapseable = false;

  @override
  Widget build(BuildContext context) {
    bool myScreenWidth = MediaQuery.of(context).size.width > 1020;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
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
                          decoration: const BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),

                          height: 500,
                          // width: 500,
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
                                    pageController.animateToPage(--_currentPage,
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
                                    pageController.animateToPage(++_currentPage,
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
                  Visibility(
                    visible: myScreenWidth,
                    child: AnimatedContainer(
                      margin: const EdgeInsets.only(left: 30),
                      duration: const Duration(milliseconds: 3000),
                      width: collapseable ? 0 : 400,
                      child: Column(
                        children: [
                          Visibility(
                            visible: !collapseable,
                            child: const Text('Quiz Summary'),
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
                                      pageController.animateToPage(_currentPage,
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
                            child: Visibility(
                              visible: !collapseable,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: myScreenWidth,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          collapseable = !collapseable;
                        });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                        child: Center(
                          child: Icon(
                            collapseable
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
}

// TweenAnimationBuilder<Duration>(
// duration: Duration(minutes: 3),
// tween: Tween(begin: Duration(minutes: 3), end: Duration.zero),
// onEnd: () {
// print('Timer ended');
// },
// builder: (BuildContext context, Duration value, Widget? child) {
// final minutes = value.inMinutes;
// final seconds = value.inSeconds % 60;
// return Padding(
// padding: const EdgeInsets.symmetric(vertical: 5),
// child: Text('$minutes:$seconds',
// textAlign: TextAlign.center,
// style: TextStyle(
// color: Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: 30)));
// }),

class MainQuestionScreen extends StatefulWidget {
  const MainQuestionScreen({
    Key? key,
    required this.currentQuestion,
  }) : super(key: key);

  final int currentQuestion;

  @override
  State<MainQuestionScreen> createState() => _MainQuestionScreenState();
}

class _MainQuestionScreenState extends State<MainQuestionScreen> {
  McqOptions? selectedAns = McqOptions.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Question ${widget.currentQuestion} of 10',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.bookmark,
                    size: 40,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries ?",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  RadioListTile(
                    title: const Text(
                      'A.  Option A',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.A,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'B.  Option B',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.B,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'C.  Option C',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.C,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                      'D.  Option D',
                      style: TextStyle(fontSize: 20),
                    ),
                    value: McqOptions.D,
                    groupValue: selectedAns,
                    onChanged: (McqOptions? value) {
                      setState(() {
                        selectedAns = value;
                      });
                    },
                  ),
                  Visibility(
                    visible: selectedAns != McqOptions.none,
                    child: ListTile(
                      title: const Text(
                        'Clear Selection',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedAns = McqOptions.none;
                        });
                      },
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
}

class ViewAllQuestion extends StatefulWidget {
  const ViewAllQuestion({Key? key}) : super(key: key);

  Future<void> show(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (_) => this,
    );
  }

  @override
  State<ViewAllQuestion> createState() => _ViewAllQuestionState();
}

class _ViewAllQuestionState extends State<ViewAllQuestion>
    with SingleTickerProviderStateMixin {
  final List<Item> _books = generateItems(10);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DefaultTabController(
        length: 2,
        child: SizedBox(
          width: 600,
          height: 400,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
                child: TabBar(
                  tabs: [
                    Text(
                      'All Questions',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Bookmark Question',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(child: _buildPanel()),
                    const SizedBox(
                      child: Text('Bookmarks'),
                      //_buildPanel(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return Column(
      children: [
        ExpansionPanelList(
          dividerColor: Colors.red,
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _books[index].isExpanded = !isExpanded;
            });
          },
          children: _books.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              backgroundColor: Colors.green,
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Padding(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    leading: const Icon(FontAwesomeIcons.bookmark),
                    title: Text(item.headerValue),
                  ),
                );
              },
              body: Padding(
                padding: EdgeInsets.zero,
                child: ListTile(
                  title: Text(item.expandedValue),
                ),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Question $index',
      expandedValue: 'Details for Question $index goes here',
    );
  });
}
