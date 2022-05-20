import 'package:cozydiary/pages/Home/HomePage.dart';
import 'package:cozydiary/pages/Map/map_page.dart';
import 'package:cozydiary/pages/Personal/Page/personal_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePageTabbar extends StatefulWidget {
  const HomePageTabbar({Key? key}) : super(key: key);

  @override
  _HomePageTabbarState createState() => _HomePageTabbarState();
}

class _HomePageTabbarState extends State<HomePageTabbar> {
  bool _isLoggedIn = true;
  late GoogleSignInAccount _userObj;

  int _selectedIndex = 1;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final screens = [
    MapPage(),
    HomePage(),
    PersonalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
          index: 1,
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
            setState(() {
              _onItemTapped(index);
            });
          },
        ),
        body: screens[_selectedIndex]);
  }
}
