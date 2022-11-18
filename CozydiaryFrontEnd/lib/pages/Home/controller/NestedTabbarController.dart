import 'package:cozydiary/pages/Home/widget/homeScreen_GridView.dart';
import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Model/categoryList.dart';

class NestedTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late List<Tab> nestedTabs = <Tab>[];
  late List<Widget> screen = <Widget>[];
  var isLoading = false.obs;

  late TabController nestedController;
  @override
  void onInit() {
    setCategoryTab();
    super.onInit();
  }

  Future<void> setCategoryTab() async {
    isLoading(true);

    CategoryListModel category = await RegisterService.fetchCategoryList();
    try {
      if (category.status == 200) {
        nestedTabs.add(Tab(
          child: Text("推薦"),
        ));
        screen.add(HomeScreen(
          key: UniqueKey(),
          category: "推薦",
          cid: "",
        ));
        category.data.forEach((element) {
          nestedTabs.add(Tab(
            child: Text(element.category),
          ));
          screen.add(HomeScreen(
            key: UniqueKey(),
            cid: element.cid.toString(),
            category: element.category,
          ));
        });

        nestedController =
            TabController(length: nestedTabs.length, vsync: this);
      }
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
