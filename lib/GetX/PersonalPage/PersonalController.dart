import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../pages/Personal/Page/personal_page.dart';

class PersonalPageController extends GetxController {
  var sliverAppbarHeight = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void getSliverAppbarHeight(var height) {
    sliverAppbarHeight.value = height;
    update();
  }
}
