import 'dart:convert';
import 'dart:io';
import 'package:cozydiary/Model/WriteActivityPostModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:photo_manager/photo_manager.dart';
import 'package:dio/dio.dart';

class ActivityPostController extends GetxController {
  var loginController = Get.put(LoginController());
  //variable
  RxString activityTitle = "".obs;
  RxString activityContent = "".obs;
  RxString activityTime = DateTime.now().toString().obs;
  RxString activityDeadlineTime = DateTime.now().toString().obs;
  RxDouble activityLat = 0.0.obs;
  RxDouble activityLng = 0.0.obs;
  RxString activityLocation = "".obs;
  RxInt activityPeople = 2.obs;
  RxInt activityPayment = 0.obs;
  RxInt activitybudget = 0.obs;
  RxInt actId = 0.obs;
  int currentPage = 0;
  RxBool isPicked = false.obs;
  RxInt selectActType = 1.obs;
  RxInt selectActPayment = 1.obs;

  selectActPaymentPuls() {
    if (selectActPayment.value != actPayment.length) {
      selectActPayment.value = selectActPayment.value + 1;
    } else {
      selectActPayment.value = 1;
    }
    update();
  }

  selectActPaymentSubtractions() {
    if (selectActPayment.value != 1) {
      selectActPayment.value = selectActPayment.value - 1;
    } else {
      selectActPayment.value = actPayment.length;
    }
    update();
  }

  selectActTypePuls() {
    if (selectActType.value != actType.length) {
      selectActType.value = selectActType.value + 1;
    } else {
      selectActType.value = 1;
    }
    update();
  }

  selectActTypeSubtractions() {
    if (selectActType.value != 1) {
      selectActType.value = selectActType.value - 1;
    } else {
      selectActType.value = actType.length;
    }
    update();
  }

  Map actType = {
    1: "旅遊",
    2: "收藏",
    3: "社交",
    4: "戶外",
    5: "運動",
    6: "創作",
    7: "娛樂",
    8: "服務",
  };
  Map actPayment = {
    1: "我來請客",
    2: "你來買單",
    3: "各付各的",
    4: "平均分攤",
  };

  updateActivityLocation(value) {
    activityLocation.value = value.formattedAddress!.toString();
    activityLat.value = double.parse(value.geometry!.location!.lat);
    activityLng.value = double.parse(value.geometry!.location!.lng);

    update();
  }

  static late List<RxBool> checkBox =
      List.generate(mediaList.length, (_) => false.obs);

  //function
  static List fileList = [].obs;
  static RxList mediaList = [].obs;
  fetchMedia() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      List media =
          await albums[0].getAssetListPaged(size: 60, page: currentPage);

      mediaList.value = [];
      List<Widget> temp = [];
      for (var asset in media) {
        fileList.add(await asset.file);
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(ThumbnailSize(800, 800)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (asset.type == AssetType.video)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              return Container();
            },
          ),
        );
      }
      //設置顯示照片List
      mediaList.addAll(temp);
      //default Pic
      currPic.add(mediaList[0]);
    } else {}
  }

  RxList currPic = [].obs;
  changeCurrPic(int i) {
    //設置目前顯示照片
    currPic.value = [];
    currPic.add(mediaList[i]);

    setPicList(i);
  }

  static List pickedList = [];
  setPicList(int i) {
    File tempFile = fileList[i];
    if (pickedList.contains(tempFile)) {
      pickedList.remove(tempFile);
      checkBox[i].value = false;
    } else {
      pickedList.add(tempFile);
      checkBox[i].value = true;
    }
  }

  //create post
  late Post postsContext;
  late Activity postsActivityContext;
  var postFiles = <ActivityPostFile>[];
  List allPicName = [];

  void goToDataBase() async {
    var formdata = writePost();
    print(await formdata.toString());
    await ActivityPostService.postPostData(await formdata);
  }

  void setPost() {
    postsActivityContext = Activity(
      holder: loginController.id,
      placeLng: activityLat.value,
      placeLat: activityLng.value,
      likes: 0,
      activityName: activityTitle.value,
      cover: basename(pickedList[0].path),
      activityTime: activityTime.value,
      auditTime: DateTime.now().toString(),
      payment: activityPayment.value,
      budget: activitybudget.value,
      content: activityContent.value,
      actId: actId.value,
    );
  }

  Future<FormData> writePost() async {
    print(pickedList);

    print("-------");

    FormData formData = FormData();
    // int index = 1;
    for (int i = 0; i < pickedList.length; i++) {
      allPicName.add(basename(pickedList[i].path));
    }
    print(allPicName);

    allPicName.asMap().forEach((key, value) async {
      postFiles.add(ActivityPostFile(postUrl: value));
    });

    setPost();

    WriteActivityPostModel writePost =
        WriteActivityPostModel(activity: postsActivityContext);
    var jsonString = jsonEncode(writePost.toJson());
    formData = FormData.fromMap({"jsondata": jsonString});
    print(formData);
    for (int i = 0; i < pickedList.length; i++) {
      formData.files.addAll(
          [MapEntry("file", await MultipartFile.fromFile(pickedList[i].path))]);
    }
    return formData;
  }
}
