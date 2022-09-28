import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> topTabs = <Tab>[
    Tab(text: "活動地圖"),
    Tab(
      text: "活動列表",
    ),
  ];

  late TabController topController;

  @override
  void onInit() {
    super.onInit();
    topController = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  void onClose() {
    topController.dispose();
    super.onClose();
  }
}
