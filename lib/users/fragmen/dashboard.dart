import 'package:farmasi_yakkum/users/authentication/login.dart';
import 'package:farmasi_yakkum/users/fragmen/detail_list.dart';
import 'package:farmasi_yakkum/users/fragmen/list_obat.dart';
import 'package:farmasi_yakkum/users/userPreferences/current_user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CurrentUser _rememberCurrentUser = Get.put(CurrentUser());
  late FirebaseMessaging messaging;
  @override
  void initState()  {
    super.initState();
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
    _firebaseMessaging.subscribeToTopic("Reminder");

    _firebaseMessaging.getToken().then((token){
        print("token is $token");
    });

  // NOTIF Running on FOREGROUND
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reminder!'),
            content:
            Image.network(
            'https://yakkum.or.id/wp-content/uploads/2020/10/73385ead-af8a-4b29-93bf-2940a14a5ef2.png',
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            ),
            actions: [
              TextButton(
                child: const Text("Tutup"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Lihat Detail"),
                onPressed: () {
                  Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => ListObat())
                  );
                },
              ),
            ],
          );
        });
    });

      
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print('Message cliked');
        Navigator.push(
          context, MaterialPageRoute(builder: (BuildContext context) => DetailObat())
        );
      }
    );
  }
  
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CurrentUser(),
      initState: (currrentState){
        _rememberCurrentUser.getUserInfo();
      },
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Hai, Admin Example hehe',
            style: TextStyle(fontSize: 18, color: Colors.grey.shade700)),
            leading : GestureDetector (
              onTap: () {},
                child: const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blueGrey,
                ),
            ),

            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.blueGrey,
                  ),
                )
              ),
            ],
          ),

          body: 
          SingleChildScrollView (
            child: Column(
              children: [
                Center(  
                  child: Container(
                    height: 140,
                    width: 340,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      color: Colors.blue,
                    ),
                    margin: const EdgeInsets.only(bottom: 100),
                    child: Stack (
                      children: [
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 140,
                            width: 130,
                            decoration: BoxDecoration(
                              color: Colors.indigo.shade900,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                                topLeft: Radius.circular(0),
                                bottomLeft: Radius.circular(170),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 20,
                          child: Row(
                            children: <Widget>[
                              Image.asset('assets/images/yakkum-logo-white.png'),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 5,
                          child: Column(
                            children: const [
                              Text('Yayasan Kristen \n untuk \n Kesehatan Umum\n',
                                style: TextStyle(fontSize: 24, color: Colors.white)),
                              Text('Berkarya Berdasarkan Kasih',
                                style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.white)
                              ),  
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Column(
                  children: [
                    Container( 
                      child: TextButton(
                        onPressed: () {
                          Get.to(ListObat());
                        },
                        child : Material(
                          color: Colors.white,
                          elevation: 10,
                          borderRadius: BorderRadius.circular(20),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Ink.image(
                                image: const AssetImage('assets/images/obat.png'), 
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 6,),
                              const Text('Konsumsi Obat',
                                style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8,),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 340,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.only(top: 180),
                  child: TextButton(
                    onPressed: () {
                      Get.to(Login());
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    ); 
  }
}
