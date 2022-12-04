import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../Self/widget/buildCard_personal.dart';
import '../Controller/otherPersonController.dart';

class InitOtherPersonPostGridView extends StatelessWidget {
  const InitOtherPersonPostGridView({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  Widget build(BuildContext context) {
    var personalPageController = Get.find<OtherPersonPageController>(tag: uid);
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: personalPageController.postCover.length,
            itemBuilder: (context, index) {
              return BuildCard_Post(
                index: index,
                userPostCover: personalPageController.postCover,
              );
            }));
  }
}
