import 'package:basic_navigation_go_route/pages/user/main_question_screen.dart';
import 'package:basic_navigation_go_route/pages/user/view_all_question_dialog.dart';
import 'package:mobx/mobx.dart';

part 'question_store.g.dart';

class QuestionStore = QuestionBase with _$QuestionStore;

abstract class QuestionBase with Store {
  QuestionBase() {
    mcqQuestions = ObservableList.of(generateItems(10));
  }
  @observable
  int currentPage = 0;

  @observable
  bool isCollapsible = false; //means side bar is open

  @observable
  McqOptions? selectedAns = McqOptions.none;

  ObservableList<Questions> mcqQuestions = ObservableList.of([]);

  ObservableList<Questions> bookmarkedQuestion = ObservableList.of([]);

  void selectedMcqAnswer(McqOptions? value) {
    selectedAns = value;
    //mcqQuestions[index].selectedAns =selectedAns as String?;
  }

//data generator
  List<Questions> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Questions(
        headerValue: 'Question $index',
        expandedValue:
            "$index). Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries ?",

        //'Details for Question $index goes here',
        optionA: 'Option A',
        optionB: 'Option B',
        optionC: 'Option C',
        optionD: 'Option D',
        rightAns: 'Option A',
      );
    });
  }
}
