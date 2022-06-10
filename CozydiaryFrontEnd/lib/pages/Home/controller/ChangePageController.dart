import 'package:cozydiary/pages/Home/UserData.dart';
import 'package:cozydiary/pages/Home/widget/grid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePageTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 0;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }

  void oncircleItemsTapped() {
    Get.to(MediaGrid());
  }

  void oncircleItemsTappeduser() {
    Get.to(UserDataPage());
  }
}
