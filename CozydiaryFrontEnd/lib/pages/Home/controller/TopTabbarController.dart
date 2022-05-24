import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final List<Tab> topTabs = <Tab>[
    Tab(text: "關注"),
    Tab(
      text: "發現",
    ),
    Tab(
      text: "附近",
    )
  ];

  late TabController topController;

  @override
  void onInit() {
    super.onInit();
    topController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void onClose() {
    topController.dispose();
    super.onClose();
  }
}
