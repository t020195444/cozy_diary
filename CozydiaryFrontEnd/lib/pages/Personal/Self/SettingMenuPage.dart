import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingMenuPage extends StatelessWidget {
  const SettingMenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: Text("主題"),
            children: [
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.system);
                },
                title: Text("系統預設"),
              ),
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.light);
                },
                title: Text("淺色"),
              ),
              ListTile(
                onTap: () => Get.changeThemeMode(ThemeMode.dark),
                title: Text("深色"),
              )
            ],
          )
        ],
      ),
    );
  }
}
