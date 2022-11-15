import 'package:cozydiary/pages/Home/widget/homeScreen_GridView.dart';
import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/categoryPostController.dart';
import '../../../Model/categoryList.dart';

class NestedTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Tab> nestedTabs = <Tab>[
    Tab(
      child: Text("推薦"),
    ),
    Tab(
      child: Text("籃球"),
    ),
    Tab(
      child: Text("穿搭"),
    ),
    Tab(
      child: Text("投資"),
    ),
    Tab(
      child: Text("動漫"),
    ),
    Tab(
      child: Text("美女"),
    )
  ];
  late List<Widget> screen = <Widget>[];
  var isLoading = false.obs;

  late TabController nestedController;
  @override
  void onInit() {
    setCategoryTab();
    nestedController = TabController(length: nestedTabs.length, vsync: this);
    super.onInit();
  }

  Future<void> setCategoryTab() async {
    isLoading(true);
    screen.add(GetBuilder<CategoryPostController>(
        id: "推薦",
        init: CategoryPostController(),
        builder: (controller) {
          controller.getPostCover("");
          update();
          return HomeScreen(homePostCover: controller.postCover);
        }));
    for (int i = 0; i < nestedTabs.length - 1; i++) {
      screen.add(GetBuilder<CategoryPostController>(
          id: "",
          init: CategoryPostController(),
          builder: (controller) {
            controller.getPostCover("");
            update();
            return HomeScreen(
              homePostCover: controller.postCover,
              key: ValueKey(""),
            );
          }));
    }
    isLoading(false);
  }

  @override
  void onClose() {
    nestedController.dispose();
    super.onClose();
  }
}
