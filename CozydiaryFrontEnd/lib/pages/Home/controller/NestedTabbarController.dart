import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NestedTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final nestedTabs = <Widget>[
    Container(
        height: 30,
        width: 30,
        child: Center(
          child: Text(
            '運動',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        )),
    Container(
        height: 30,
        width: 50,
        child: Center(
          child: Text('美妝',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              )),
        )),
    Container(
        height: 30,
        width: 50,
        child: Center(
          child: Text('生活',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              )),
        )),
    Container(
        height: 30,
        width: 50,
        child: Center(
          child: Text('藝術',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              )),
        )),
    Container(
        height: 30,
        width: 50,
        child: Center(
          child: Text('搞笑',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              )),
        )),
  ];

  late TabController nestedController;

  @override
  void onInit() {
    super.onInit();
    nestedController = TabController(length: 5, vsync: this);
  }

  @override
  void onClose() {
    nestedController.dispose();
    super.onClose();
  }
}
