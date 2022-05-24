import 'package:cozydiary/PostCoverController.dart';
import 'package:cozydiary/pages/Home/widget/buildCard_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../data/dataResourse.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postCoverController = Get.put(PostCoverController());
    return Obx(() => MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: postCoverController.postCover.length,
            itemBuilder: (context, index) {
              return BuildCardHome(
                PostCovers: postCoverController.postCover.value,
                index: index,
              );
            })));
  }
}
