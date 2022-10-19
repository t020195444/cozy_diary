import 'package:cozydiary/Model/trackerListModel.dart';
import 'package:cozydiary/pages/Personal/TrackerPage/Controller/trakerController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackerPage extends StatelessWidget {
  const TrackerPage(
      {Key? key, required this.index, required this.trackerListData})
      : super(key: key);
  final int index;
  final List<TrackerList> trackerListData;

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
    // SliverPersistentHeader(
    //     pinned: true,
    //     floating: true,
    //     delegate: _TabbarDelegate(
    //       TabBar(
    //           controller: controller,
    //           indicatorWeight: 2,
    //           indicatorColor: Color.fromARGB(255, 175, 152, 100),
    //           labelColor: Colors.black,
    //           indicatorSize: TabBarIndicatorSize.label,
    //           isScrollable: true,
    //           labelPadding: EdgeInsets.symmetric(horizontal: 40),
    //           tabs: tab),
    //     ));
  }

  Widget trackerList() {
    return ListView.builder(
      itemCount: 15,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(trackerListData[index].pic),
          ),
          title: Text(trackerListData[index].name),
          trailing: ElevatedButton(
            child: Text("取消追蹤"),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(148, 149, 147, 147),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TrackerController trackerController = Get.put(TrackerController());
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
          children: [trackerList(), trackerList()],
        ),
      ),
    );
  }
}
