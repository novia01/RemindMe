import 'dart:convert';
import 'package:farmasi_yakkum/users/authentication/login.dart';
import 'package:farmasi_yakkum/users/modal/user.dart';
import 'package:farmasi_yakkum/api_connection/api_connection.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();
  var nomorRMController = TextEditingController();
  var namaPasienController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure =  true.obs;

  validateUserEmail() async{
    try {
      var response = await http.post (
        Uri.parse(API.validateEmail),
        body: {
          'email' : emailController.text.trim(),
        },
      );
      if(response.statusCode == 200) {
        var resBodyOfValidateEmail = jsonDecode(response.body);
        if(resBodyOfValidateEmail ['emailFound'] == true) {
          Fluttertoast.showToast(msg: "Email is already use");
        } else {
          //Register and save data to database
          saveUserRecord();
        }
      }
    } 
    catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  saveUserRecord() async {
    User userModel = User (
      nomorRMController.text.trim(),
      namaPasienController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try {
      var response = await http.post (
        Uri.parse(API.signup),
        body:  userModel.toJson(),
        headers: {
          // 'Content-Type': 'application/json',
          'Charset': 'utf-8'
        },
      );
      if(response.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(response.body);
        if(resBodyOfSignUp ['success'] == true) {
          Fluttertoast.showToast(msg: "SignUp Successfully!");

          setState(() {
            nomorRMController.clear();
            namaPasienController.clear();
            emailController.clear();
            passwordController.clear();
          });

        } else {
          Fluttertoast.showToast(msg: "Error, Try Again!");
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
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
                                  //nomorRM
                                  TextFormField (
                                    controller: nomorRMController,
                                    validator: (val) => val == " " ? "Please write ur nomor rekam medik" : null,
                                    decoration:  InputDecoration (
                                      prefixIcon: const Icon (
                                        Icons.numbers,
                                        color:  Colors.blue,
                                      ),
                                      hintText: "Nomor RM ....",
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
                                  //username
                                  TextFormField (
                                    controller: namaPasienController,
                                    validator: (val) => val == " " ? "Please write username" : null,
                                    decoration:  InputDecoration (
                                      prefixIcon: const Icon (
                                        Icons.person,
                                        color:  Colors.blue,
                                      ),
                                      hintText: "Nama ....",
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
                                        if (formKey.currentState!.validate())
                                        {
                                          validateUserEmail();
                                          //validate the email
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding (
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 28,
                                        ),
                                        child: Text (
                                          "Register",
                                          style: TextStyle (
                                            color:  Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                    ),
                                  )
                                ],
                              ), 
                            ),

                            const SizedBox(height: 16,),

                            //already have account 
                            Row (
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have account?"),
                                TextButton (
                                  onPressed: () {
                                    Get.to(Login());
                                  } ,
                                  child: const Text (
                                    "Login here",
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