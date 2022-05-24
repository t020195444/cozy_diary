import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePageTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 1;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }
}
