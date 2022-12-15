import 'package:cozydiary/pages/Activity/Map/GoogleMapPage.dart';
import 'package:cozydiary/pages/Activity/widget/activity_GridView.dart';
import 'package:cozydiary/pages/Home/controller/NestedTabbarController.dart';
import 'package:cozydiary/widget/keepAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'controller/TopTabbarController.dart';
import 'searchPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topTabbarController = Get.put(TopTabbarController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 0.0, right: 0),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () =>
                  Get.to(() => SearchPage(), transition: Transition.downToUp),
            ),
          )
        ],
        // titleSpacing: 0,
        elevation: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
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
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
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
    final _scrollViewController = ScrollController();
    final _nestedTabbarController = Get.put(NestedTabbarController());

    return Obx(() => _nestedTabbarController.isLoading.value
        ? SpinKitFadingCircle(
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          )
        : NestedScrollView(
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
                          controller: _nestedTabbarController.nestedController,
                          labelPadding: EdgeInsets.symmetric(horizontal: 15.0),
                          // unselectedLabelColor: Colors.black38,
                          // unselectedLabelStyle: TextStyle(fontSize: 15),
                          tabs: _nestedTabbarController.nestedTabs),
                    ),
                  ),
                ],
            body: TabBarView(
                controller: _nestedTabbarController.nestedController,
                children: _nestedTabbarController.screen)));
  }
}
