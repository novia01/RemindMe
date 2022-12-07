import 'dart:convert';

import 'package:farmasi_yakkum/users/modal/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs {
  //save and remember user info
  static Future<void> saveUser (User userInfo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userJsonData = jsonEncode(userInfo.toJson());
    await preferences.setString("currentUser", userJsonData);
  }
  //get and read User Info
  static Future<User?> readUserInfo() async {
    User? currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userInfo = preferences.getString("currentUser");

    if(userInfo != null) {
      Map <String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }
}