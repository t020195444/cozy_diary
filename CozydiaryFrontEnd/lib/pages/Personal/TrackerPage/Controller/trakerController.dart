// import 'package:cozydiary/Model/trackerListModel.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// import '../../../../Model/trackerModel.dart';
// import '../../Service/personalService.dart';

// /*------------------------------------*/
// /*TrackerController 查看追蹤中頁面控制器*/
// /*------------------------------------*/

// class TrackerController extends GetxController {
//   //ex：
//   //{tracker1: 100574561077256357905,
//   // tracker2: 114240327154813329918,
//   // name: s,
//   // trackTime:[2022, 10, 17, 23, 0, 14],
//   // pic: http://140.131.114.166:80/staticFile/114240327154813329918/userProfile/image_picker8237542444195092617.jpg
//   //    }
//   var trackerList = <TrackerList>[].obs;
//   //方便我狀態管理的list(追蹤按鈕)
//   var state = <RxBool>[];
//   var userId = "";
//   var followerList = <TrackerList>[].obs;
//   @override
//   void onInit() {
//     userId = Hive.box("UidAndState").get("uid");
//     super.onInit();
//   }

//   void getFollower(String uid) async {
//     try {
//       var trackerResponse = await PersonalService.getFollower(uid);

//       if (trackerResponse != null) {
//         if (trackerResponse.status == 200) {
//           followerList.value = trackerResponse.data;
//           // update();
//         }
//       }
//     } finally {}
//   }

//   //獲取使用者
//   void getTracker(String uid) async {
//     try {
//       var trackerResponse = await PersonalService.getTracker(uid);

//       if (trackerResponse != null) {
//         if (trackerResponse.status == 200) {
//           trackerList.value = trackerResponse.data;
//           //依照追蹤數量，全部新增成true
//           for (int i = 0; i < trackerList.length; i++) {
//             state.add(true.obs);
//           }

//           // update();
//         }
//       }
//     } finally {}
//   }

//   void tapTracker(String userUid, String otherUid, int index) async {
//     try {
//       AddTrackerModel trackerModel =
//           AddTrackerModel(tracker1: userUid, tracker2: otherUid);
//       var trackerJsonData = addTrackerModelToJson(trackerModel);
//       var trackerResponse = await PersonalService.addTracker(trackerJsonData);
//       if (trackerResponse == 200) {
//         if (state[index].value) {
//           state[index].value = false;
//           // update();
//         } else
//           state[index].value = true;
//         // update();
//       }
//       ;
//     } finally {}
//   }
// }
// /*------------------------------------*/
// //上方tabbar控制器
// /*------------------------------------*/

// class TrackerTabbarController extends GetxController
//     with GetSingleTickerProviderStateMixin {
//   final List<Tab> tabs = <Tab>[
//     Tab(text: "已追蹤"),
//     Tab(
//       text: "粉絲",
//     )
//   ];

//   late TabController controller;

//   @override
//   void onInit() {
//     super.onInit();
//     controller = TabController(length: 2, vsync: this);
//   }
// }

// /*------------------------------------*/
// /*FollowerController 查看粉絲頁面控制器*/
// /*------------------------------------*/

// // class FollowerController extends GetxController {

// //   @override
// //   void onInit() {
// //     userId = Hive.box("UidAndState").get("uid");
// //     super.onInit();
// //   }

// // }
import 'package:cozydiary/Model/trackerListModel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../Model/trackerModel.dart';
import '../../Service/personalService.dart';

class TrackerController extends GetxController {
  //ex：
  //{tracker1: 100574561077256357905,
  // tracker2: 114240327154813329918,
  // name: s,
  // trackTime:[2022, 10, 17, 23, 0, 14],
  // pic: http://140.131.114.166:80/staticFile/114240327154813329918/userProfile/image_picker8237542444195092617.jpg
  //    }
  TrackerController({required this.uid});
  final String uid;
  var trackerList = <TrackerList>[];
  var userId = Hive.box("UidAndState").get("uid");
  //方便我狀態管理的list(追蹤按鈕)
  var state = <bool>[];
  @override
  void onInit() {
    getTracker(uid);
    super.onInit();
  }

  //獲取使用者
  void getTracker(String uid) async {
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

  void tapTracker(String userUid, String otherUid, int index) async {
    try {
      AddTrackerModel trackerModel =
          AddTrackerModel(tracker1: userUid, tracker2: otherUid);
      var trackerJsonData = addTrackerModelToJson(trackerModel);
      var trackerResponse = await PersonalService.addTracker(trackerJsonData);
      if (trackerResponse == 200) {
        if (state[index]) {
          state[index] = false;
          update();
        } else
          state[index] = true;
        update();
      }
      ;
    } finally {}
  }
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
  final String uid;
  var trackerList = <TrackerList>[];
  var userId = Hive.box("UidAndState").get("uid");

  FollowerController({required this.uid});
  @override
  void onInit() {
    getFollower(uid);
    super.onInit();
  }

  Future<String> deleteFollower(
      String userUid, String otherUid, int index) async {
    try {
      AddTrackerModel trackerModel =
          AddTrackerModel(tracker1: userUid, tracker2: otherUid);
      var trackerJsonData = addTrackerModelToJson(trackerModel);
      var trackerResponse = await PersonalService.addTracker(trackerJsonData);
      if (trackerResponse == 200) {
        return "刪除成功";
      } else
        return "刪除失敗";
      ;
    } finally {}
  }

  void getFollower(String uid) async {
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
