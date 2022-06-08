import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/pages/Personal/controller/PersonalController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../Data/dataResourse.dart';
import '../pages/Personal/widget/buildCard_personal.dart';

class InitPostGridView extends StatelessWidget {
  const InitPostGridView({Key? key, required this.personalPageController})
      : super(key: key);
  final PersonalPageController personalPageController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (personalPageController.isLoading.value) {
        return Center(
            child: CircularProgressIndicator(
          color: Colors.white10,
        ));
      } else {
        return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: MasonryGridView.count(
                crossAxisCount: 2,
                itemCount: Image_List.length,
                itemBuilder: (context, index) {
                  return BuildCard(
                    index: index,
                    userPostCover: personalPageController.postCover.value,
                  );
                }));
      }
    });
  }
}
