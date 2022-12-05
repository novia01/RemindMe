import 'package:farmasi_yakkum/api_connection/getObat_api.dart';
import 'package:farmasi_yakkum/users/fragmen/dashboard.dart';
import 'package:farmasi_yakkum/users/modal/obat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DetailObat extends StatefulWidget {
  @override
  _DetailObatState createState() =>  _DetailObatState();
}

class _DetailObatState extends State<DetailObat> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar (
        title: Text("Detail Daftar Obat"),
      ),
      body: SingleChildScrollView(
        child: Container (
          child: FutureBuilder(
            future: fetchObat(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    Obat obat = snapshot.data![index];
                    return Column(
                      children: <Widget>[
                        Card(
                          child: 
                          ListTile(
                            title: Text('Nama Obat'),
                            trailing: Text('${obat.namaObat}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Tanggal Mulai'),
                            trailing: Text('${obat.tanggalMulai}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Tanggal Selesai'),
                            trailing: Text('${obat.tanggalSelesai}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Jam Mulai'),
                            trailing: Text('${obat.jamMulai}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Dosis'),
                            // trailing: 
                            trailing: Text('${obat.jumlahDosis}' + ' x ' + '${obat.satuanDosis}' + '\n' + ' @ ' + '${obat.jumlahTakaran}' + '  ' + '${obat.satuanTakaran}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Aturan Konsumsi'),
                            trailing: Text('${obat.aturan}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Aturan tambahan'),
                            subtitle: Text('${obat.aturanTambahan}'),
                          ),
                        ),
                        Card(
                          child: 
                          ListTile(
                            title: Text('Deskripsi Obat'),
                            subtitle: Text('${obat.deskripsi}'),
                          ),
                        ),
                        Material(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                          child: InkWell(
                            onTap: () {
                              Get.to(Dashboard());
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: const Padding (
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 28,
                              ),
                              child: Text (
                                "Lihat Gambar Obat",
                                style: TextStyle (
                                  color:  Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                          ),
                        ),
                      ]
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}