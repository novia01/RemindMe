import 'dart:convert';
import 'dart:core';

List<Obat> ObatFromJson(String str) => List<Obat>.from(json.decode(str).map((x) => Obat.fromMap(x)));

String pToJson (List<Obat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Obat {
  String id_notifikasi;
  String namaObat;
  String tanggalMulai;
  String tanggalSelesai;
  String jumlahDosis;
  String satuanDosis;
  String jumlahTakaran;
  String satuanTakaran;
  String aturan;
  String jamMulai;
  String aturanTambahan;
  String deskripsi;
  String judul;

  Obat({
    required this.id_notifikasi,
    required this.namaObat,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.jumlahDosis,
    required this.satuanDosis,
    required this.jumlahTakaran,
    required this.satuanTakaran,
    required this.aturan,
    required this.jamMulai,
    required this.aturanTambahan,
    required this.deskripsi,
    required this.judul,
  });

  factory Obat.fromMap(Map <String, dynamic> json) => Obat(
    id_notifikasi: json["id_notifikasi"].toString(),
    namaObat : json["namaObat"],
    tanggalMulai : json["tanggalMulai"],
    tanggalSelesai : json["tanggalSelesai"],
    jumlahDosis : json["jumlahDosis"],
    satuanDosis : json["satuanDosis"],
    jumlahTakaran : json["jumlahTakaran"],
    satuanTakaran : json["satuanTakaran"],
    aturan: json["aturan"],
    jamMulai : json["jamMulai"],
    aturanTambahan : json["aturanTambahan"],
    deskripsi: json["deskripsi"],
    judul: json["judul"],
  );
  
  Map<String, dynamic> toMap() => {
    "id_notifikasi" : id_notifikasi,
    "tanggalMulai" : tanggalMulai,
    "tanggalSelesai" : tanggalSelesai,
    "jumlahDosis" : jumlahDosis,
    "satuanDosis" : satuanDosis,
    "jumlahTakaran" : jumlahTakaran,
    "aturan" : aturan,
    "jamMulai" : jamMulai,
    "aturanTambahan" : aturanTambahan,
    "deskripsi" : deskripsi,
    "judul" : judul,
  };
}