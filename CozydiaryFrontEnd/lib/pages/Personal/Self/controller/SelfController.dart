import 'package:cozydiary/Model/editUserModel.dart';
import 'package:cozydiary/pages/Personal/Service/personalService.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../Model/catchPersonalModel.dart';
import '../../../../Model/postCoverModel.dart';
import '../../../../Model/trackerListModel.dart';

class SelfPageController extends GetxController {
  var constraintsHeight = 0.0.obs; //記錄自介高度
  var readmore = true.obs; //是否有延展
  var difference = 0.0; //高度差
  var isLoading = true.obs; //是否再載入
  var uid = ""; //使用者id
  var userData = UserData(
      uid: 0,
      googleId: "",
      name: "",
      age: 0,
      sex: 0,
      introduction: "",
      pic: "",
      birth: [],
      createTime: [],
      email: "",
      tracker: [],
      follower: [],
      userCategoryList: []).obs; //使用者資料暫存
  var postCover = <PostCoverData>[].obs;
  var box = Hive.box("UidAndState");
  var trackerList = <TrackerList>[];
  @override
  void onInit() {
    uid = Hive.box("UidAndState").get("uid");

    getUserData();
    getUserPostCover(uid);

    super.onInit();
  }

  void getUserData() async {
    try {
      isLoading(true);

      var UserData = await PersonalService.fetchUserData(uid);
      if (UserData != null) {
        if (UserData.status == 200) {
          userData.value = UserData.data;
        }
      }
    } finally {}
  }

  void getUserPostCover(String uid) async {
    try {
      var Posts = await PersonalService.fetchUserPostCover(uid);
      if (Posts != null) {
        if (Posts.status == 200) {
          postCover.value = Posts.data;
        }
      }
    } finally {
      isLoading(false);
    }
  }

  double getWidgetHeight(GlobalKey key) {
    RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
    print(renderBox.size.height);
    return renderBox.size.height;
  }

  void getConstraintsHeight(var height) {
    constraintsHeight.value = height;
    update();
  }

  void onTabReadmore() {
    readmore.value = !readmore.value;
    print(readmore.value);
  }

  void increaseAppbarHeight() {
    constraintsHeight.value = constraintsHeight.value + difference;
  }

  void reduceAppbarHeight() {
    constraintsHeight.value = constraintsHeight.value - difference;
  }

  Future<String> updateUser(EditUserModel editUserModel) async {
    String updateUserJsonData = editUserModelToJson(editUserModel);
    var response = await PersonalService.updateUser(updateUserJsonData);

    if (response.status == 200) {
      getUserData();
    }
    return response.message;
  }
}
