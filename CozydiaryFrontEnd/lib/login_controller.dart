import 'dart:convert';
import 'package:cozydiary/Model/UserDataModel.dart' as userdata;
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'main.dart';
import 'pages/Register/RegisterPage.dart';

class LoginController extends GetxController {
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  var googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late User? googleuser;
  late String id = '';
  late String email = '';
  late String googlepic = "";
  late List<String> responseBody;
  var userData = <userdata.UserDataModel>[].obs;

  void loginWithGoogle() async {
    googleAccount.value = await googleSignIn.signIn();
    final googleAuth = await googleAccount.value!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;
    googleuser = user;
    id = googleSignIn.currentUser!.id;

    email = user!.email!;
    googlepic = user.providerData[0].photoURL!;

    toregisterpage();
  }

  void logout() async {
    googleAccount.value = await googleSignIn.signOut();
    Get.to(const MyHomePage(
      title: '',
    ));
  }

  void get() async {
    var response =
        await http.get(Uri.parse('http://172.20.10.3:8080/getUser?gid=' + id));
    var responseBody = jsonDecode(response.body);
    print(responseBody);
    if (responseBody['data'] != null && responseBody['data']['googleId'] == id)
      Get.to(HomePageTabbar());
    else
      Get.to(RegisterPage());
  }

  void post() async {
    http.post(
      Uri.parse('http://172.20.10.3:8080/userRegister'),
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
    print(responseBody['id']);
    print(responseBody['messenge']);

    // if (responseBody != null) {
    //   Get.to(HomePageTabbar());
    // }
  }

  void testget() async {
    var response = await http
        .get(Uri.parse('http://yapi.smart-xwork.cn/mock/152435/userRegister'));
    var responseBody = jsonDecode(response.body);
    print(responseBody);
  }

  void printid() async {
    print(userdata.User);
  }
}
