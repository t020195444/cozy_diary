import 'package:cozydiary/login_page.dart';
import 'package:cozydiary/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cozydiary/login_page_main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CozyDiary',
      theme: ThemeData(),
      routes: {
        "registerpage": (context) => const RegisterPage(),
        "loginpage": (context) => const LoginPage(),
      },
      home: const CheckAuth(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CheckAuth extends StatefulWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    if (user == null) {
      return MyHomePage(
        title: '',
      );
    } else {
      return RegisterPage();
    }
  }
}
