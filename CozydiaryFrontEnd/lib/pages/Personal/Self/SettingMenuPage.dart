import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

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
                  Hive.box("UidAndState").put("themeMode", "system");
                },
                title: Text("系統預設"),
              ),
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.light);
                  Hive.box("UidAndState").put("themeMode", "light");
                },
                title: Text("淺色"),
              ),
              ListTile(
                onTap: () {
                  Get.changeThemeMode(ThemeMode.dark);
                  Hive.box("UidAndState").put("themeMode", "dark");
                },
                title: Text("深色"),
              )
            ],
          )
        ],
      ),
    );
  }
}
