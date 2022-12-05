import 'dart:io';

import 'package:cozydiary/pages/Activity/Post/ActivityLocationSearch.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

var peopleList = [for (var i = 1; i <= 30; i++) Text(i.toString())];
var priceList = [for (var i = 0; i <= 50; i++) Text((i * 50).toString())];

class ActivityArticlePage extends StatelessWidget {
  const ActivityArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final ActivityPostController postController =
        Get.put(ActivityPostController());
    final titleCtr = TextEditingController(
        text: postController.activityTitle.value.toString());
    final contentCtr = TextEditingController(
        text: postController.activityContent.value.toString());

    postController.onInit();

    //輸入活動時間
    Widget ActivityTime() {
      return Obx(
        () => ListTile(
          title: Text(
            "選擇活動時間",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          dense: true,
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: postController.activityTime.value != '' &&
                          postController.activityDeadlineTime.value != ''
                      ? Colors.green
                      : Color.fromARGB(255, 237, 187, 196),
                  width: 2),
              borderRadius: BorderRadius.circular(30)),
          onTap: () async {
            showModalBottomSheet(
                backgroundColor: Theme.of(context).backgroundColor,
                isScrollControlled: true,
                context: context,
                builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                          height: 200,
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
                                      Container(child: Text("活動時間")),
                                      Container(
                                          padding: EdgeInsets.only(top: 20),
                                          child: Text("活動審核時間時間")),
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
                                      SizedBox(
                                        width: 180,
                                        height: 30,
                                        child: Obx(() => OutlinedButton(
                                              child: Text(postController
                                                  .activityTimeview.value),
                                              onPressed: () async {
                                                DateTime? newDateTime = await DatePicker.showDateTimePicker(
                                                    context,
                                                    theme: DatePickerTheme(
                                                        headerColor:
                                                            Theme.of(context)
                                                                .backgroundColor,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .backgroundColor,
                                                        itemStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18)),
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    maxTime: DateTime(
                                                        2023, 12, 31, 00, 00),
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.zh);
                                                if (newDateTime == null) return;

                                                postController.activityTime
                                                    .value = DateFormat(
                                                        'yyyy-MM-ddTHH:mm:ss.000')
                                                    .format(newDateTime);
                                                String formattedDate =
                                                    DateFormat(
                                                            'yyyy-MM-dd – HH:mm')
                                                        .format(newDateTime);
                                                postController.activityTimeview
                                                        .value =
                                                    formattedDate.toString();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                fixedSize: Size(195, 25),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            )),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 20),
                                        width: 180,
                                        height: 30,
                                        child: Obx(() => OutlinedButton(
                                              child: Text(postController
                                                  .activityDeadlineTimeview
                                                  .value),
                                              onPressed: () async {
                                                DateTime? newDateTime = await DatePicker.showDateTimePicker(
                                                    context,
                                                    theme: DatePickerTheme(
                                                        headerColor:
                                                            Theme.of(context)
                                                                .backgroundColor,
                                                        backgroundColor:
                                                            Theme.of(context)
                                                                .backgroundColor,
                                                        itemStyle: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18)),
                                                    showTitleActions: true,
                                                    minTime: DateTime.now(),
                                                    maxTime: DateTime(
                                                        2023, 12, 31, 00, 00),
                                                    onChanged: (date) {},
                                                    currentTime: DateTime.now(),
                                                    locale: LocaleType.zh);
                                                if (newDateTime == null) return;
                                                postController
                                                    .activityDeadlineTime
                                                    .value = DateFormat(
                                                        'yyyy-MM-ddTHH:mm:ss.000')
                                                    .format(newDateTime);
                                                String formattedDate =
                                                    DateFormat(
                                                            'yyyy-MM-dd - HH:mm')
                                                        .format(newDateTime);
                                                postController
                                                        .activityDeadlineTimeview
                                                        .value =
                                                    formattedDate.toString();
                                              },
                                              style: OutlinedButton.styleFrom(
                                                fixedSize: Size(195, 25),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(15)),
                                                ),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            )),
                                      ),
                                    ],
                                  )),
                                ),
                              )
                            ],
                          ))),
                    ));
          },
        ),
      );
    }

    //輸入活動設定
    Widget ActivitySetting() {
      return Obx(
        () => ListTile(
          title: Text(
            "詳細活動設定",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          dense: true,
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: postController.checkActivitySetting.value == true
                      ? Colors.green
                      : Color.fromARGB(255, 237, 187, 196),
                  width: 2),
              borderRadius: BorderRadius.circular(30)),
          onTap: () async {
            postController.checkActivitySetting.value = true;
            showModalBottomSheet(
                backgroundColor: Theme.of(context).backgroundColor,
                isScrollControlled: true,
                context: context,
                builder: (context) => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                          height: 200,
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
                                      //活動人數
                                      Container(
                                          width: 100,
                                          height: 25,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              showCupertinoModalPopup(
                                                  context: context,
                                                  barrierColor:
                                                      CupertinoDynamicColor
                                                          .resolve(
                                                              Theme.of(context)
                                                                  .backgroundColor,
                                                              context),
                                                  builder: (_) => SizedBox(
                                                        width: double.infinity,
                                                        height: 200,
                                                        child: CupertinoPicker(
                                                          itemExtent: 30,
                                                          scrollController:
                                                              FixedExtentScrollController(
                                                            initialItem: 0,
                                                          ),
                                                          onSelectedItemChanged:
                                                              (int value) {
                                                            postController
                                                                .activityPeople
                                                                .value = value + 1;
                                                          },
                                                          children: peopleList,
                                                        ),
                                                      ));
                                            },
                                            child: Obx(
                                              () => Text(
                                                postController
                                                    .activityPeople.value
                                                    .toString(),
                                              ),
                                            ),
                                          )),
                                      //活動類別
                                      Obx((() => Container(
                                          margin: EdgeInsets.only(top: 15),
                                          padding: EdgeInsets.only(left: 60),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () => postController
                                                    .selectActTypeSubtractions(
                                                        postController.actId),
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
                                                    .selectActTypePuls(
                                                        postController.actId),
                                                child: Icon(
                                                  Icons.arrow_right,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ],
                                          )))),
                                      //活動支付方式
                                      Obx(
                                        () => Container(
                                            margin: EdgeInsets.only(top: 20),
                                            padding: EdgeInsets.only(left: 45),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () => postController
                                                      .selectActPaymentSubtractions(
                                                          postController
                                                              .actPayment),
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
                                                      .selectActPaymentPuls(
                                                          postController
                                                              .actPayment),
                                                  child: Icon(
                                                    Icons.arrow_right,
                                                    size: 24.0,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),

                                      //活動預算
                                      Container(
                                          margin: EdgeInsets.only(top: 20),
                                          width: 100,
                                          height: 25,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              showCupertinoModalPopup(
                                                  context: context,
                                                  barrierColor:
                                                      CupertinoDynamicColor
                                                          .resolve(
                                                              Theme.of(context)
                                                                  .backgroundColor,
                                                              context),
                                                  builder: (_) => SizedBox(
                                                        width: double.infinity,
                                                        height: 200,
                                                        child: CupertinoPicker(
                                                          itemExtent: 30,
                                                          scrollController:
                                                              FixedExtentScrollController(
                                                            initialItem: 0,
                                                          ),
                                                          onSelectedItemChanged:
                                                              (int value) {
                                                            postController
                                                                    .activitybudget
                                                                    .value =
                                                                (value) * 50;
                                                          },
                                                          children: priceList,
                                                        ),
                                                      ));
                                            },
                                            child: Obx(
                                              () => Text(
                                                postController
                                                    .activitybudget.value
                                                    .toString(),
                                              ),
                                            ),
                                          )),
                                    ],
                                  )),
                                ),
                              )
                            ],
                          ))),
                    ));
          },
        ),
      );
    }

    //活動地點
    Widget ActivityLocation() {
      return
          // Obx(
          //   () =>
          ListTile(
        title: postController.activityLocation.value == ""
            ? Text(
                "選擇活動地點",
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            : Text(
                postController.activityLocation.value,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
        dense: true,
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: postController.activityLocation.value != ''
                    ? Colors.green
                    : Color.fromARGB(255, 237, 187, 196),
                width: 2),
            borderRadius: BorderRadius.circular(30)),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        // ),
      );
    }

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text('最後一步'),
          actions: [
            TextButton(
                onPressed: () async {
                  await postController.checkData();

                  await postController.checkActivity.value
                      ? postController.goToDataBase()
                      : null;
                  await postController.checkActivity.value
                      ? showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                title: const Text('發布中...'),
                                content: Container(
                                    height: 150,
                                    width: 30,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              ))
                      : null;
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '發布',
                    // style: Theme.of(context).textTheme.labelLarge,
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
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width * 1.05,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                                File(ActivityPostController.pickedList[0])),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: TextField(
                    onChanged: (value) {
                      postController.activityTitle.value = value;
                    },
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
                    onChanged: (value) {
                      postController.activityContent.value = value;
                    },
                    controller: contentCtr,
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
      ),
    );
  }
}
