import 'package:cozydiary/pages/Personal/OtherPerson/Controller/OtherPersonController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../../Self/widget/buildCard_personal.dart';

class InitOtherPersonCollectGridView extends StatelessWidget {
  InitOtherPersonCollectGridView({Key? key, required this.otherUid})
      : super(key: key);
  final String otherUid;

  @override
  Widget build(BuildContext context) {
    var otherPersonPageController =
        Get.put(OtherPersonPageController(otherUid: otherUid));
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: otherPersonPageController.collectedPostCover.length,
            itemBuilder: (context, index) {
              return BuildCard_Collect(
                index: index,
                userPostCover: otherPersonPageController.collectedPostCover,
              );
            }));
  }
}
