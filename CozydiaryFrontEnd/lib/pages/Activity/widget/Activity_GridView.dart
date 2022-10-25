import 'package:cozydiary/pages/Home/controller/HomePostController.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityController.dart';
import 'package:cozydiary/pages/Activity/widget/BuildCardActivity.dart';
import 'package:cozydiary/pages/Home/widget/buildCard_home.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postCoverController = Get.put(ActivityController());
    return Obx(() {
      if (postCoverController.isLoading.value) {
        return Center(
            child: SpinKitCircle(
          size: 20,
          color: Colors.black54,
        ));
      } else {
        return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: MasonryGridView.count(
                crossAxisSpacing: 0,
                crossAxisCount: 2,
                itemCount: postCoverController.postCover.length,
                itemBuilder: (context, index) {
                  return BuildCardActivity(
                    PostCovers: postCoverController.postCover,
                    index: index,
                  );
                }));
      }
    });
  }
}
