import 'package:basic_navigation_go_route/pages/profile/profile_page.dart';
import 'package:mobx/mobx.dart';

part 'profile_store.g.dart';

class ProfileStore = ProfileBase with _$ProfileStore;

abstract class ProfileBase with Store {
  ObservableList<NewProfile> profileList = ObservableList<NewProfile>();

  void onCreate(String id) {
    profileList.add(NewProfile(id));
  }
}
