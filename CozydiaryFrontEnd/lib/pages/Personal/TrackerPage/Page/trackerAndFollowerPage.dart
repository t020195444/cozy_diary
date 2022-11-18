// import 'package:cozydiary/pages/Personal/TrackerPage/Controller/trakerController.dart';
// import 'package:cozydiary/pages/Personal/TrackerPage/Page/followerPage.dart';
// import 'package:cozydiary/pages/Personal/TrackerPage/Page/trackerPage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TrackerAndFollowerPage extends StatelessWidget {
//   const TrackerAndFollowerPage(
//       {Key? key, required this.index, required this.uid})
//       : super(key: key);
//   final int index;
//   final String uid;

//   //tabbar物件
//   Widget buildTabbarWidget(var controller, var tab) {
//     return TabBar(
//         controller: controller,
//         indicatorWeight: 2,
//         indicatorColor: Color.fromARGB(255, 175, 152, 100),
//         labelColor: Colors.black,
//         indicatorSize: TabBarIndicatorSize.label,
//         isScrollable: true,
//         labelPadding: EdgeInsets.symmetric(horizontal: 40),
//         tabs: tab);
//   }

//   @override
//   Widget build(BuildContext context) {
//     TrackerTabbarController tabbarController =
//         Get.put(TrackerTabbarController());
//     TrackerController trackerController = Get.put(TrackerController());
//     tabbarController.controller.index = index;
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.close),
//           color: Colors.black,
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         title: buildTabbarWidget(
//             tabbarController.controller, tabbarController.tabs),
//         backgroundColor: Colors.transparent,
//       ),
//       body: SafeArea(
//           child: TabBarView(
//         controller: tabbarController.controller,
//         children: [
//           TrackerPage(uid), FollowerPage(uid)
//           // GetBuilder<TrackerController>(
//           //     init: TrackerController(),
//           //     builder: (controller) {
//           //       return TrackerPage(uid);
//           //     }),
//           // GetBuilder<FollowerController>(
//           //   init: FollowerController(),
//           //   builder: (controller) {
//           //     return FollowerPage(uid);
//           //   }
//           // )
//         ],
//       )),
//     );
//   }
// }
import 'package:cozydiary/pages/Personal/TrackerPage/Controller/trakerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../OtherPerson/Controller/otherPersonController.dart';
import '../../OtherPerson/Page/otherPersonPage.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage({Key? key, required this.index, required this.uid})
      : super(key: key);
  final int index;
  final String uid;

  //tabbar物件
  Widget buildTabbarWidget(var controller, var tab) {
    return TabBar(
        controller: controller,
        indicatorWeight: 2,
        indicatorColor: Color.fromARGB(255, 175, 152, 100),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 40),
        tabs: tab);
  }

  Widget trackerList() {
    return GetBuilder<TrackerController>(
        init: TrackerController(uid: uid),
        autoRemove: false,
        builder: (trackerController) {
          return ListView.builder(
            itemCount: trackerController.trackerList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ListTile(
                enabled: trackerController.userId ==
                        trackerController.trackerList[index].tracker2
                    ? false
                    : true,
                onTap: () => Get.to(
                  GetBuilder(
                      init: OtherPersonPageController(
                          otherUid:
                              trackerController.trackerList[index].tracker2),
                      builder: (context) {
                        return OtherPersonalPage(
                          key: UniqueKey(),
                          uid: trackerController.trackerList[index].tracker2,
                        );
                      }),
                  transition: Transition.rightToLeft,
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(trackerController.trackerList[index].pic),
                ),
                title: Text(trackerController.trackerList[index].name),
                trailing: ElevatedButton(
                  child: trackerController.state[index]
                      ? Text("取消追蹤")
                      : Text("追蹤"),
                  onPressed: () {
                    // trackerController.tapTracker(
                    //     trackerController.trackerList[index].tracker1,
                    //     trackerController.trackerList[index].tracker2,
                    //     index);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: trackerController.state[index]
                          ? Color.fromARGB(148, 149, 147, 147)
                          : Color.fromARGB(176, 202, 175, 154),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
            ),
          );
        });
  }

  Widget followerList() {
    return GetBuilder<FollowerController>(
        init: FollowerController(uid: uid),
        autoRemove: false,
        builder: (followerController) {
          return ListView.builder(
            itemCount: followerController.trackerList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: ListTile(
                style: ListTileStyle.list,
                enabled: followerController.userId ==
                        followerController.trackerList[index].tracker1
                    ? false
                    : true,
                onTap: () => Get.to(
                  () => GetBuilder<OtherPersonPageController>(
                      init: OtherPersonPageController(
                          otherUid:
                              followerController.trackerList[index].tracker1),
                      builder: (context) {
                        return OtherPersonalPage(
                          key: UniqueKey(),
                          uid: followerController.trackerList[index].tracker1,
                        );
                      }),
                  transition: Transition.rightToLeft,
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      NetworkImage(followerController.trackerList[index].pic),
                ),
                title: Text(followerController.trackerList[index].name),
                trailing: followerController.userId != uid
                    ? null
                    : ElevatedButton(
                        child: Text("移除粉絲"),
                        onPressed: () {
                          var message = followerController.deleteFollower(
                              followerController.trackerList[index].tracker1,
                              followerController.trackerList[index].tracker2,
                              index);
                          followerController.trackerList.removeAt(index);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(148, 149, 147, 147),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                      ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    TrackerTabbarController tabbarController =
        Get.put(TrackerTabbarController());
    tabbarController.controller.index = index;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        title: buildTabbarWidget(
            tabbarController.controller, tabbarController.tabs),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: TabBarView(
        controller: tabbarController.controller,
        children: [trackerList(), followerList()],
      )),
    );
  }
}
