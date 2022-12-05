import 'package:farmasi_yakkum/api_connection/api_connection.dart';
import 'package:farmasi_yakkum/users/modal/obat.dart';
import 'package:http/http.dart' as http;

Future<List<Obat>> fetchObat() async {
  final response = await http.get(Uri.parse(API.getData));
  return ObatFromJson (response.body);
}