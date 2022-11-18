import 'package:cozydiary/pages/Activity/Map/GoogleMapPage.dart';
import 'package:cozydiary/pages/Activity/widget/activity_GridView.dart';
import 'package:cozydiary/pages/Home/controller/NestedTabbarController.dart';
import 'package:cozydiary/widget/keepAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'controller/HomePostController.dart';
import 'controller/TopTabbarController.dart';
import 'widget/homeScreen_GridView.dart';

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
              // unselectedLabelColor: Colors.black38,
              unselectedLabelStyle: TextStyle(fontSize: 15),
              tabs: topTabbarController.topTabs),
        ),
      ),
      body: TabBarView(
        children: <Widget>[ActivityScreen(), NestedTabBar(), GoogleMapPage()],
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
    final homePostController = Get.put(HomePostController());
    final _nestedTabbarController = Get.put(NestedTabbarController());

    return Obx(() => _nestedTabbarController.isLoading.value
        ? SpinKitFadingCircle(
            size: 50,
            color: Colors.black,
          )
        : RefreshIndicator(
            notificationPredicate: (notification) {
              return true;
            },
            onRefresh: () async {
              // await homePostController.getPostCover(
              //     (_nestedTabbarController.nestedController.index + 1)
              //         .toString());
              // print(homePostController.postCover);
            },
            child: NestedScrollView(
                controller: _scrollViewController,
                headerSliverBuilder: (context, bool) => [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        primary: true,
                        floating: false,
                        pinned: true,
                        snap: false,
                        expandedHeight: 0,
                        title: KeepAliveWrapper(
                          child: TabBar(
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              labelStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              controller:
                                  _nestedTabbarController.nestedController,
                              labelPadding:
                                  EdgeInsets.symmetric(horizontal: 15.0),
                              // unselectedLabelColor: Colors.black38,
                              // unselectedLabelStyle: TextStyle(fontSize: 15),
                              tabs: _nestedTabbarController.nestedTabs),
                        ),
                      ),
                    ],
                body: TabBarView(
                    controller: _nestedTabbarController.nestedController,
                    children: _nestedTabbarController.screen))));
  }
}
