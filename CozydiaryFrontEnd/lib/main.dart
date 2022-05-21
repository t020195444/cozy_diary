import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/pages/Personal/Page/personal_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_player/video_player.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CozyDiary',
      theme: ThemeData(
          inputDecorationTheme: const InputDecorationTheme(
            counterStyle: TextStyle(color: Colors.black),
            labelStyle: TextStyle(color: Colors.black45),
            filled: true,
            fillColor: Colors.white,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          primaryColor: Color.fromARGB(255, 202, 175, 154),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 202, 175, 154),
          ),
          cardTheme: CardTheme(
              color: Colors.white,
              shape: Border.all(
                  color: Color.fromARGB(255, 195, 170, 150), width: 0.5)),
          tabBarTheme: const TabBarTheme()),
      routes: {
        "homepage": (context) => const HomePageTabbar(),
        "personalpage": (context) => const PersonalPage(),
      },
      home: const MyHomePage(
        title: 'CozyDiary',
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LoginController logincontroller = Get.put(LoginController());
  late VideoPlayerController _controller;
  bool _isLoggedIn = false;
  late GoogleSignInAccount _userObj;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Login(context)
            // Obx(() {
            // if (logincontroller.googleAccount.value == null)
            // })),
            ));
  }

  Scaffold Login(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
          child: Stack(
        children: <Widget>[
          //背景影片
          Center(
              child: ConstrainedBox(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            constraints: const BoxConstraints.expand(),
          )),

          //黑色透明背景
          Opacity(
            opacity: 0.3,
            child: ConstrainedBox(
              child: Image.asset(
                'assets/images/Black.png',
                fit: BoxFit.cover,
              ),
              constraints: const BoxConstraints.expand(),
            ),
          ),

          //CozyDiart圖片
          Center(
              child: Align(
            alignment: const Alignment(0.0, -0.35),
            child: Image.asset('assets/images/CozyDiary.png'),
          )),

          //登入按鈕
          Center(
            // ignore: deprecated_member_use
            child: Align(
                alignment: const Alignment(0.0, 0.45),
                // ignore: deprecated_member_use
                child: SizedBox(
                    width: 250,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      onPressed: () {
                        logincontroller.loginWithGoogle();
                      },
                      child: const Text(
                        "登入",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500),
                      ),
                      color: const Color.fromARGB(125, 255, 255, 255),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ))),
          ),

          //選擇登入按鈕
          Center(
            child: Align(
                alignment: const Alignment(0.0, 0.57),
                child: TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              height: 200,
                              color: Colors.black,
                              child: Center(
                                  child: Stack(
                                children: <Widget>[
                                  const Align(
                                      alignment: Alignment(0.0, -0.8),
                                      child: Text(
                                        "選擇登入方式",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  Align(
                                    alignment: const Alignment(0.0, 0.0),
                                    child: Image.asset(
                                        "assets/images/icons8-facebook-48.png"),
                                  ),
                                  const Align(
                                      alignment: Alignment(0.0, 0.3),
                                      child: Text(
                                        "Facebook",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              )));
                        });
                  },
                  child: const Text(
                    "其他登入方式  >",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )),
          ),
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
