import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> tabs = <Tab>[
    Tab(text: "筆記"),
    Tab(
      text: "收藏",
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
