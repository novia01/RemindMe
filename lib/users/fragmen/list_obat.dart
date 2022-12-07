import 'package:farmasi_yakkum/api_connection/getObat_api.dart';
import 'package:farmasi_yakkum/users/fragmen/detail_list.dart';
import 'package:farmasi_yakkum/users/modal/obat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class ListObat extends StatefulWidget {
  @override
  _ListObatState createState() =>  _ListObatState();
}

class _ListObatState extends State<ListObat> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar (
        title: Text("Daftar Obat"),
      ),
      body: Container (
        child: FutureBuilder(
          future: fetchObat(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, index) {
                  Obat obat = snapshot.data![index];
                  return Card(
                    child: TextButton (
                      onPressed: () {
                        Get.to(DetailObat());
                      },
                      child: ListTile (
                        title: Text('${obat.namaObat}'),
                        leading:  const Icon(Icons.health_and_safety_rounded),
                        subtitle: Text('${obat.aturan}'),
                      ),
                    ),
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}