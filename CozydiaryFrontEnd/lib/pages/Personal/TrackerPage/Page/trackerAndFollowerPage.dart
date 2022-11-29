import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cozydiary/pages/Personal/TrackerPage/Controller/trakerController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        indicatorSize: TabBarIndicatorSize.label,
        isScrollable: true,
        labelPadding: EdgeInsets.symmetric(horizontal: 40),
        tabs: tab);
  }

  Widget trackerList() {
    return GetBuilder<TrackerController>(
        tag: uid,
        init: TrackerController(uid: uid),
        autoRemove: false,
        builder: (trackerController) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(hintText: "輸入..."),
                      controller: TextEditingController(),
                    ),
                  ),
                )
              ];
            },
            body: ListView.builder(
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
                      trackerController.tapTracker(
                          trackerController.trackerList[index].tracker1,
                          trackerController.trackerList[index].tracker2,
                          index);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: trackerController.state[index]
                            ? Color.fromARGB(176, 149, 147, 147)
                            : Color.fromARGB(174, 164, 131, 106),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget followerList() {
    return GetBuilder<FollowerController>(
        tag: uid,
        init: FollowerController(uid: uid),
        autoRemove: false,
        builder: (followerController) {
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(hintText: "輸入..."),
                      controller: TextEditingController(),
                    ),
                  ),
                )
              ];
            },
            body: ListView.builder(
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
                            Get.defaultDialog(
                              title: "通知",
                              textCancel: "取消",
                              textConfirm: "確認",
                              content: Text(
                                "確定要刪除？",
                                style: TextStyle(fontSize: 16),
                              ),
                              contentPadding: EdgeInsets.all(30),
                              onConfirm: () {
                                var message = followerController.deleteFollower(
                                    followerController
                                        .trackerList[index].tracker1,
                                    followerController
                                        .trackerList[index].tracker2,
                                    index);
                                if (message == "刪除成功") {
                                  followerController.trackerList
                                      .removeAt(index);
                                } else if (message == "刪除失敗") {
                                  Get.showSnackbar(GetSnackBar(
                                    messageText: Text("移除失敗"),
                                  ));
                                }
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(176, 149, 147, 147),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30))),
                        ),
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
        actions: [
          // IconButton(
          //     onPressed: () {

          //     },
          //     icon: Icon(Icons.search))
        ],
        leading: IconButton(
          icon: Icon(Icons.close),
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
