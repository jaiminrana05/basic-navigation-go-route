import 'package:basic_navigation_go_route/pages/user/question_store.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ViewAllQuestion extends StatefulWidget {
  const ViewAllQuestion({
    Key? key,
    this.selectedIndex,
  }) : super(key: key);

  final int? selectedIndex;

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
  late QuestionStore store = Provider.of<QuestionStore>(context);

  @override
  void initState() {
    super.initState();
  }

  bool color = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: DefaultTabController(
        initialIndex: widget.selectedIndex ?? 0,
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
                    _buildPanel(),
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
    final question = store.mcqQuestions;
    return ListView.builder(
      itemCount: question.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          childrenPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          expandedAlignment: Alignment.centerLeft,
          leading: InkWell(
            onTap: () {
              setState(() {
                question[index].isBookmarked = !question[index].isBookmarked;
              });
            },
            child: Icon(
              FontAwesomeIcons.solidBookmark,
              color: question[index].isBookmarked
                  ? Colors.yellow
                  : Colors.grey.shade500,
            ),
          ),
          title: Text(question[index].headerValue),
          children: [
            Text(
              question[index].expandedValue,
              //"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries ?",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        );
      },
    );
  }
}

class Questions {
  Questions({
    required this.expandedValue,
    required this.headerValue,
    required this.rightAns,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    this.selectedAns,
    this.isBookmarked = false,
  });

  String expandedValue;
  String headerValue;
  String rightAns;
  String optionA;
  String optionB;
  String optionC;
  String optionD;
  String? selectedAns;
  bool isBookmarked;
}
