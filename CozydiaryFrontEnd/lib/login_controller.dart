import 'dart:convert';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/pages/Register/Page/registerPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Model/registerUserDataModel.dart';
import 'api.dart';
import 'main.dart';

class LoginController extends GetxController {
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleSignIn = GoogleSignIn();

  late User? googleuser;
  late String id = '';
  late String email = '';
  late String googlepic = "";
  late List<String> responseBody;
  var userData = <RegisterUserDataModel>[].obs;
  var box = Hive.box("UidAndState");

  static Map tempData = {};

  void loginWithGoogle() async {
    googleAccount.value = await googleSignIn
        .signIn()
        // ignore: invalid_return_type_for_catch_error
        .catchError((onError) => Fluttertoast.showToast(msg: "$onError"));

    // ignore: unnecessary_null_comparison
    if (googleAccount != null) {
      final user = googleAccount.value;
      // final googleAuth = await googleAccount.value!.authentication;
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );
      // final authResult = await _auth.signInWithCredential(credential);
      // final User? user = authResult.user;
      // googleuser = user;
      id = googleSignIn.currentUser!.id;

      email = user!.email;

      bool isLogin = await login(id);
      print(isLogin);
      if (isLogin) {
        box.put("uid", id);
        Get.to(HomePageTabbar());
      } else {
        Get.to(RegisterPage());
      }

      // toregisterpage();
    }
  }

  void logout() async {
    googleAccount.value = await googleSignIn.signOut();
    Get.close(1);
    Get.offAll(const MyHomePage(
      title: '',
    ));
    box.put("uid", null);
  }

  Future<bool> login(String id) async {
    bool isLogin = false;
    var response = await http.get(Uri.parse(Api.ipUrl + Api.getUser + id));
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == 200 &&
        responseBody['data']['googleId'] == id &&
        id != "") {
      isLogin = true;
      // print("login done. isLogin = " + isLogin.toString());
    } else {
      isLogin = false;
    }
    return isLogin;
  }
}
