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
        Get.put(CategoryPostController(cid: cid), tag: category);
    return Obx(() => categoryController.isLoading.value
        ? SpinKitFadingCircle(
            size: 50, color: Theme.of(context).colorScheme.primary)
        : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: RefreshIndicator(
                notificationPredicate: (notification) {
                  return true;
                },
                onRefresh: () async {
                  categoryController.getPostCover(cid);
                },
                child: KeepAliveWrapper(
                  child: MasonryGridView.count(
                      addAutomaticKeepAlives: true,
                      cacheExtent: 5000,
                      crossAxisSpacing: 0,
                      crossAxisCount: 2,
                      itemCount: categoryController.postCover.length,
                      controller: ScrollController(keepScrollOffset: true),
                      itemBuilder: (context, index) {
                        return BuildCardHome(
                          key: ValueKey(
                              {categoryController.postCover[index].pid}),
                          postCovers: categoryController.postCover,
                          index: index,
                          pid: categoryController.postCover[index].pid
                              .toString(),
                          uid: categoryController.postCover[index].uid,
                          category: category,
                          cid: cid,
                        );
                      }),
                ))));
  }
}
