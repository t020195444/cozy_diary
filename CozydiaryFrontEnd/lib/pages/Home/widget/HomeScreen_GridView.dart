import 'package:cozydiary/pages/Home/controller/categoryPostController.dart';
import 'package:cozydiary/pages/Home/widget/buildCard_home.dart';
import 'package:cozydiary/widget/keepAliveWrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
    required this.category,
    required this.cid,
  }) : super(key: key);
  final String category;
  final String cid;

  @override
  Widget build(BuildContext context) {
    final CategoryPostController categoryController =
        Get.put(CategoryPostController(), tag: category);
    categoryController.getPostCover(cid);
    return Obx(() => categoryController.isLoading.value
        ? SpinKitFadingCircle(
            size: 50,
            color: Colors.black,
          )
        : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: KeepAliveWrapper(
              keepAlive: true,
              child: MasonryGridView.count(
                  crossAxisSpacing: 0,
                  crossAxisCount: 2,
                  itemCount: categoryController.postCover.length,
                  itemBuilder: (context, index) {
                    return BuildCardHome(
                      key: ValueKey({categoryController.postCover[index].pid}),
                      postCovers: categoryController.postCover,
                      index: index,
                      uid: categoryController.postCover[index].uid,
                    );
                  }),
            )));
  }
}
