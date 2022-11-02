import 'package:cozydiary/pages/Activity/ActivityLocationSearch.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:flutter_picker/flutter_picker.dart';

class ActivityArticlePage extends StatelessWidget {
  const ActivityArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final ActivityPostController postController =
        Get.put(ActivityPostController());
    final titleCtr = TextEditingController();
    final contentCtr = TextEditingController();
    final maxPeopleCtr = TextEditingController(
        text: postController.activityPeople.value.toString());
    final budgetCtr = TextEditingController(
        text: postController.activitybudget.value.toString());
    final activityTimeCtr =
        TextEditingController(text: postController.activityTime.value);
    final activityDeadlineTimeCtr =
        TextEditingController(text: postController.activityDeadlineTime.value);

    postController.onInit();

    //輸入活動時間
    Widget ActivityTime() {
      return ListTile(
        title: Text(
          "選擇活動時間",
          style: TextStyle(
            color: Color.fromARGB(150, 0, 0, 0),
            fontSize: 14,
          ),
        ),
        dense: true,
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
            borderRadius: BorderRadius.circular(30)),
        tileColor: Colors.white,
        onTap: () async {
          // showModalBottomSheet(
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (context) => Padding(
          //           padding: EdgeInsets.only(
          //               bottom: MediaQuery.of(context).viewInsets.bottom),
          //           child: Container(
          //               height: 200,
          //               color: Color.fromARGB(255, 215, 199, 194),
          //               child: Center(
          //                   child: Row(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: <Widget>[
          //                   Expanded(
          //                     child: Center(
          //                       child: Container(
          //                           child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           Container(child: Text("活動開始時間")),
          //                           Container(
          //                               padding: EdgeInsets.only(top: 20),
          //                               child: Text("活動結束時間")),
          //                         ],
          //                       )),
          //                     ),
          //                   ),
          //                   Expanded(
          //                     child: Center(
          //                       child: Container(
          //                           child: Column(
          //                         mainAxisSize: MainAxisSize.min,
          //                         children: [
          //                           Obx(() => OutlinedButton(
          //                                 child: Text(postController
          //                                     .activityTime.value),
          //                                 onPressed: () async {
          //                                   DateTime? newDateTime =
          //                                       await DatePicker
          //                                           .showDateTimePicker(
          //                                               context,
          //                                               showTitleActions: true,
          //                                               minTime: DateTime.now(),
          //                                               maxTime:
          //                                                   DateTime(
          //                                                       2023,
          //                                                       12,
          //                                                       31,
          //                                                       00,
          //                                                       00), onChanged:
          //                                                   (date) {
          //                                     print('change $date');
          //                                   }, onConfirm: (date) {
          //                                     print('confirm $date');
          //                                   },
          //                                               currentTime:
          //                                                   DateTime.now(),
          //                                               locale: LocaleType.en);
          //                                   if (newDateTime == null) return;
          //                                   postController.activityTime.value =
          //                                       newDateTime.toString();
          //                                 },
          //                                 style: OutlinedButton.styleFrom(
          //                                   fixedSize: Size(195, 25),
          //                                   backgroundColor: Colors.white,
          //                                   foregroundColor: Colors.black,
          //                                   shape: RoundedRectangleBorder(
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(15)),
          //                                   ),
          //                                   side: BorderSide(
          //                                       width: 1,
          //                                       color: Colors.black54),
          //                                 ),
          //                               )),
          //                           Obx(() => OutlinedButton(
          //                                 child: Text(postController
          //                                     .activityDeadlineTime.value),
          //                                 onPressed: () async {
          //                                   DateTime? newDateTime =
          //                                       await DatePicker
          //                                           .showDateTimePicker(
          //                                               context,
          //                                               showTitleActions: true,
          //                                               minTime: DateTime.now(),
          //                                               maxTime:
          //                                                   DateTime(
          //                                                       2023,
          //                                                       12,
          //                                                       31,
          //                                                       00,
          //                                                       00), onChanged:
          //                                                   (date) {
          //                                     print('change $date');
          //                                   }, onConfirm: (date) {
          //                                     print('confirm $date');
          //                                   },
          //                                               currentTime:
          //                                                   DateTime.now(),
          //                                               locale: LocaleType.en);
          //                                   if (newDateTime == null) return;
          //                                   postController.activityDeadlineTime
          //                                       .value = newDateTime.toString();
          //                                 },
          //                                 style: OutlinedButton.styleFrom(
          //                                   fixedSize: Size(195, 25),
          //                                   backgroundColor: Colors.white,
          //                                   foregroundColor: Colors.black,
          //                                   shape: RoundedRectangleBorder(
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(15)),
          //                                   ),
          //                                   side: BorderSide(
          //                                       width: 1,
          //                                       color: Colors.black54),
          //                                 ),
          //                               )),
          //                         ],
          //                       )),
          //                     ),
          //                   )
          //                 ],
          //               ))),
          //         ));
        },
      );
    }

    //輸入活動設定
    Widget ActivitySetting() {
      return ListTile(
        title: Text(
          "詳細活動設定",
          style: TextStyle(
            color: Color.fromARGB(150, 0, 0, 0),
            fontSize: 14,
          ),
        ),
        dense: true,
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
            borderRadius: BorderRadius.circular(30)),
        tileColor: Colors.white,
        onTap: () async {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                        height: 200,
                        color: Color.fromARGB(255, 215, 199, 194),
                        child: Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Container(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(child: Text("活動人數")),
                                    Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("活動類型")),
                                    Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("活動付費方式")),
                                    Container(
                                        padding: EdgeInsets.only(top: 20),
                                        child: Text("活動費用")),
                                  ],
                                )),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Container(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 25,
                                      child: TextField(
                                        controller: maxPeopleCtr,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Only numbers can be entered
                                      ),
                                    ),
                                    Obx((() => Container(
                                        margin: EdgeInsets.only(top: 15),
                                        padding: EdgeInsets.only(left: 60),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () => postController
                                                  .selectActTypeSubtractions(),
                                              child: Icon(
                                                Icons.arrow_left,
                                                size: 24.0,
                                              ),
                                            ),
                                            Text(postController.actType[
                                                postController
                                                    .selectActType.value]),
                                            InkWell(
                                              onTap: () => postController
                                                  .selectActTypePuls(),
                                              child: Icon(
                                                Icons.arrow_right,
                                                size: 24.0,
                                              ),
                                            ),
                                          ],
                                        )))),
                                    Obx(
                                      () => Container(
                                          margin: EdgeInsets.only(top: 20),
                                          padding: EdgeInsets.only(left: 45),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () => postController
                                                    .selectActPaymentSubtractions(),
                                                child: Icon(
                                                  Icons.arrow_left,
                                                  size: 24.0,
                                                ),
                                              ),
                                              Text(postController.actPayment[
                                                  postController
                                                      .selectActPayment]),
                                              InkWell(
                                                onTap: () => postController
                                                    .selectActPaymentPuls(),
                                                child: Icon(
                                                  Icons.arrow_right,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                    Container(
                                      width: 100,
                                      height: 25,
                                      margin: EdgeInsets.only(top: 20),
                                      child: TextField(
                                        controller: budgetCtr,
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ], // Only numbers can be entered
                                      ),
                                    ),
                                  ],
                                )),
                              ),
                            )
                          ],
                        ))),
                  ));
        },
      );
    }

    //活動地點
    Widget ActivityLocation() {
      return ListTile(
        title: postController.activityLocation.value == ""
            ? Text(
                "選擇活動地點",
                style: TextStyle(
                  color: Color.fromARGB(150, 0, 0, 0),
                  fontSize: 14,
                ),
              )
            : Text(
                postController.activityLocation.value,
                style: TextStyle(
                  color: Color.fromARGB(150, 0, 0, 0),
                  fontSize: 14,
                ),
              ),
        dense: true,
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        shape: RoundedRectangleBorder(
            side:
                const BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
            borderRadius: BorderRadius.circular(30)),
        tileColor: Colors.white,
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                postController.goToDataBase();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '發布',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                height: 100,
                width: 100,
                child: GestureDetector(
                  onTap: () {
                    // Get.to(_viewPostPic());
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Hero(
                          tag: 'pic',
                          child: Image.file(
                            ActivityPostController.pickedList[0],
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                )),
            Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextField(
                  controller: titleCtr,
                  maxLines: 1,
                  maxLength: 15,
                  decoration: InputDecoration(
                    hintText: '請輸入活動名稱...',
                  ),
                ),
              ),
            ),
            Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextField(
                  controller: contentCtr,
                  cursorColor: Colors.red,
                  maxLines: 7,
                  maxLength: 150,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '請輸入活動內容...',
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ActivityTime(),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: ActivitySetting(),
            ),
            Obx(
              (() => Container(
                    padding: EdgeInsets.all(10),
                    child: ActivityLocation(),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
