import 'package:farmasi_yakkum/api_connection/getObat_api.dart';
import 'package:farmasi_yakkum/users/modal/obat.dart';
import 'package:flutter/material.dart';


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
                  itemCount:1,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
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
                            borderRadius: BorderRadius.circular(20),
                            child: GestureDetector(
                              onTap: () async {
                                showDialog<AlertDialog>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actions: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Text('${obat.namaObat}'), 
                                            Image.network('https://604e-2001-448a-404e-10bd-a807-9c2f-5905-a3a7.ap.ngrok.io/Admin_Farmasi_Yakkum/images/${obat.judul}'),
                                          ],
                                        )
                                      ],
                                    );
                                  }
                                );
                              },
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