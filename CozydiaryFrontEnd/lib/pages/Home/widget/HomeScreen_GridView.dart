import 'package:cozydiary/PostController.dart';
import 'package:cozydiary/pages/Home/widget/buildCard_home.dart';
import 'package:cozydiary/pages/Home/widget/grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../../data/dataResourse.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final postCoverController = Get.put(PostController());
    return Obx(() {
      if (postCoverController.isLoading.value) {
        return Center(
            child: Column(
          children: [
            // FloatingActionButton(onPressed: (){
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => MediaGrid(),
            //       ));
            // })
          ],
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
                  return BuildCardHome(
                    PostCovers: postCoverController.postCover.value,
                    index: index,
                  );
                }));
      }
    });
  }
}
