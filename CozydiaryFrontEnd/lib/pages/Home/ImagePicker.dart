import 'dart:io';
import 'package:cozydiary/pages/Home/Image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'imagePickGetX.dart';

class ImagePickerPage extends GetView<ImagePickPageController> {
  ImagePickerPage({Key? key}) : super(key: key);
  final ImagePickPageController imagePickPageController =
      Get.put(ImagePickPageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ImagePickPage')),
      body: SafeArea(
        child: Column(
          children: [
            _buildImageWidget(),
            CupertinoButton(
              child: const Text("選擇照片"),
              onPressed: () => controller.getImage(ImageSource.gallery),
            ),
            CupertinoButton(
              child: const Text("下一頁"),
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ImagePage())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Center(
      child: Obx(
        () {
          return Container(
            color: Colors.grey[200],
            width: Get.width,
            height: Get.width,
            child: (controller.imageFilePath.isEmpty)
                ? const Icon(Icons.photo_library, size: 50)
                : Image.file(File(controller.imageFilePath)),
          );
        },
      ),
    );
  }
}
