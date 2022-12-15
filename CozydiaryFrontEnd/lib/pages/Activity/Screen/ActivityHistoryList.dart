import 'package:cozydiary/pages/Activity/Screen/ActivityViewPostScreen.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityGetPostController.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class ActivityHistoryList extends StatelessWidget {
  ActivityGetPostController getPostController =
      Get.put(ActivityGetPostController());

  @override
  Widget build(BuildContext context) {
    getPostController
        .getActivityHistoryList(Hive.box("UidAndState").get("uid"));
    //主畫面
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text("活動列表")),
        body: Obx(
          () => ListView.builder(
              itemCount: getPostController.activityHistoryList.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: GestureDetector(
                      onTap: () async {
                        await ActivityPostService.getActivityDetail(
                            getPostController.checkActivityHistory[index]['aid']
                                .toString());
                        Get.to(() => ActivityViewPostScreen(
                              id: getPostController.checkActivityHistory[index]
                                      ['aid']
                                  .toString(),
                              name: getPostController.activityHistoryUser[index]
                                      ['name']
                                  .toString(),
                              pic: getPostController.activityHistoryUser[index]
                                      ['pic']
                                  .toString(),
                            ));
                      },
                      child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(getPostController
                                .activityHistoryList[index]['cover']),
                          ),
                          title: Text(
                            getPostController.activityHistoryList[index]
                                ['activityName'],
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    getPostController.activityHistoryList[index]
                                                ['activityTime'][0]
                                            .toString() +
                                        "年" +
                                        getPostController
                                            .activityHistoryList[index]
                                                ['activityTime'][1]
                                            .toString() +
                                        "月" +
                                        getPostController
                                            .activityHistoryList[index]
                                                ['activityTime'][2]
                                            .toString() +
                                        "日" +
                                        getPostController
                                            .activityHistoryList[index]
                                                ['activityTime'][3]
                                            .toString() +
                                        "時" +
                                        getPostController
                                            .activityHistoryList[index]
                                                ['activityTime'][4]
                                            .toString() +
                                        "分",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    getPostController.activityHistoryList[index]
                                        ['content'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.20,
                              child: Obx(() => getPostController
                                              .checkActivityHistory[index]
                                          ['qualified'] ==
                                      0
                                  ? getPostController.checkActivityHistory[index]
                                              ['participant'] !=
                                          getPostController.activityHistoryList[index]
                                              ['holder']
                                      ? Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .appBarTheme
                                                  .backgroundColor,
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .backgroundColor,
                                                  width: 2.0,
                                                  style: BorderStyle.solid),
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text("已報名",
                                                style: TextStyle(
                                                    color: Colors.black)),
                                          ))
                                      : Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(color: Theme.of(context).primaryColor, border: Border.all(color: Theme.of(context).primaryColor, width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text("審核",
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ))
                                  : Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(color: Color.fromARGB(255, 175, 223, 140), border: Border.all(color: Color.fromARGB(255, 175, 223, 140), width: 2.0, style: BorderStyle.solid), borderRadius: BorderRadius.circular(20)),
                                      child: Center(
                                        child: Text("審核通過",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            )),
                                      )))))),
                );
              })),
        ));
  }
}
