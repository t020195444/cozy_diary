import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/pages/Personal/Service/PersonalService.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

import '../../../Model/PostCoverModel.dart';
import '../../../Model/trackerModel.dart';

class OtherPersonPageController extends GetxController {
  var constraintsHeight = 0.0.obs;
  var readmore = true.obs;
  var difference = 0.0;
  var isLoading = true.obs;
  var otherUid = "";
  var checkedUid = "";
  var isFollow = false.obs;
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
    checkedUid = Hive.box("UidAndState").get("uid");
    super.onInit();
  }

  void getOtherUserData() async {
    try {
      isLoading(true);
      var UserData = await PersonalService.fetchUserData(otherUid);
      if (UserData != null) {
        if (UserData.status == 200) {
          userData.value = UserData.data;
          for (var followers in userData.value.follower) {
            if (followers == checkedUid) {
              isFollow.value = true;
            } else {
              isFollow.value = false;
            }
          }
        }
      }
    } finally {}
  }

  void getUserPostCover() async {
    try {
      var Posts = await PersonalService.fetchUserPostCover(otherUid);
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

  void addTracker() async {
    try {
      AddTrackerModel trackerModel =
          AddTrackerModel(tracker1: checkedUid, tracker2: otherUid);

      var jsonData = addTrackerModelToJson(trackerModel);
      var response = await PersonalService.addTracker(jsonData);
      if (response.toString() == "新增追蹤成功") isFollow.value = true;
    } finally {}
  }

  void deleteTracker() async {
    try {
      var response = await PersonalService.deleteTracker("30");
      isFollow.value = false;
      print(response);
    } finally {}
  }
}
