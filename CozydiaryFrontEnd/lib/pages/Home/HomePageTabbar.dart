import 'package:cozydiary/pages/Home/HomePage.dart';
import 'package:cozydiary/pages/Home/controller/changePageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'controller/homePostController.dart';
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
      Scaffold(
        appBar: AppBar(title: Text("發文")),
      ),
      PersonalPage(uid: uid),
      // UserDataPage(),
    ];
    final controller = Get.put(ChangePageTabbarController());
    final HomePostController postController = Get.put(HomePostController());

    return Obx((() => Scaffold(
          body: screens[controller.selectedIndex.value]
          // SpinCircleBottomBarHolder(
          //     bottomNavigationBar: SCBottomBarDetails(
          //         circleColors: [Colors.white, Colors.orange, Colors.redAccent],
          //         iconTheme: IconThemeData(color: Colors.black45),
          //         activeIconTheme: IconThemeData(color: Colors.orange),
          //         backgroundColor: Colors.white,
          //         titleStyle: TextStyle(color: Colors.black45, fontSize: 12),
          //         activeTitleStyle: TextStyle(
          //             color: Colors.black,
          //             fontSize: 12,
          //             fontWeight: FontWeight.bold),
          //         actionButtonDetails: SCActionButtonDetails(
          //             color: Colors.redAccent,
          //             icon: Icon(
          //               Icons.expand_less,
          //               color: Colors.white,
          //             ),
          //             elevation: 2),
          //         elevation: 2.0,
          //         items: [
          //           // Suggested count : 4
          //           SCBottomBarItem(
          //               icon: Icons.home,
          //               title: "首頁",
          //               onPressed: () {
          //                 controller.onItemTapped(0);
          //               }),

          //           SCBottomBarItem(
          //               icon: Icons.person,
          //               title: "個人",
          //               onPressed: () {
          //                 controller.onItemTapped(1);
          //               }),
          //         ],
          //         circleItems: [
          //           //Suggested Count: 3
          //           SCItem(
          //               icon: Icon(Icons.add),
          //               onPressed: () {
          //                 controller.oncircleItemsTapped();
          //               }),
          //           SCItem(
          //               icon: Icon(Icons.image),
          //               onPressed: () {
          //                 controller.oncircleItemsTappeduser();
          //               }),
          //           SCItem(
          //               icon: Icon(Icons.map),
          //               onPressed: () {
          //                 postController.getPostCover();
          //               }),
          //         ],
          //         bnbHeight: 80 // Suggested Height 80
          //         ),
          //     child: Obx((() => screens[controller.selectedIndex.value])))
          ,
          bottomNavigationBar: NavigationBar(
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
            onDestinationSelected: ((value) => controller.onItemTapped(value)),
            selectedIndex: controller.selectedIndex.value,
          ),
        )));
  }
}
