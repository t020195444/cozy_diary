import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'imagePickGetX.dart';

class ImagePage extends GetView<ImagePickPageController> {
  ImagePage({Key? key}) : super(key: key);
  final ImagePickPageController imagePickPageController =
      Get.put(ImagePickPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('顯示圖片'),
      ),
      body: Image.file(File(controller.imageFilePath)),
    );
  }
}
