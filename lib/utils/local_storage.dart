import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  UserSimplePreferences._internal();

  static final UserSimplePreferences _instance =
      UserSimplePreferences._internal();

  factory UserSimplePreferences() {
    return _instance;
  }

  late SharedPreferences preferences;

  Future<void> initLocalStorage() async {
    preferences = await SharedPreferences.getInstance();
  }

  static String storeUserKey = 'myKey';

  Future setUser({required bool userLogInStatus}) async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(storeUserKey, userLogInStatus);
  }

  bool getUser() {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? res = preferences.getBool(storeUserKey);

    return res ?? false;
  }

  Future setTestStatus({required bool status}) async {
    return await preferences.setBool('testStatus', status);
  }

  bool getTestStatus() {
    return preferences.getBool('testStatus') ?? false;
  }
}
