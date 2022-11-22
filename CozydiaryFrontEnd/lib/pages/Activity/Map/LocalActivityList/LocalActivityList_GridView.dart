import 'package:cozydiary/pages/Activity/controller/ActivityController.dart';
import 'package:cozydiary/pages/Activity/widget/BuildCardActivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocalActivityList extends StatelessWidget {
  LocalActivityList(this.lat, this.lng);
  final String lat;
  final String lng;

  @override
  Widget build(BuildContext context) {
    final postCoverController = Get.put(ActivityController());
    postCoverController.getLocalPostCover(lat, lng);
    return Obx(() {
      if (postCoverController.isLocalLoading.value) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          )),
          body: Center(
              child: SpinKitCircle(
            size: 20,
            color: Colors.black54,
          )),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          )),
          body: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: MasonryGridView.count(
                  crossAxisSpacing: 0,
                  crossAxisCount: 2,
                  itemCount: postCoverController.localPostCover.length,
                  itemBuilder: (context, index) {
                    return BuildCardActivity(
                      key: ValueKey({
                        postCoverController.localPostCover[index].aid,
                      }),
                      PostCovers: postCoverController.localPostCover,
                      index: index,
                    );
                  })),
        );
      }
    });
  }
}
