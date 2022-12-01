import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Register/Page/SelectLikePage.dart';

class UserManagemenetPage extends StatelessWidget {
  const UserManagemenetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("管理帳戶"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("類別管理"),
            onTap: () {
              Get.to(() => SelectLikePage(
                    isRegiststate: true,
                  ));
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
