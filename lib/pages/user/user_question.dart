import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';

class UserQuestion extends StatefulWidget {
  const UserQuestion({Key? key}) : super(key: key);

  @override
  State<UserQuestion> createState() => _UserQuestionState();
}

class _UserQuestionState extends State<UserQuestion>
    with SingleTickerProviderStateMixin {
  var pageController = PageController();

  int _currentPage = 0;

  var pages = [
    Container(
      height: 100,
      width: 100,
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
              children: const [
                Text(
                  'Question 1 of 10',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(
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
                Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries ?",
                ),
                ListTile(
                  leading: Radio(
                    groupValue: null,
                    onChanged: (Null? value) {},
                    value: null,
                  ),
                  title: const Text('A.  Option A'),
                ),
                ListTile(
                  leading: Radio(
                    groupValue: null,
                    onChanged: (Null? value) {},
                    value: null,
                  ),
                  title: const Text('B.  Option B'),
                ),
                ListTile(
                  leading: Radio(
                    groupValue: null,
                    onChanged: (Null? value) {},
                    value: null,
                  ),
                  title: const Text('C.  Option C'),
                ),
                ListTile(
                  leading: Radio(
                    groupValue: null,
                    onChanged: (Null? value) {},
                    value: null,
                  ),
                  title: const Text('D.  Option D'),
                ),
              ],
            ),
          ),
        ],
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
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 5"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 6"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 7"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 8"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 9"),
      ),
    ),
    const SizedBox(
      height: 100,
      width: 100,
      child: Center(
        child: Text("Question 10"),
      ),
    ),
  ];

  late Animation<double> _animation;
  late AnimationController _animationController;

  final CustomTimerController _controller = CustomTimerController();
  final int startTimeInSeconds = 60;
  final Duration endTime = Duration.zero;
  bool collapseable = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        seconds: startTimeInSeconds,
      ),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: startTimeInSeconds.toDouble(),
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        print('-------Animation finished');
      }
    });

    _animationController.addListener(() {
      setState(() {});
    });
  }

  void onAnimationStart() {
    _animationController.forward(from: 0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool myScreenWidth = MediaQuery.of(context).size.width > 1020;
    return Scaffold(
      appBar: AppBar(
        leading: Column(
          children: [
            // const SizedBox(width: 10),
            // const Icon(
            //   FontAwesomeIcons.clock,
            // ),
            const Text('Timer'),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                _controller.start();
                onAnimationStart();
              },
              child: CustomTimer(
                controller: _controller,
                begin: Duration(seconds: startTimeInSeconds),
                end: endTime,
                builder: (remainingTime) {
                  return Text(
                      '${remainingTime.hours}:${remainingTime.minutes}:${remainingTime.seconds}');
                },
              ),
            ),
          ],
        ),
        title: const Center(
          child: Text('Simform Solutions'),
        ),
        actions: AppBarAction(myScreenWidth),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 8,
            value: _animation.value / startTimeInSeconds,
            backgroundColor: Colors.greenAccent,
            color: Colors.green,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Simform Aptitude Test',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
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
                Visibility(
                  visible: myScreenWidth,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.only(left: 30),
                    duration: const Duration(milliseconds: 300),
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
                                        duration:
                                            const Duration(milliseconds: 300),
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
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

List<Widget> AppBarAction(bool screenWidth) {
  List<Widget> actionList = [
    const SizedBox(width: 5),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu),
    ),
    const Center(
      child: Text('View all Question'),
    ),
    IconButton(
      onPressed: () {},
      icon: const Icon(Icons.bookmark),
    ),
    const Center(
      child: Text('User Name'),
    ),
    const SizedBox(width: 5),
    const CircleAvatar(
      child: Icon(Icons.person),
    ),
    const SizedBox(width: 5),
  ];

  List<Widget> singleMenu = [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: PopupMenuButton(
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            const PopupMenuItem(
              child: Text('User Name'),
            ),
            const PopupMenuItem(
              child: Text('View all Question'),
            ),
            const PopupMenuItem(
              child: Text('Bookmark'),
            ),
          ];
        },
      ),
    ),
  ];
  return screenWidth ? actionList : singleMenu;
}
