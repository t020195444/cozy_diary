import 'package:cozydiary/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final LoginController logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Center(
        child: Column(
          children: [
            Text('註冊頁面'),
            Text(logincontroller.userId),
            Text(logincontroller.id),
            CupertinoButton(
                child: const Text("登出"),
                onPressed: () => logincontroller.logout()),
          ],
        ),
      )),
    );
  }
}
