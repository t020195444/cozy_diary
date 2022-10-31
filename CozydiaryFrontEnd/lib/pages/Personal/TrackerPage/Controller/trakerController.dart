import 'package:cozydiary/Model/trackerListModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../Service/personalService.dart';

class TrackerController extends GetxController {
  //ex：
  //{tracker1: 100574561077256357905,
  // tracker2: 114240327154813329918,
  // name: s,
  // trackTime:[2022, 10, 17, 23, 0, 14],
  // pic: http://140.131.114.166:80/staticFile/114240327154813329918/userProfile/image_picker8237542444195092617.jpg
  //    }
  var trackerList = <TrackerList>[];
  var uid = Hive.box("UidAndState").get("uid");
  //方便我狀態管理的list(追蹤按鈕)
  var state = <bool>[];
  @override
  void onInit() {
    getTracker();
    super.onInit();
  }

  //獲取使用者
  void getTracker() async {
    try {
      var trackerResponse = await PersonalService.getTracker(uid);

      if (trackerResponse != null) {
        if (trackerResponse.status == 200) {
          trackerList = trackerResponse.data;
          //依照追蹤數量，全部新增成true
          for (int i = 0; i < trackerList.length; i++) state.add(true);

          update();
        }
      }
    } finally {}
  }
  //取消追蹤
  //  void deleteTracker(int index) async {
  //   try {
  //     print(trackerList[index]);

  //       var trakerResponse =
  //           await PersonalService.deleteTracker(tid.toString());

  //       print("沒有追蹤");
  //   } finally {}
  // }
}

//上方tabbar控制器
class TrackerTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "已追蹤"),
    Tab(
      text: "粉絲",
    )
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: 2, vsync: this);
  }
}

class FollowerController extends GetxController {
  var trackerList = <TrackerList>[];
  var uid = Hive.box("UidAndState").get("uid");
  @override
  void onInit() {
    getFollower();
    super.onInit();
  }

  void getFollower() async {
    try {
      var trackerResponse = await PersonalService.getFollower(uid);

      if (trackerResponse != null) {
        if (trackerResponse.status == 200) {
          trackerList = trackerResponse.data;
          update();
        }
      }
    } finally {}
  }
}
