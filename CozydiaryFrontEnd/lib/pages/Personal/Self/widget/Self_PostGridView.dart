import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../controller/selfController.dart';
import 'buildCard_personal.dart';

class InitPostGridView extends StatelessWidget {
  const InitPostGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selfPageController = Get.find<SelfPageController>();
    return Obx(() {
      return MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: MasonryGridView.count(
              crossAxisCount: 2,

              //依照資料長度數量
              itemCount: selfPageController.postCover.length,
              itemBuilder: (context, index) {
                return BuildCard(
                  index: index,
                  userPostCover: selfPageController.postCover,
                );
              }));
    });
  }
}
