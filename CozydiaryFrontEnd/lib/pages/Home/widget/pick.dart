import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class pickController extends GetxController {
  final RxInt index = 0.obs; //抓取圖片index(type是FutureBuilder<Uint8List?>)
  List media = [].obs; //抓取圖片(type是FutureBuilder<Uint8List?>)
  RxBool isPick = false.obs; //判斷是否選取圖片，並顯示在最上面的container

  bool checkPressed = true; //單選多選判斷(用來開啟/關閉單選多選)
  RxBool MulitButtonColorCheck = true.obs; //切換目前切換單選多選按鈕顏色
  RxBool isMultiPick = false.obs; //判斷目前為單選多選

  static List allPicPath = []; //所有照片的path存在這
  //單選
  Map currPicFocusDic = {}; //選照片Focus

  static String singlePic = '';
  static var selectedPicPath = null;

  //多選
  var currNum;
  List selectOrder = [];

  static String multiPic = ''; //split前變數存放
  RxMap selectedPicDic = {}.obs; //多選Dictionary
  static List finalPicPath = []; //多張照片路徑存放
  static List selectedPicPathList =
      []; //這是要把第一頁選的照片丟到第二頁(type是FutureBuilder<Uint8List?>)

  static String finalTitle = '';
  static String finalContent = '';
  static String finalFirstPicPath = '';
  //所有所選照片的path

  static Color themeColor = Color.fromRGBO(202, 175, 154, 1);

  //傳到後端的資料
  void goToDataBase() {
    print(finalTitle);
    print(finalContent);
    print(finalFirstPicPath);
    print(finalPicPath);
  }

  //最上面的照片選擇判斷
  void pick() {
    isPick.value = true;
  }

  //多選開關
  void multiPick() {
    if (checkPressed == true) {
      isMultiPick.value = true;
      checkPressed = false;
      MulitButtonColorCheck.value = false;
    } else {
      isMultiPick.value = false;
      checkPressed = true;
      MulitButtonColorCheck.value = true;
    }
  }

  //單選將第一頁選的照片丟到第二頁
  void singleSelectedPicNum() {
    selectedPicPath = media[index.toInt()];
  }

  //多選將第一頁選的照片丟到第二頁
  void selectedPicNum() {
    if (selectedPicDic[index] == true) {
      selectedPicPathList.add(media[index.value]);
    } else {
      selectedPicPathList.remove(media[index.value]);
    }
  }

  void selectOrderSet() {
    if (selectOrder.contains(currNum) != true) {
      selectOrder.add(currNum);
      print(selectOrder.asMap());
      print(selectOrder.asMap().keys);
    } else {
      selectOrder.remove(currNum);
      print(selectOrder.asMap());
    }
  }
}
