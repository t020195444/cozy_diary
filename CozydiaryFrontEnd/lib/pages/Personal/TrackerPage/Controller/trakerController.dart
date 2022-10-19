import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TrackerController extends GetxController {}

class TrackerTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "已追蹤"),
    Tab(
      text: "粉絲",
    )
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
