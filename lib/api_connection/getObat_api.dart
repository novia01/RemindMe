import 'package:farmasi_yakkum/api_connection/api_connection.dart';
import 'package:farmasi_yakkum/users/userPreferences/current_user.dart';
import 'package:farmasi_yakkum/users/modal/obat.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


Future<List<Obat>> fetchObat() async {
  final CurrentUser _currentUser = Get.put(CurrentUser());

  final response = await http.get(Uri.parse("${API.getData}?id_pasien=${_currentUser.user.id_pasien}"));
  // print(response.body);
  // print(_currentUser.user.id_pasien);
  return ObatFromJson (response.body);
}