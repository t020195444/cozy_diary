import 'dart:convert';
import 'dart:io';

import 'package:cozydiary/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserDataPage extends StatelessWidget {
  UserDataPage({Key? key}) : super(key: key);
  final LoginController logincontroller = Get.put(LoginController());

  void post() {
    http.post(
      Uri.parse('http://172.20.10.3:8080/userRegister'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "google_id": logincontroller.id,
        "name": "tim",
        "sex": "1",
        "introduction": "我是usdt暴徒",
        "birth": "2001-01-30",
        "email": "10846036@ntub.edu.tw",
        "pic": "ddsfdsfdsfds"
      }),
    );
  }

  void get() async {
    var response = await http.get(
        Uri.parse('http://172.20.10.3:8080/getUser?gid=' + logincontroller.id));
    var responseBody = jsonDecode(response.body);
    if (responseBody[0] == null)
      print("您尚未註冊");
    else
      print(responseBody);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User資料'),
      ),
      body: Column(
        children: [
          Text(logincontroller.id),
          CupertinoButton(
              child: const Text("發送"),
              onPressed: () => logincontroller.testpost()),
          CupertinoButton(
              child: const Text("登出"),
              onPressed: () => logincontroller.logout()),
          CupertinoButton(
              child: const Text("printID"),
              onPressed: () => logincontroller.printid()),
        ],
      ),
    );
  }
}
