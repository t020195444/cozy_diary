import 'dart:convert';
import 'dart:ffi';

import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/Model/EditUserModel.dart';
import 'package:cozydiary/Model/PostReceiveModel.dart';
import 'package:cozydiary/pages/Personal/Service/PersonalService.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;

import '../../../../Model/PostCoverModel.dart';
import '../../../../Model/trackerListModel.dart';

class SelfPageController extends GetxController {
  //記錄自介高度
  var constraintsHeight = 0.0.obs;
  //是否有延展
  var readmore = true.obs;
  //高度差
  var difference = 0.0;
  //是否再載入
  var isLoading = true.obs;
  //使用者id
  var uid = "";
  var userData = Data(
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
      userCategoryList: []).obs;
  var postCover = <PostCoverData>[].obs;
  var box = Hive.box("UidAndState");
  var trackerList = <TrackerList>[];
  @override
  void onInit() {
    uid = box.get("uid");

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

  // void getOtherUserData(String otherUserId) async {
  //   try {
  //     isLoading(true);

  //     var UserData = await PersonalService.fetchUserData(otherUserId);
  //     if (UserData != null) {
  //       if (UserData.status == 200) {
  //         userData.value = UserData.data;
  //       }
  //     }
  //   } finally {}
  // }

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

  // void getOtherUserPostCover(String otherUserId) async {
  //   try {
  //     var Posts = await PersonalService.fetchUserPostCover(otherUserId);
  //     if (Posts != null) {
  //       if (Posts.status == 200) {
  //         postCover.value = Posts.data;
  //       }
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }
  double getWidgetHeight(GlobalKey key) {
    RenderBox renderBox = key.currentContext?.findRenderObject() as RenderBox;
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

  void getTracker() async {
    try {
      var trackerResponse = await PersonalService.getTracker(uid);

      if (trackerResponse != null) {
        if (trackerResponse.message == 200) {
          trackerList = trackerResponse.data;
        }
      }
    } finally {}
  }

  Future<String> updateUser(EditUserModel editUserModel) async {
    String updateUserJsonData = editUserModelToJson(editUserModel);
    var response = await PersonalService.updateUser(updateUserJsonData);

    if (response.status == 200) {
      getUserData();
    }
    return response.message;
  }

  Future<int> changeProfilePic(String picUrl) async {
    FormData fileFormData = FormData();
    String picName = picUrl.split("/").last;
    fileFormData.files.add(MapEntry(
        "file", await MultipartFile.fromFile(picUrl, filename: picName)));
    var response =
        await PersonalService.changeProfilePic(fileFormData, uid, picName);
    if (response.status == 200) {
      getUserData();
    }

    return response.status;
  }
}
