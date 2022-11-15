import 'package:cozydiary/Model/categoryList.dart';
import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/pages/Home/controller/HomePostController.dart';
import 'package:cozydiary/pages/Home/widget/buildCard_home.dart';
import 'package:cozydiary/widget/keepAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.homePostCover,
  }) : super(key: key);
  final List<PostCoverData> homePostCover;

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: KeepAliveWrapper(
          keepAlive: true,
          child: MasonryGridView.count(
              crossAxisSpacing: 0,
              crossAxisCount: 2,
              itemCount: homePostCover.length,
              itemBuilder: (context, index) {
                return BuildCardHome(
                  key: ValueKey(
                      {homePostCover[index].uid, homePostCover[index].pid}),
                  postCovers: homePostCover,
                  index: index,
                );
              }),
        ));
  }
}
