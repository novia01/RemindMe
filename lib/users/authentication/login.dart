import 'dart:convert';

import 'package:farmasi_yakkum/users/authentication/signup.dart';
import 'package:farmasi_yakkum/users/fragmen/dashboard.dart';
import 'package:farmasi_yakkum/users/modal/user.dart';
import 'package:farmasi_yakkum/users/userPreferences/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:farmasi_yakkum/api_connection/api_connection.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure =  true.obs;

  loginUser() async {
    try {
      var response = await http.post(
        Uri.parse(API.login),
        headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: {
          "email" :emailController.text.trim(),
          "password" : passwordController.text.trim(),
        },
      );
      if(response.statusCode == 200) {
        var resBodyOfLogin = jsonDecode(response.body);
        if(resBodyOfLogin ['success'] == true) {
          Fluttertoast.showToast(msg: "Login Successfully");

          User userInfo = User.fromJson(resBodyOfLogin["userData"]);

          //save userInfo to local storage using shared preferences
          await RememberUserPrefs.saveUser(userInfo);

          Future.delayed(Duration(milliseconds: 2000), () {
            Get.to(Dashboard());
          });

        } else {
          Fluttertoast.showToast(msg: "Incorrect email or password");
          
        }
      }
    } catch(errorMsg) {
      print("error:: " +errorMsg.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.blue,
      body: LayoutBuilder (
        builder: (context, cons) {
          return ConstrainedBox (
            constraints: BoxConstraints (minHeight: cons.minHeight),
            child: SingleChildScrollView (
              child: Column (
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height:  285,
                    child: Image.asset('assets/images/yakkum-logo.png'),
                  ),
                  Padding (
                    padding: const EdgeInsets.all(16.0),
                    child: Container (
                      decoration: const BoxDecoration (
                        color: Colors.white,
                        borderRadius: BorderRadius.all (
                          Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow (
                            blurRadius: 8,
                            color: Colors.blueGrey,
                            offset: Offset(0, -3),
                          ),
                        ]
                      ),
                      child: Padding (
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: Column (
                          children: [
                            Form (
                              key: formKey,
                              child: Column(
                                children: [
                                  //email
                                  TextFormField (
                                    controller: emailController,
                                    validator: (val) => val == " " ? "Please write email" : null,
                                    decoration:  InputDecoration (
                                      prefixIcon: const Icon (
                                        Icons.mail,
                                        color:  Colors.blue,
                                      ),
                                      hintText: "Email ....",
                                      border: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric (
                                        horizontal: 14,
                                        vertical: 4,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(height: 18,),
                                  //password
                                  TextFormField (
                                    controller: passwordController,
                                    validator: (val) => val == " " ? "Please write password" : null,
                                    decoration:  InputDecoration (
                                      prefixIcon: const Icon (
                                        Icons.key,
                                        color:  Colors.blue,
                                      ),
                                      hintText: "Password ....",
                                      border: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder ( 
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide (
                                          color: Colors.black,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric (
                                        horizontal: 14,
                                        vertical: 4,
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                  const SizedBox(height: 18,),
                                  //button
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        if(formKey.currentState!.validate()) {
                                          loginUser();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding (
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text (
                                          "Login",
                                          style: TextStyle (
                                            color:  Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                    ),
                                  ),
                                ],
                              ), 
                            ),

                            const SizedBox(height: 16,),

                            //Dont have account 
                            Row (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Dont have account?"),
                                TextButton (
                                  onPressed: () {
                                    Get.to(SignUp());
                                  } ,
                                  child: const Text (
                                    "SignUp here",
                                    style: TextStyle (
                                      color:  Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ),
                      ),
                    ),
                  ),
                  
                ],
              )
            ),
          );
        }
      ),
    );
  }
}