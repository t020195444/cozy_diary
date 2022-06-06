import 'dart:convert';

import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/PostController.dart';
import 'package:cozydiary/pages/Personal/IntroductionWidget.dart';
import 'package:cozydiary/pages/Personal/controller/TabbarController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Data/dataResourse.dart';

class PostCoverTest extends StatelessWidget {
  const PostCoverTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _tabController = Get.put(TabbarController());
    var jsonDATA = {
      "data": [
        {
          "userName": "楊哲邊",
          "userPic": "Users/User/Desktop/加密貨幣筆記/趨勢分析 重點!!!.png",
          "likes": 2,
          "cover":
              "/Users/yangzhelun/Desktop/development/uploadFile/116177189475554672811/kobe2.jpeg",
          "title": "你好",
          "categoryName": "旅遊"
        },
        {
          "userName": "將和",
          "userPic":
              "/Users/yangzhelun/Desktop/development/uploadFile/116177189475554672811/kobe2.jpeg",
          "likes": 1,
          "cover":
              "/Users/yangzhelun/Desktop/development/uploadFile/116177189475554672811/kobe2.jpeg",
          "title": "航海王",
          "categoryName": "籃球"
        }
      ],
      "message": "獲取用戶貼文成功",
      "status": 200
    };

    Widget SliverPersistentHeaderWidget(var controller, var tab) {
      return SliverPersistentHeader(
        pinned: true,
        delegate: _SliverAppBarDelegate(
            TabBar(
                controller: controller,
                indicatorWeight: 2,
                indicatorColor: const Color.fromARGB(255, 129, 37, 37),
                labelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: false,
                tabs: tab),
            400,
            50),
      );
    }

    var controller = Get.put(PostController());
    List<PostCoverData> postCoverData = controller.postCover.value;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeaderWidget(
              _tabController.controller, _tabController.tabs),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        // var data = postCoverModuleFromJson(response);
        print(postCoverData);

        // print(data.data);
      }),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this.expandedHeight, this.tabbarHeight);

  final TabBar _tabBar;
  final double expandedHeight;
  final double tabbarHeight;

  @override
  double get minExtent => 0;
  @override
  double get maxExtent => expandedHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: <Widget>[
        Image.network(
          Image_List[3],
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          height: 400,
        ),
        // Positioned(
        //     top: expandedHeight - tabbarHeight - shrinkOffset,
        //     left: 0,
        //     child: Container(
        //         width: MediaQuery.of(context).size.width,
        //         height: tabbarHeight,
        //         decoration: BoxDecoration(
        //           color: Color.fromARGB(255, 37, 35, 35),
        //           borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(15),
        //               topRight: Radius.circular(15)),
        //         ),
        //         child: _tabBar))
      ],
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
