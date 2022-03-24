import 'package:cozydiary/pages/home_page.dart';
import 'package:cozydiary/pages/login_page.dart';
import 'package:cozydiary/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:video_player/video_player.dart';

void main() async {
  runApp(MyApp());
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
        "homepage": (context) => HomePage(),
      },
      home: HomePage(),
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
  late VideoPlayerController _controller;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('asstes/images/video.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'asstes/images/Black.png',
                fit: BoxFit.cover,
              ),
              constraints: const BoxConstraints.expand(),
            ),
          ),

          //CozyDiart圖片
          Center(
              child: Align(
            alignment: const Alignment(0.0, -0.35),
            child: Image.asset('asstes/images/CozyDiary.png'),
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
                      onPressed: () async {
                        await _googleSignIn.signIn();
                        setState(() {});
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
                                        "asstes/images/icons8-facebook-48.png"),
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
