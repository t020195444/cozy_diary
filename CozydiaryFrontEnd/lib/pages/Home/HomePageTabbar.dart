import 'package:cozydiary/pages/Home/HomePage.dart';
import 'package:cozydiary/pages/Home/ImagePicker.dart';
import 'package:cozydiary/pages/Map/map_page.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Personal/Page/personal_page.dart';
import 'UserData.dart';
import 'controller/ChangePageController.dart';

class HomePageTabbar extends StatelessWidget {
  const HomePageTabbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
        GlobalKey();
    final screens = [
      UserDataPage(),
      HomePage(),
      PersonalPage(),
    ];
    return GetBuilder<ChangePageTabbarController>(
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
          index: controller.selectedIndex.value,
          key: _bottomNavigationKey,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          height: 50,
          items: <Widget>[
            Icon(Icons.add_alert, size: 30),
            Icon(Icons.home, size: 30),
            Icon(
              Icons.person,
              size: 30,
            ),
          ],
          onTap: (index) {
            controller.onItemTapped(index);
          },
        ),
        body: screens[controller.selectedIndex.value],
      ),
    );
  }
}
// class HomePageTabbar extends StatefulWidget {
//   const HomePageTabbar({Key? key}) : super(key: key);

//   @override
//   _HomePageTabbarState createState() => _HomePageTabbarState();
// }

// class _HomePageTabbarState extends State<HomePageTabbar> {
//   int _selectedIndex = 1;

//   final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

//   @override
//   void initState() {
//     super.initState();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   final screens = [
//     UserDataPage(),
//     HomePage(),
//     PersonalPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         extendBodyBehindAppBar: true,
//         extendBody: true,
//         backgroundColor: Colors.black,
//         bottomNavigationBar: CurvedNavigationBar(
//           index: 1,
//           key: _bottomNavigationKey,
//           backgroundColor: Colors.transparent,
//           buttonBackgroundColor: Colors.white,
//           height: 50,
//           items: <Widget>[
//             Icon(Icons.add_alert, size: 30),
//             Icon(Icons.home, size: 30),
//             Icon(
//               Icons.person,
//               size: 30,
//             ),
//           ],
//           onTap: (index) {
//             setState(() {
//               _onItemTapped(index);
//             });
//           },
//         ),
//         body: screens[_selectedIndex]);
//   }
// }
