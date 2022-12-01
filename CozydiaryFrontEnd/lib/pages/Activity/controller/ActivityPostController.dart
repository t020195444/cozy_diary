import 'dart:convert';
import 'dart:io';
import 'package:cozydiary/Model/WriteActivityPostModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:hive/hive.dart';
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
  RxString activityTime = "".obs;
  RxString activityTimeview = "".obs;
  RxString activityDeadlineTime = "".obs;
  RxString activityDeadlineTimeview = "".obs;
  RxDouble activityLat = 0.0.obs;
  RxDouble activityLng = 0.0.obs;
  RxString activityLocation = "".obs;
  RxInt activityPeople = 2.obs;
  RxInt activityPayment = 0.obs;
  RxInt activitybudget = 0.obs;
  RxInt actId = 1.obs;
  int currentPage = 0;
  RxBool isPicked = false.obs;
  RxInt selectActType = 1.obs;
  RxInt selectActPayment = 1.obs;

  RxBool checkActivitySetting = false.obs;

  selectActPaymentPuls(value) {
    if (selectActPayment.value != actPayment.length) {
      selectActPayment.value = selectActPayment.value + 1;
      value = selectActPayment.value;
    } else {
      selectActPayment.value = 1;
      value = selectActPayment.value;
    }
    update();
  }

  selectActPaymentSubtractions(value) {
    if (selectActPayment.value != 1) {
      selectActPayment.value = selectActPayment.value - 1;
      value = selectActPayment.value;
    } else {
      selectActPayment.value = actPayment.length;
      value = selectActPayment.value;
    }
    update();
  }

  selectActTypePuls(value) {
    if (selectActType.value != actType.length) {
      selectActType.value = selectActType.value + 1;
      value = selectActType.value;
    } else {
      selectActType.value = 1;
      value = selectActType.value;
    }
    update();
  }

  selectActTypeSubtractions(value) {
    if (selectActType.value != 1) {
      selectActType.value = selectActType.value - 1;
      value = selectActType.value;
    } else {
      selectActType.value = actType.length;
      value = selectActType.value;
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
    activityLat.value = value.geometry!.location!.lat;
    activityLng.value = value.geometry!.location!.lng;

    update();
  }

  static late List<RxBool> checkBox =
      List.generate(mediaList.length, (_) => false.obs);

  //function
  static List fileList = [].obs;
  static RxList mediaList = [].obs;
  RxBool isLoading = false.obs;

  fetchMedia() async {
    isLoading(true);
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
    isLoading.value = false;
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
  var activityFiles = <ActivityPostFile>[];
  List allPicName = [];

  goToDataBase() async {
    checkBox = [];
    checkBox = List.generate(
        ActivityPostController.mediaList.length, (_) => false.obs);

    var formdata = await writePost();
    await ActivityPostService.postPostData(await formdata);
  }

  void setPost() {
    postsActivityContext = Activity(
      holder: Hive.box("UidAndState").get("uid"),
      placeLng: activityLng.value.toDouble(),
      placeLat: activityLat.value.toDouble(),
      likes: 0,
      activityName: activityTitle.value.toString(),
      cover: basename(pickedList[0].path),
      activityTime: activityTime.value,
      auditTime: activityDeadlineTime.value,
      payment: selectActPayment.value.toInt(),
      budget: activitybudget.value.toInt(),
      content: activityContent.value.toString(),
      actId: selectActType.value.toInt(),
    );
  }

  Future<FormData> writePost() async {
    FormData formData = FormData();
    setPost();

    WriteActivityPostModel writePost =
        WriteActivityPostModel(activity: postsActivityContext);
    var jsonString = jsonEncode(writePost.toJson());

    formData = FormData.fromMap({"jsondata": jsonString});
    for (int i = 0; i < pickedList.length; i++) {
      formData.files.addAll(
          [MapEntry("file", await MultipartFile.fromFile(pickedList[i].path))]);
    }
    return formData;
  }
}
