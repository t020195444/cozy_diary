import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/pages/Personal/Service/PersonalService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;

import '../../../../Model/PostCoverModel.dart';

class SelfPageController extends GetxController {
  var constraintsHeight = 0.0.obs;
  var readmore = true.obs;
  var difference = 0.0;
  var isLoading = true.obs;
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
  @override
  void onInit() {
    uid = box.get("uid");
    getUserData(uid);
    getUserPostCover(uid);

    super.onInit();
  }

  void getUserData(String uid) async {
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
}
