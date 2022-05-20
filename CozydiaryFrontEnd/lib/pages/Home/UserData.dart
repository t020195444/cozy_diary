import 'package:cozydiary/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDataPage extends StatelessWidget {
  UserDataPage({Key? key}) : super(key: key);
  final LoginController logincontroller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User資料'),
      ),
      body: Column(
        children: [
          Text(logincontroller.userId),
          Text(logincontroller.id),
          CupertinoButton(
              child: const Text("顯示"),
              onPressed: () => logincontroller.getuserdata()),
        ],
      ),
    );
  }
}
