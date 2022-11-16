import 'package:cozydiary/pages/Activity/Post/PostActivityPage.dart';
import 'package:cozydiary/pages/Home/widget/pickPhotoPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePageTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final selectedIndex = 0.obs;
  final buttonColor = Colors.black54.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    if (selectedIndex.value == 1) {
      buttonColor.value = Colors.black87;
    } else
      buttonColor.value = Colors.black54;
    print(buttonColor.value);
  }

  void oncircleItemsTapped() {
    Get.to(PickPhotoPage());
  }

  void oncircleItemsTappeduser() {
    Get.to(() => PostActivityPage());
  }
}
