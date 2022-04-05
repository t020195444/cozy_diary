import 'package:cozydiary/pages/Homepage.dart';
import 'package:cozydiary/screen_widget/viewPostScreen.dart';
import 'package:cozydiary/screen_widget/HomeScreen_GridView.dart';
import 'package:cozydiary/pages/personal_page.dart';
import 'package:cozydiary/pages/register_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = true;
  late GoogleSignInAccount _userObj;

  int _selectedIndex = 0;

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
    homepage(),
    RegisterPage(),
    PersonalPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.white,
          height: 50,
          items: <Widget>[
            Icon(Icons.home, size: 30),
            Icon(Icons.add, size: 30),
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
