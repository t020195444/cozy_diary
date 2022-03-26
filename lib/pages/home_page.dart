import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.network(_userObj.photoUrl!),
        Text(_userObj.displayName!),
        Text(_userObj.email),
        TextButton(
            onPressed: () {
              _googleSignIn.signOut().then((value) {
                setState(() {
                  _isLoggedIn = false;
                });
              }).catchError((e) {});
            },
            child: const Text("Logout"))
      ],
    ));
  }
}
