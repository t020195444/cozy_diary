import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Home/HomePage.dart';
import 'package:cozydiary/pages/Home/controller/NestedTabbarController.dart';
import 'package:cozydiary/pages/Home/controller/TopTabbarController.dart';
import 'package:cozydiary/pages/Map/map_page.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';

import '../Personal/Page/personal_page.dart';
import 'UserData.dart';
import 'controller/ChangePageController.dart';

class HomePageTabbar extends StatelessWidget {
  const HomePageTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = Hive.box("UidAndState");
    final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
        GlobalKey();
    final screens = [
      // MapPage(),
      HomePage(),
      PersonalPage(uid: box.get("uid")),
      // UserDataPage(),
    ];
    final controller = Get.put(ChangePageTabbarController());
    final LoginController logincontroller = Get.put(LoginController());
    return
        // Obx(() =>
        Scaffold(
            // extendBodyBehindAppBar: true,
            // extendBody: true,
            // backgroundColor: Colors.black,
            // bottomNavigationBar: CurvedNavigationBar(
            //   index: controller.selectedIndex.value,
            //   key: _bottomNavigationKey,
            //   backgroundColor: Colors.transparent,
            //   buttonBackgroundColor: Colors.white,
            //   height: 50,
            //   items: <Widget>[
            //     // Icon(Icons.add_alert, size: 30),
            //     Icon(Icons.home, size: 30),
            //     Icon(
            //       Icons.person,
            //       size: 30,
            //     ),
            //   ],
            //   onTap: (index) {
            //     controller.onItemTapped(index);
            //   },
            // ),
            // body: screens[controller.selectedIndex.value],
            body: Obx((() => SpinCircleBottomBarHolder(
                  bottomNavigationBar: SCBottomBarDetails(
                      circleColors: [
                        Colors.white,
                        Colors.orange,
                        Colors.redAccent
                      ],
                      iconTheme: IconThemeData(color: Colors.black45),
                      activeIconTheme: IconThemeData(color: Colors.orange),
                      backgroundColor: Colors.white,
                      titleStyle:
                          TextStyle(color: Colors.black45, fontSize: 12),
                      activeTitleStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                      actionButtonDetails: SCActionButtonDetails(
                          color: Colors.redAccent,
                          icon: Icon(
                            Icons.expand_less,
                            color: Colors.white,
                          ),
                          elevation: 2),
                      elevation: 2.0,
                      items: [
                        // Suggested count : 4
                        SCBottomBarItem(
                            icon: Icons.home,
                            title: "首頁",
                            onPressed: () {
                              controller.onItemTapped(0);
                            }),

                        SCBottomBarItem(
                            icon: Icons.person,
                            title: "個人",
                            onPressed: () {
                              controller.onItemTapped(1);
                            }),
                      ],
                      circleItems: [
                        //Suggested Count: 3
                        SCItem(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              controller.oncircleItemsTapped();
                            }),
                        SCItem(
                            icon: Icon(Icons.image),
                            onPressed: () {
                              controller.oncircleItemsTappeduser();
                            }),
                        SCItem(
                            icon: Icon(Icons.map),
                            onPressed: () {
                              logincontroller.logout();
                            }),
                      ],
                      bnbHeight: 80 // Suggested Height 80
                      ),
                  child: screens[controller.selectedIndex.value],
                ))));
  }
}
