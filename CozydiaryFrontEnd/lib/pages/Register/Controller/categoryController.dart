import 'dart:convert';

import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../Model/categoryList.dart';

class CategoryController extends GetxController {
  //使用者類別清單
  var categoryList = <Category>[];
  //類別照片路徑清單
  var categoryAssetsList = [];
  //最終清單
  var finalCategoryList = <int>[];
  //uid
  var uid = Hive.box("UidAndState").get("uid");
  //按鈕狀態
  var isChoice = <bool>[false, false, false, false, false];
  //load狀態
  var isLoding = false;
  //目前是哪個狀態，現在有註冊與登入狀態
  var currentState = ["註冊", "登入"];
  @override
  void onInit() {
    categoryAssetsList = [
      "assets/category/basketball_S.jpg",
      "assets/category/dressStyle_S.jpg",
      "assets/category/invest_S.jpg",
      "assets/category/anime_S.jpg",
      "assets/category/beauty_S.jpg"
    ];
    fetchCategoryList();
    fetchUserCategory();

    super.onInit();
  }

  void fetchCategoryList() async {
    try {
      isLoding = true;
      CategoryListModel response = await RegisterService.fetchCategoryList();
      if (response.status == 200) {
        if (response.data != null) {
          categoryList = response.data;
          update();
        }
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

  void addCategory() async {
    for (var id in finalCategoryList) {
      Map<String, dynamic> postJsonData = {"uid": uid, "cid": id};
      int response =
          await RegisterService.addCategory(jsonEncode(postJsonData));
      if (response == 200) {
      } else {
        print("can't post");
        break;
      }
    }
  }
}
