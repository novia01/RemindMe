class API  {
  static const hostConnect = 'https://604e-2001-448a-404e-10bd-a807-9c2f-5905-a3a7.ap.ngrok.io/api';
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