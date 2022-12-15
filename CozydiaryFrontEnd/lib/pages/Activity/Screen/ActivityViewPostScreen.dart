import 'package:cozydiary/pages/Activity/Map/ShowActivityLocation.dart';
import 'package:cozydiary/pages/Activity/Screen/ActivityParticipantListScreen.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityGetPostController.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class ActivityViewPostScreen extends StatelessWidget {
  ActivityViewPostScreen(
      {required this.id, required this.name, required this.pic});
  String name;
  String pic;
  String id = "";
  //Controller
  final commentCtr = TextEditingController(text: "");

  ActivityGetPostController getPostController =
      Get.put(ActivityGetPostController());

  @override
  Widget build(BuildContext context) {
    getPostController.isParticipant.value = false;
    getPostController.isActivityParticipant(
        ActivityPostService.activityDetailList['participant']);
    getPostController.getActivityParticipantList();
    getPostController.activityId.value = int.parse(id);
    getPostController.checkLikeList(id);
    final contentCtr = TextEditingController(
        text: getPostController.participantContent.value.toString());
    //主畫面
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  pic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ActivityPostService.activityDetailList['holder'] ==
                      Hive.box("UidAndState").get("uid")
                  ? PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("刪除活動"),
                          onTap: () => getPostController.deleteActivity(id),
                        )
                      ],
                      child:
                          Icon(Icons.more_horiz_outlined, color: Colors.brown),
                    )
                  : null,
            )
          ],
        ),
        body: Obx(
          (() => SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => _viewPostPic(
                                id: id,
                              ));
                        },
                        child: Center(
                          child: Image.network(
                            ActivityPostService.activityDetailList['url'][0]!,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[350]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[100],
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 10),
                                child: Text(
                                  ActivityPostService
                                      .activityDetailList['activityName'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 10),
                                child: Text(
                                  "活動時間：" +
                                      ActivityPostService
                                          .activityDetailList['activityTime'][0]
                                          .toString() +
                                      "年" +
                                      ActivityPostService
                                          .activityDetailList['activityTime'][1]
                                          .toString() +
                                      "月" +
                                      ActivityPostService
                                          .activityDetailList['activityTime'][2]
                                          .toString() +
                                      "日" +
                                      ActivityPostService
                                          .activityDetailList['activityTime'][3]
                                          .toString() +
                                      "點" +
                                      ActivityPostService
                                          .activityDetailList['activityTime'][4]
                                          .toString() +
                                      "分",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: GestureDetector(
                                  onTap: () => Get.to(ShowActivityLocation()),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          child: Icon(
                                        Icons.location_pin,
                                        size: 35,
                                        color: Color.fromARGB(255, 255, 77, 77),
                                      )),
                                      Text(
                                        "活動地點",
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 10),
                                child: Text(
                                  "最後審核時間：" +
                                      ActivityPostService
                                          .activityDetailList['auditTime'][0]
                                          .toString() +
                                      "年" +
                                      ActivityPostService
                                          .activityDetailList['auditTime'][1]
                                          .toString() +
                                      "月" +
                                      ActivityPostService
                                          .activityDetailList['auditTime'][2]
                                          .toString() +
                                      "日" +
                                      ActivityPostService
                                          .activityDetailList['auditTime'][3]
                                          .toString() +
                                      "點" +
                                      ActivityPostService
                                          .activityDetailList['auditTime'][4]
                                          .toString() +
                                      "分",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 165, 165, 165),
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              )),
                          ActivityPostService.activityDetailList['holder'] ==
                                  Hive.box("UidAndState").get("uid")
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 10),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 135, 110, 95),
                                          textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                          minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              40),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ),
                                        onPressed: () async {
                                          await getPostController
                                              .getActivityParticipantList();
                                          await Get.to(() =>
                                              ActivityParticipantListScreen());
                                        },
                                        child: const Text(
                                          "審核",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )))
                              : getPostController.isParticipant == true
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, top: 10),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color.fromARGB(
                                                  255, 169, 168, 168),
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            onPressed: null,
                                            child: const Text(
                                              "已報名",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )))
                                  : Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, top: 10),
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 135, 110, 95),
                                              textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                              minimumSize: Size(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.8,
                                                  40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                            ),
                                            child: const Text(
                                              "報名",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder: (context) => Padding(
                                                        padding: EdgeInsets.only(
                                                            bottom:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .viewInsets
                                                                    .bottom),
                                                        child: Container(
                                                            height: 200,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    215,
                                                                    199,
                                                                    194),
                                                            child: Center(
                                                                child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: <
                                                                        Widget>[
                                                                  Expanded(
                                                                    child: Container(
                                                                        child: Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              100,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 20, left: 20),
                                                                            child:
                                                                                TextField(
                                                                              onChanged: (value) {
                                                                                getPostController.participantContent.value = value;
                                                                              },
                                                                              controller: contentCtr,
                                                                              cursorColor: Colors.white,
                                                                              maxLines: 7,
                                                                              maxLength: 100,
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: '跟主辦方說說您想參加的理由...',
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Align(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10.0, top: 10),
                                                                                child: ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    backgroundColor: const Color.fromARGB(255, 135, 110, 95),
                                                                                    textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                                                                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                                                                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    getPostController.setUpdateParticipantData(id);
                                                                                    getPostController.participantContent.value = "";
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text(
                                                                                    "報名",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ))),
                                                                      ],
                                                                    )),
                                                                  ),
                                                                ]))),
                                                      ));
                                            }),
                                      )),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  "目前已有" +
                                      ActivityPostService
                                          .activityDetailList['participants']
                                          .toString() +
                                      '人參加',
                                  style: TextStyle(fontSize: 15),
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                child: Text(
                                  ActivityPostService
                                      .activityDetailList['content'],
                                  style: TextStyle(fontSize: 16),
                                )),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, top: 10, right: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.payment,
                                          size: 30,
                                        ),
                                        Text(
                                          "付款方式",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          getPostController.actPayment[
                                              ActivityPostService
                                                      .activityDetailList[
                                                  'payment']],
                                          style: TextStyle(fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.currency_exchange_rounded,
                                          size: 30,
                                        ),
                                        Text(
                                          "活動預算",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          ActivityPostService
                                              .activityDetailList['budget']
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.people,
                                          size: 30,
                                        ),
                                        Text(
                                          "活動類別",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          getPostController
                                              .actType[ActivityPostService
                                                  .activityDetailList['actId']]
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Obx(
                                          () => InkWell(
                                            onTap: () =>
                                                getPostController.checkLike(
                                                    Hive.box("UidAndState")
                                                        .get("uid")),
                                            child: Icon(
                                              getPostController.isLike.value
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              size: 30,
                                              // color: Color.fromARGB(255, 255, 87, 87),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "按讚活動",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        Text(
                                          ActivityPostService
                                              .activityDetailList['likes']
                                              .toString(),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}

// ignore: must_be_immutable
class _viewPostPic extends StatelessWidget {
  _viewPostPic({required this.id});
  String id;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {Get.back()},
        child: Hero(
          tag: 'pic',
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 150, bottom: 150),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: Image.network(
                        ActivityPostService.activityDetailList['url'][index])),
              );
            },
            itemCount: ActivityPostService.activityDetailList['url'].length,
          ),
        ),
      ),
    );
  }
}
