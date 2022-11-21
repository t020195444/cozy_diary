import 'dart:convert';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/pages/Register/Page/registerPage.dart';
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
        .catchError((onError) => Fluttertoast.showToast(msg: "$onError"));

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

  //因後端還未上伺服器 這邊先使用跳頁方法

  void tohomepage() async {
    Get.to(const HomePageTabbar());
  }

  void toregisterpage() async {
    Get.to(RegisterPage());
  }

  void testpost() async {
    var response = await http.post(
      Uri.parse('http://yapi.smart-xwork.cn/mock/152435/userRegister'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "google_id": id,
        "name": "tim",
        "sex": "1",
        "introduction": "我是usdt暴徒",
        "birth": "2001-01-30",
        "email": "10846036@ntub.edu.tw",
        "pic": "ddsfdsfdsfds"
      }),
    );
    var responseBody = jsonDecode(response.body);
    // print(responseBody['id']);
    // print(responseBody['messenge']);

    // if (responseBody != null) {
    //   Get.to(HomePageTabbar());
    // }
  }

  void printid() async {
    // print(userdata.RegisterUserData);
  }
}
