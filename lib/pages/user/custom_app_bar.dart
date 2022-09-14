import 'package:basic_navigation_go_route/pages/user/view_all_question_dialog.dart';
import 'package:basic_navigation_go_route/values/app_colors.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
              vertical: 5,
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
                const ResponsiveVisibility(
                  visible: false,
                  visibleWhen: [Condition.largerThan(name: TABLET)],
                  child: ActionList(),
                ),
                ResponsiveVisibility(
                  visible: false,
                  visibleWhen: const [Condition.smallerThan(name: DESKTOP)],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: PopupMenuButton(
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry>[
                          const PopupMenuItem(
                            child: Text('User Name'),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              print('popupmenus');
                              const ViewAllQuestion(
                                selectedIndex: 0,
                              ).show(context);
                              setState(() {});
                            },
                            child: const Text('View all Question'),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              const ViewAllQuestion(
                                selectedIndex: 1,
                              ).show(context);
                            },
                            child: const Text('Bookmark'),
                          ),
                        ];
                      },
                    ),
                  ),
                ),
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

class ActionList extends StatelessWidget {
  const ActionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            const ViewAllQuestion(
              selectedIndex: 0,
            ).show(context);
          },
          icon: const Icon(FontAwesomeIcons.bars),
        ),
        const SizedBox(width: 5),
        IconButton(
          onPressed: () {
            const ViewAllQuestion(
              selectedIndex: 1,
            ).show(context);
          },
          icon: const Icon(FontAwesomeIcons.bookmark),
        ),
        const Center(
          child: Text('User Name'),
        ),
        const SizedBox(width: 5),
        const CircleAvatar(
          child: Icon(Icons.person),
        ),
        const SizedBox(width: 5),
      ],
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
