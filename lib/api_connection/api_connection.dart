class API  {
  static const hostConnect = 'https://a44f-2001-448a-4043-7399-79cf-7447-1acb-2a83.ap.ngrok.io/api';
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
  static const getDetail = '$hostConnect/data/details.php';
}