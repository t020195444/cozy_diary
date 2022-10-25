import 'package:cozydiary/pages/Register/Page/selectLikePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class UserManagemenetPage extends StatelessWidget {
  const UserManagemenetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            title: Text("類別管理"),
            onTap: () {
              Get.to(() => SelectLikePage());
            },
          ),
          Divider(
            height: 1,
          )
        ],
      ),
    );
  }
}
