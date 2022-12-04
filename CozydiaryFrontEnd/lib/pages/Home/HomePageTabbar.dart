import 'package:cozydiary/pages/Home/HomePage.dart';
import 'package:cozydiary/pages/Home/controller/changePageController.dart';
import 'package:cozydiary/pages/Home/postRequestPage.dart';
import 'package:cozydiary/pages/Personal/Self/controller/selfController.dart';
import 'package:cozydiary/widget/keepAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../Personal/Self/Page/personal_page.dart';

class HomePageTabbar extends StatelessWidget {
  const HomePageTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("UidAndState");
    final uid = box.get("uid");
    final screens = [
      // MapPage(),
      HomePage(),
      PostRequestPage(),
      PersonalPage(uid: uid),
      // UserDataPage(),
    ];
    final controller = Get.put(ChangePageTabbarController());
    Get.put(SelfPageController());

    return Obx((() => Scaffold(
          body: IndexedStack(
            children: screens,
            index: controller.selectedIndex.value,
          ),
          bottomNavigationBar: KeepAliveWrapper(
            keepAlive: true,
            child: NavigationBar(
              destinations: [
                NavigationDestination(
                  icon: Icon(Icons.home),
                  label: "首頁",
                ),
                IconButton(
                  style: IconButton.styleFrom(
                      shape: CircleBorder(),
                      backgroundColor: controller.buttonColor.value),
                  onPressed: () => controller.onItemTapped(1),
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.person,
                  ),
                  label: "個人",
                )
              ],
              onDestinationSelected: ((value) =>
                  controller.onItemTapped(value)),
              selectedIndex: controller.selectedIndex.value,
            ),
          ),
        )));
  }
}
