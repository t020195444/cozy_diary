import 'package:cozydiary/Model/postCategoryModel.dart';
import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../Model/categoryList.dart';

class CategoryController extends GetxController {
  CategoryController({required this.registState});
  //使用者類別清單
  var categoryList = <Category>[];
  //類別照片路徑清單
  var categoryAssetsList = [];
  //最終清單
  var finalCategoryList = <int>[];
  //uid
  var uid = Hive.box("UidAndState").get("uid");
  //按鈕狀態
  var isChoice = <bool>[];
  //註冊(false)與已登入狀態(true)
  final bool registState;
  //load狀態
  var isLoding = false;

  @override
  void onInit() {
    isChoice = <bool>[
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    categoryAssetsList = [
      "assets/category/basketball_S.jpg",
      "assets/category/dressStyle_S.jpg",
      "assets/category/invest_S.jpg",
      "assets/category/anime_S.jpg",
      "assets/category/beauty_S.jpg",
      "assets/category/memes.jpg",
      "assets/category/scenery.jpg",
      "assets/category/travel.jpg",
      "assets/category/workout.jpg",
      "assets/category/pets.jpg",
      "assets/category/cars.jpg",
      "assets/category/photography.jpg",
      "assets/category/game.jpg",
    ];

    fetchCategoryList();
    if (registState) {
      fetchUserCategory();
    }

    super.onInit();
  }

  void fetchCategoryList() async {
    try {
      isLoding = true;
      CategoryListModel response = await RegisterService.fetchCategoryList();
      if (response.status == 200) {
        categoryList = response.data;
        update();
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  void fetchUserCategory() async {
    try {
      CategoryListModel response =
          await RegisterService.fetchUserCategoryList(uid);
      if (response.status == 200) {
        if (response.data != null && response.data != []) {
          response.data.forEach((element) {
            finalCategoryList.add(element.cid);
          });
          finalCategoryList.forEach((index) {
            isChoice[index - 1] = true;
          });
          update();
        }
      }
    } catch (e) {
      print(e);
    } finally {
      isLoding = false;
    }
  }

  void tabCategory(int index) {
    var choiceId = categoryList[index].cid;
    if (finalCategoryList.contains(choiceId)) {
      isChoice[index] = false;
      finalCategoryList.remove(choiceId);
    } else {
      isChoice[index] = true;
      finalCategoryList.add(choiceId);
    }
    update();
    print(finalCategoryList);
  }

  Future<int> addUserCategory() async {
    int deleteResponse = await RegisterService.deleteCategory(uid);
    if (deleteResponse == 200) {
      List<UserCategory> userCategoryList = <UserCategory>[];
      for (var id in finalCategoryList) {
        Map<String, dynamic> postJsonData = {"uid": uid, "cid": id};
        userCategoryList.add(UserCategory.fromJson(postJsonData));
      }
      PostCategoryModel postCategoryModel =
          PostCategoryModel(userCategory: userCategoryList);
      String postJsonDataList = postCategoryModelToJson(postCategoryModel);
      int addResponse = await RegisterService.addCategory(postJsonDataList);
      if (addResponse == 200) {
        return addResponse;
      } else {
        Get.showSnackbar(GetSnackBar(
          icon: Icon(
            Icons.close,
            color: Colors.red,
          ),
          message: "can't addCategory",
          duration: const Duration(seconds: 3),
        ));
        return addResponse;
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        icon: Icon(
          Icons.close,
          color: Colors.red,
        ),
        message: "can't deleteCategory",
        duration: const Duration(seconds: 3),
      ));
      return deleteResponse;
    }
  }
}
