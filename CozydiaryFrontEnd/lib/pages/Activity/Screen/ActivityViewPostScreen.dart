import 'package:cozydiary/pages/Activity/Map/ShowActivityLocation.dart';
import 'package:cozydiary/pages/Activity/Screen/ActivityParticipantListScreen.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityGetPostController.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class ActivityViewPostScreen extends StatelessWidget {
  //Controller
  final commentCtr = TextEditingController();

  ActivityGetPostController getPostController =
      Get.put(ActivityGetPostController());

  @override
  Widget build(BuildContext context) {
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
          title: Obx(
            () => Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 45,
                  width: 45,
                  margin: const EdgeInsets.fromLTRB(2, 20, 5, 15),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: getPostController.isLoding.value
                            ? AssetImage(
                                    'CozydiaryFrontEnd/assets/images/Black.png')
                                as ImageProvider
                            : NetworkImage(
                                getPostController.userData.value.pic,
                              )),
                    border: Border.all(color: Colors.white, width: 2.5),
                    shape: BoxShape.circle,
                  ),
                ),
                Text(
                  getPostController.userData.value.name,
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => _viewPostPic());
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Hero(
                        tag: 'pic',
                        child: Image.network(
                          ActivityPostService.activityDetailList['url'][0]!,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        )),
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
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
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
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
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
                        padding: const EdgeInsets.only(left: 10.0, top: 10),
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
                  getPostController.activityHolder ==
                          Hive.box("UidAndState").get("uid")
                      ? Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10.0, top: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 135, 110, 95),
                                  textStyle: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                onPressed: () async {
                                  await getPostController
                                      .getActivityParticipantList();
                                  await Get.to(
                                      () => ActivityParticipantListScreen());
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
                                      backgroundColor:
                                          Color.fromARGB(255, 169, 168, 168),
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    onPressed: null,
                                    child: const Text(
                                      "已報名",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )))
                          : Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10.0, top: 10),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 135, 110, 95),
                                      textStyle: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                          40),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                    ),
                                    child: const Text(
                                      "報名",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => Padding(
                                                padding: EdgeInsets.only(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                            .viewInsets
                                                            .bottom),
                                                child: Container(
                                                    height: 200,
                                                    color: Color.fromARGB(
                                                        255, 215, 199, 194),
                                                    child: Center(
                                                        child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                          Expanded(
                                                            child: Container(
                                                                child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 100,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            20,
                                                                        left:
                                                                            20),
                                                                    child:
                                                                        TextField(
                                                                      onChanged:
                                                                          (value) {
                                                                        getPostController
                                                                            .participantContent
                                                                            .value = value;
                                                                      },
                                                                      controller:
                                                                          contentCtr,
                                                                      cursorColor:
                                                                          Colors
                                                                              .white,
                                                                      maxLines:
                                                                          7,
                                                                      maxLength:
                                                                          100,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            InputBorder.none,
                                                                        hintText:
                                                                            '跟主辦方說說您想參加的理由...',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Padding(
                                                                        padding: const EdgeInsets.only(left: 10.0, top: 10),
                                                                        child: ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor: const Color.fromARGB(
                                                                                255,
                                                                                135,
                                                                                110,
                                                                                95),
                                                                            textStyle:
                                                                                const TextStyle(color: Colors.white, fontSize: 16),
                                                                            minimumSize:
                                                                                Size(MediaQuery.of(context).size.width * 0.8, 40),
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            getPostController.setUpdateParticipantData();
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            "報名",
                                                                            style:
                                                                                TextStyle(color: Colors.white),
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
                              getPostController.activityPeople.toString() +
                              // getPostController.activityPeople.value
                              //     .toString() +
                              '人參加',
                          style: TextStyle(fontSize: 15),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          ActivityPostService.activityDetailList['content'],
                          style: TextStyle(fontSize: 16),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 10, right: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.payment,
                                  size: 40,
                                ),
                                Text(
                                  "付款方式",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  getPostController.actPayment[
                                      getPostController.selectActPayment.value],
                                  style: TextStyle(fontSize: 15),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.currency_exchange_rounded,
                                  size: 40,
                                ),
                                Text(
                                  "活動預算",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  getPostController.activitybudget.value
                                      .toString(),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 40,
                                ),
                                Text(
                                  "活動人數",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  "10",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Obx(
                                  () => InkWell(
                                    onTap: () => getPostController.isLike.value
                                        ? getPostController.checkLike(
                                            Hive.box("UidAndState").get("uid"))
                                        : getPostController.checkLike(
                                            Hive.box("UidAndState").get("uid")),
                                    child: Icon(
                                      getPostController.isLike.value
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 40,
                                      // color: Color.fromARGB(255, 255, 87, 87),
                                    ),
                                  ),
                                ),
                                Text(
                                  "按讚活動",
                                  style: TextStyle(fontSize: 13),
                                ),
                                Obx(
                                  () => Text(
                                    getPostController.activityLike.value
                                        .toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                )
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
      ),
    );
  }
}

class _viewPostPic extends StatelessWidget {
  const _viewPostPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {Get.to(ActivityViewPostScreen())},
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