class API {
  static const hostConnect = 'http://192.168.10.140/api';
  static const hostConnectUser = '$hostConnect/user';
  static const hostConnectData = '$hostConnect/data';

  //signup user
  static const validateEmail = '$hostConnect/user/validate_email.php';
  static const signup = '$hostConnect/user/signup.php';
  //login
  static const login = '$hostConnect/user/login.php';

  //fetch data
  static const getData = '$hostConnect/data/get_data.php';

  //detail fetch
  static const getDetail = '$hostConnect/data/detail_data.php';
  
}