import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final List<Item> _books = generateItems(10);

  @override
  void initState() {
    super.initState();
  }

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
