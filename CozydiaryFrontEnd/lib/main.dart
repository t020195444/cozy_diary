import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/pages/Home/widget/PickPhotoPage.dart';
import 'package:cozydiary/pages/Home/widget/PostController.dart';
import 'package:cozydiary/pages/Personal/Self/Page/personal_page.dart';
import 'package:cozydiary/pages/Register/Page/SelectLikePage.dart';
import 'package:cozydiary/register_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart';
import 'package:video_player/video_player.dart';
import 'LocalDB/UidAndState.dart';
import 'HomePostController.dart';
import 'firebase/firebase_options.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  await Hive.initFlutter();
  Hive.registerAdapter(UidAndStateAdapter());
  await Hive.openBox("UidAndState");
  imageCache.clear();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final registerController = Get.put(RegisterController());
    final logincontroller = Get.put(LoginController());
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
        primaryColor: Color.fromRGBO(234, 230, 228, 1),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(234, 230, 228, 1),
        ),
        cardTheme: CardTheme(
            color: Colors.white,
            shape: Border.all(
                color: Color.fromRGBO(234, 230, 228, 1), width: 0.5)),
      ),
      routes: {
        "homepage": (context) => const HomePageTabbar(),
        "personalpage": (context) => PersonalPage(
              uid: Hive.box("UidAndState").get("uid"),
            ),
      },
      home: MyHomePage(
        title: '',
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
  final LoginController logincontroller = Get.find<LoginController>();
  late VideoPlayerController _controller;
  var box = Hive.box("UidAndState");

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
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    // return SelectLikePage();
    var id = box.get("uid") ?? "";

    return FutureBuilder(
      initialData: false,
      future: logincontroller.login(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else {
            if (snapshot.data as bool) {
              FlutterNativeSplash.remove();
              return HomePageTabbar();
            } else {
              FlutterNativeSplash.remove();
              return Login(context);
            }
          }
        } else {
          return Container();
        }
      },
    );
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
                    child: ElevatedButton(
                      onPressed: () {
                        logincontroller.loginWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(125, 255, 255, 255),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      child: const Text(
                        "登入",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500),
                      ),
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
