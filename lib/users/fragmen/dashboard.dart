import 'package:farmasi_yakkum/users/authentication/login.dart';
import 'package:farmasi_yakkum/users/fragmen/list_obat.dart';
import 'package:farmasi_yakkum/users/modal/user.dart';
import 'package:farmasi_yakkum/users/userPreferences/current_user.dart';
import 'package:farmasi_yakkum/users/userPreferences/user_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance; // Change here
  CurrentUser _currentUser = CurrentUser();
  var userName = null;

  Future<String?> getCurrentUserID() async {
    User? user = await RememberUserPrefs.readUserInfo(); 
    _currentUser.setCurrentUser(user);

    setState(() {
      userName = user?.namaPasien;
    });

    print(_currentUser.user.namaPasien);
    return user?.id_pasien;
  }

  signOutUser() async {
    var resultResponse = await Get.dialog(
      AlertDialog (
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Logout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          "Are you sore? \n You want to logout from app?"
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            }, 
            child: const Text(
              "No",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: "LoggedOut");
            }, 
            child: const Text(
              "Yes",
              style: TextStyle(
                color: Colors.black,
              ),
            )
          )
        ],
      ),
    );
    if (resultResponse == "LoggedOut") {
      getCurrentUserID().then((userID) {
        // print("Logout");
        // print(userID);
        var topic = "Reminder${userID}";
        _firebaseMessaging.unsubscribeFromTopic(topic);
      });
      await RememberUserPrefs.removeUserInfo().then((value) {
        Get.off(Login());
      });
    }
  }
  
  void initState()  {
    super.initState();

    getCurrentUserID().then((userID) {
      // print("getCurrentUserID");
      // print(userID);

      var topic = "Reminder${userID}";
      _firebaseMessaging.subscribeToTopic(topic);
      // print(topic);
    });

  // Handling Message In Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      // print("message recieved");
      // print(_currentUser.user.namaPasien);
      // print(userName);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(event.data["title"]),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(event.notification!.body!),
                  Image.network(
                    event.data["image"],
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover, 
                  ),
                ],
              ),
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
    
  //Handling Message In Background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message cliked');
      Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => ListObat())
      );
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Hai ${userName}', 
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
              margin: EdgeInsets.only(top: 150),
              child: InkWell(
                onTap: () {
                  signOutUser();
                },
                child: const Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
