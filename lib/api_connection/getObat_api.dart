import 'package:farmasi_yakkum/api_connection/api_connection.dart';
import 'package:farmasi_yakkum/users/modal/user.dart';
import 'package:farmasi_yakkum/users/modal/obat.dart';
import 'package:farmasi_yakkum/users/userPreferences/user_preferences.dart';
import 'package:http/http.dart' as http;


Future<List<Obat>> fetchObat() async {
  User? user = await RememberUserPrefs.readUserInfo(); 
  final response = await http.get(Uri.parse("${API.getData}?id_pasien=${user?.id_pasien}"));
  return ObatFromJson (response.body);
}
