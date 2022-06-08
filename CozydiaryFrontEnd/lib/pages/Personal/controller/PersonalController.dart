import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/pages/Personal/Service/PersonalService.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;

import '../../../Model/PostCoverModel.dart';

class PersonalPageController extends GetxController {
  var constraintsHeight = 0.0.obs;
  var readmore = true.obs;
  var difference = 0.0;
  var isLoading = true.obs;
  var googleId = "";
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
  @override
  void onInit() {
    firebaseauth.FirebaseAuth.instance
        .authStateChanges()
        .listen((firebaseauth.User? user) {
      googleId = user!.providerData[0].uid!;
    });
    getUserData();
    // getUserPostCover();
    // if (userData.value.introduction == "") {
    //   constraintsHeight.value = 18;
    // }
    super.onInit();
  }

  void getUserData() async {
    try {
      isLoading(true);
      var UserData = await PersonalService.fetchUserData(googleId);
      if (UserData != null) {
        if (UserData.status == 200) {
          userData.value = UserData.data;
        }
      }
    } finally {}
  }

  void getUserPostCover() async {
    try {
      var Posts = await PersonalService.fetchUserPostCover(googleId);
      if (Posts != null) {
        if (Posts.status == 200) {
          postCover.value = Posts.data;
        }
      }
    } finally {
      isLoading(false);
    }
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
}
