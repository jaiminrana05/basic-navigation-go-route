import 'package:basic_navigation_go_route/pages/user/user_question.dart';
import 'package:basic_navigation_go_route/values/app_colors.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>
    with SingleTickerProviderStateMixin {
  final CustomTimerController _controller = CustomTimerController();

  final int startTimeInSeconds = 60;

  final Duration endTime = Duration.zero;

  late Animation<double> _animation;

  late AnimationController _animationController;

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
        debugPrint('-------Animation finished');
      }
    });

    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onAnimationStart() {
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.backGround,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        _controller.start();
                        onAnimationStart();
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.clock,
                        ),
                        const SizedBox(width: 10),
                        CustomTimer(
                          controller: _controller,
                          begin: Duration(seconds: startTimeInSeconds),
                          end: endTime,
                          builder: (remainingTime) {
                            return Text(
                              '${remainingTime.hours}:${remainingTime.minutes}:${remainingTime.seconds}',
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Simform Solutions',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const Spacer(),
                ...[
                  const SizedBox(width: 5),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      const ViewAllQuestion().show(context);
                    },
                    child: const Icon(Icons.menu),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark),
                  ),
                  const Center(
                    child: Text('User Name'),
                  ),
                  const SizedBox(width: 5),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade100,
                    child: const Icon(
                      Icons.person,
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ],
            ),
          ),
          LinearProgressIndicator(
            minHeight: 10,
            value: _animation.value / startTimeInSeconds,
            backgroundColor: Colors.lightGreen,
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }
}

List<Widget> appBarAction(bool screenWidth, BuildContext ctx) {
  List<Widget> actionList = [
    const SizedBox(width: 5),
    ElevatedButton(
      onPressed: () {
        const ViewAllQuestion().show(ctx);
      },
      child: const Text('View all Question'),
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
