import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Home/homePageTabbar.dart';
import 'package:cozydiary/pages/Personal/Self/Page/personal_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:video_player/video_player.dart';
import 'LocalDB/UidAndState.dart';
import 'firebase/firebase_options.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

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
    return GetMaterialApp(
      // localizationsDelegates: [
      //   PickerLocalizationsDelegate.delegate, // 如果要使用本地化，请添加此行，则可以显示中文按钮
      // ],
      // supportedLocales: [
      //   const Locale('en', 'US'),
      //   const Locale('zh', 'CH'),
      //   const Locale('ko', 'KO'),
      //   const Locale('it', 'IT'),
      //   const Locale('ar', 'AR'),
      //   const Locale('tr', 'TR')
      // ],
      title: 'CozyDiary',
      //所有主題顏色與框架都是用這個套件調整，若要細部調整，用以下網址
      //https://rydmike.com/flexcolorscheme/themesplayground-v6/#/
      theme: FlexThemeData.light(
        scheme: FlexScheme.gold,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurfacesVariantDialog,
        blendLevel: 16,
        appBarOpacity: 0.95,
        tabBarStyle: FlexTabBarStyle.forBackground,
        lightIsWhite: true,
        subThemesData: const FlexSubThemesData(
          appBarBackgroundSchemeColor: SchemeColor.onInverseSurface,
          navigationBarLabelBehavior:
              NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.gold,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarOpacity: 0.90,
        tabBarStyle: FlexTabBarStyle.forBackground,
        subThemesData: const FlexSubThemesData(
          navigationBarLabelBehavior:
              NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
      ),
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,

      // ThemeData().copyWith(
      //   colorScheme: flexSchemeLight,
      //   useMaterial3: true,

      //   //輸入框的Theme
      //   inputDecorationTheme: const InputDecorationTheme(
      //     counterStyle: TextStyle(color: Colors.black),
      //     labelStyle: TextStyle(color: Colors.black45),
      //     filled: true,
      //     fillColor: Colors.white,
      //     errorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red),
      //       borderRadius: BorderRadius.all(Radius.circular(15)),
      //     ),
      //     enabledBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.black54),
      //       borderRadius: BorderRadius.all(Radius.circular(15)),
      //     ),
      //     focusedBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.black87),
      //       borderRadius: BorderRadius.all(Radius.circular(15)),
      //     ),
      //     focusedErrorBorder: OutlineInputBorder(
      //       borderSide: BorderSide(color: Colors.red),
      //       borderRadius: BorderRadius.all(Radius.circular(15)),
      //     ),
      //   ),
      //   //主題顏色(主要顏色)
      //   primaryColor: Color.fromRGBO(234, 230, 228, 1),
      //   // //預設Scaffold背景顏色
      //   // scaffoldBackgroundColor: Colors.white,
      //   //AppBar主題顏色
      //   appBarTheme: AppBarTheme(
      //     titleTextStyle: TextStyle(color: Colors.black54, fontSize: 20),
      //     iconTheme: IconThemeData(color: Colors.black54),
      //     // backgroundColor: Color.fromRGBO(234, 230, 228, 1),
      //   ),
      //   tabBarTheme: TabBarTheme(labelColor: Colors.black54),
      //   //Card主題顏色
      //   cardTheme: CardTheme(
      //       // color: Colors.white,
      //       shape: Border.all(
      //           color: Color.fromRGBO(234, 230, 228, 1), width: 0.5)),
      // ),

      //路由
      routes: {
        "homepage": (context) => const HomePageTabbar(),
        "personalpage": (context) => PersonalPage(
              uid: Hive.box("UidAndState").get("uid"),
            ),
      },
      home: MyHomePage(
        title: '',
      ),
      //右上角Debug標籤
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
  //Hive(Local資料表套件)BOX建立
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

    /*先進行LOGIN的Future<funtion> -> 執行完會進行判斷->
      -> 如果狀態為done(完成) -> 判斷是否有error -> 有：顯示Error；沒有：判斷回傳的Bool(是否為登入狀態與後端是否有此id資料)
      -> 若為TRUE就進入主頁不用登入；False則進入登入頁面*/
    // var registerController = Get.put(RegisterController());
    // return Scaffold(
    //   body: ElevatedButton(
    //     onPressed: () => RegisterController().fetchCategoryList(),
    //     child: Center(child: Text("Click")),
    //   ),
    // );
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout_outlined),
          onPressed: () => logincontroller.logout(),
        ),
      ),
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
