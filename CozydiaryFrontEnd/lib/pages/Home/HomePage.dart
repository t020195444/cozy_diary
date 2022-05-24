import 'package:cozydiary/pages/Home/controller/NestedTabbarController.dart';
import 'package:cozydiary/pages/Home/widget/HomeScreen_GridView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'controller/TopTabbarController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  final topTabbarController = Get.put(TopTabbarController());
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              controller: topTabbarController.topController,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              unselectedLabelColor: Color.fromARGB(150, 255, 255, 255),
              unselectedLabelStyle: TextStyle(fontSize: 15),
              tabs: topTabbarController.topTabs),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   iconSize: 30.0,
        //   color: Color.fromARGB(155, 0, 0, 0),
        //   onPressed: () {
        //     print('back to user page');
        //   }, //=> Navigator.pop(context),
        // ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.more_horiz),
        //     iconSize: 30.0,
        //     color: Color.fromARGB(155, 0, 0, 0),
        //     onPressed: () {
        //       print('more');
        //     }, //=> Navigator.pop(context),
        //   ),
        // ],
      ),
      body: TabBarView(
        children: <Widget>[
          Image(image: AssetImage('assets/images/user1.jpg')),
          NestedTabBar(),
          Image(image: AssetImage('assets/images/pic1.jpg'))
        ],
        controller: topTabbarController.topController,
      ),
    );
  }
}

class NestedTabBar extends StatelessWidget {
  const NestedTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    final _scrollViewController = ScrollController();
    final _nestedTabbarController = Get.put(NestedTabbarController());
    return NestedScrollView(
      controller: _scrollViewController,
      headerSliverBuilder: (context, bool) => [
        SliverAppBar(
          primary: true,
          floating: false,
          pinned: true,
          snap: false,
          expandedHeight: 0,
          title: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
              controller: _nestedTabbarController.nestedController,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              unselectedLabelColor: Color.fromARGB(150, 255, 255, 255),
              unselectedLabelStyle: TextStyle(fontSize: 15),
              tabs: _nestedTabbarController.nestedTabs),
        ),
      ],
      body: TabBarView(
        controller: _nestedTabbarController.nestedController,
        children: <Widget>[
          //文章放這，如果要捲動套件，要自己加，我目前沒寫
          Container(
            child: const HomeScreen(),
          ),
          Container(
            child: const HomeScreen(),
          ),
          Container(
            child: const HomeScreen(),
          ),
          Container(
            child: const HomeScreen(),
          ),
          Container(
            child: const HomeScreen(),
          ),
        ],
      ),
    );
  }
}

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   @override
//   void initState() {
//     super.initState();
//     _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
//     //調整第一頁的tarbar
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // debugPaintSizeEnabled = true;

//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         title: Center(
//           child: TabBar(
//               isScrollable: true,
//               indicatorSize: TabBarIndicatorSize.label,
//               labelStyle: TextStyle(
//                 fontSize: 17,
//                 fontWeight: FontWeight.bold,
//               ),
//               controller: _tabController,
//               labelColor: Colors.white,
//               labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
//               unselectedLabelColor: Color.fromARGB(150, 255, 255, 255),
//               unselectedLabelStyle: TextStyle(fontSize: 15),
//               tabs: <Widget>[
//                 Tab(
//                   text: ('關注'),
//                 ),
//                 Tab(
//                   text: ('發現'),
//                 ),
//                 Tab(
//                   text: ('附近'),
//                 ),
//               ]),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           iconSize: 30.0,
//           color: Color.fromARGB(155, 0, 0, 0),
//           onPressed: () {
//             print('back to user page');
//           }, //=> Navigator.pop(context),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.more_horiz),
//             iconSize: 30.0,
//             color: Color.fromARGB(155, 0, 0, 0),
//             onPressed: () {
//               print('more');
//             }, //=> Navigator.pop(context),
//           ),
//         ],
//       ),
//       body: TabBarView(
//         children: <Widget>[
//           Image(image: AssetImage('assets/images/user1.jpg')),
//           NestedTabBar(),
//           Image(image: AssetImage('assets/images/pic1.jpg'))
//         ],
//         controller: _tabController,
//       ),
//     );
//   }
// }

// class NestedTabBar extends StatefulWidget {
//   @override
//   _NestedTabBarState createState() => _NestedTabBarState();
// }

// class _NestedTabBarState extends State<NestedTabBar>
//     with TickerProviderStateMixin {
//   late TabController _nestedTabController;
//   var _scrollViewController;
//   @override
//   void initState() {
//     super.initState();
//     _nestedTabController = new TabController(length: 5, vsync: this);
//     _scrollViewController = ScrollController();
//     //調整第二頁中的tabbar
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _nestedTabController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     return NestedScrollView(
//       controller: _scrollViewController,
//       headerSliverBuilder: (context, bool) => [
//         SliverAppBar(
//           primary: true,
//           floating: false,
//           pinned: true,
//           snap: false,
//           expandedHeight: 0,
//           title: TabBar(
//             isScrollable: true,
//             indicatorSize: TabBarIndicatorSize.label,
//             labelStyle: TextStyle(
//               fontSize: 17,
//               fontWeight: FontWeight.bold,
//             ),
//             controller: _nestedTabController,
//             labelColor: Colors.white,
//             labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
//             unselectedLabelColor: Color.fromARGB(150, 255, 255, 255),
//             unselectedLabelStyle: TextStyle(fontSize: 15),
//             tabs: <Widget>[
//               Container(
//                   height: 30,
//                   width: 30,
//                   child: Center(
//                     child: Text(
//                       '運動',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 12,
//                       ),
//                     ),
//                   )),
//               Container(
//                   height: 30,
//                   width: 50,
//                   child: Center(
//                     child: Text('美妝',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                         )),
//                   )),
//               Container(
//                   height: 30,
//                   width: 50,
//                   child: Center(
//                     child: Text('生活',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                         )),
//                   )),
//               Container(
//                   height: 30,
//                   width: 50,
//                   child: Center(
//                     child: Text('藝術',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                         )),
//                   )),
//               Container(
//                   height: 30,
//                   width: 50,
//                   child: Center(
//                     child: Text('搞笑',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 12,
//                         )),
//                   )),
//             ],
//           ),
//         ),
//       ],
//       body: TabBarView(
//         controller: _nestedTabController,
//         children: <Widget>[
//           //文章放這，如果要捲動套件，要自己加，我目前沒寫
//           Container(
//             child: const HomeScreen(),
//           ),
//           Container(
//             child: const HomeScreen(),
//           ),
//           Container(
//             child: const HomeScreen(),
//           ),
//           Container(
//             child: const HomeScreen(),
//           ),
//           Container(
//             child: const HomeScreen(),
//           ),
//         ],
//       ),
//     );
//   }
// }
