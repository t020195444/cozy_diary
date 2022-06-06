import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PersonalPageController extends GetxController {
  var constraintsHeight = 100.0.obs;
  var readmore = true.obs;
  var difference = 0.0;

  @override
  void onInit() {
    super.onInit();
  }

  void getConstraintsHeight(var height) {
    constraintsHeight.value = height;
    update();
  }

  void onTabReadmore() {
    readmore.value = !readmore.value;
    print(readmore.value);
  }

  void increaseAppbarHeight() {
    constraintsHeight.value = constraintsHeight.value + difference;
  }

  void reduceAppbarHeight() {
    constraintsHeight.value = constraintsHeight.value - difference;
  }
}
