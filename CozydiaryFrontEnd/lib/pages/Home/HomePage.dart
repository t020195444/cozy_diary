import 'package:cozydiary/pages/Activity/Map/GoogleMapPage.dart';
import 'package:cozydiary/pages/Home/controller/NestedTabbarController.dart';
import 'package:cozydiary/pages/Home/widget/HomeScreen_GridView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/TopTabbarController.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topTabbarController = Get.put(TopTabbarController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              unselectedLabelColor: Colors.black38,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              tabs: topTabbarController.topTabs),
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Image(image: AssetImage('assets/images/user1.jpg')),
          NestedTabBar(),
          GoogleMapPage()
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
          automaticallyImplyLeading: false,
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
              labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
              unselectedLabelColor: Colors.black38,
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
