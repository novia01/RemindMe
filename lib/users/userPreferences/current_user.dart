import 'package:farmasi_yakkum/users/modal/user.dart';
import 'package:farmasi_yakkum/users/userPreferences/user_preferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController{
  Rx<User> _currentUser = User('','','' ,'' , '').obs;

  User get user => _currentUser.value;
  
  setCurrentUser(User? user) {
    if (user != null) {
      _currentUser.value = user;
    }
  }

  getUserInfo () async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}