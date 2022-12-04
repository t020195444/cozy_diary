import 'package:cozydiary/pages/Home/controller/searchPageController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../screen_widget/viewPostScreen.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  SearchPageController searchPageController = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusManager.instance.primaryFocus?.unfocus()),
      child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.transparent,
            // elevation: 0,
            title: TextField(
              onChanged: (value) =>
                  searchPageController.searchPost(value, "50"),
              controller: TextEditingController(),
              decoration: InputDecoration(
                  hintText: "搜尋貼文...",
                  fillColor: Colors.transparent,
                  focusedBorder: UnderlineInputBorder()),
            ),
          ),
          body: Obx(
            () => searchPageController.isSearching.value
                ? SpinKitThreeBounce(
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : GridView.builder(
                    padding: EdgeInsets.only(top: 5),
                    itemCount: searchPageController.searchResult.length,
                    addAutomaticKeepAlives: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          await searchPageController.getOtherUserData(index);
                          Get.to(
                            () => ViewPostScreen(
                                username: searchPageController.username,
                                ownerPicUrl: searchPageController.userPic,
                                ownerUid: searchPageController
                                    .searchResult[index].uid,
                                pid: searchPageController
                                    .searchResult[index].pid
                                    .toString()),
                            transition: Transition.fadeIn,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: Image.network(
                            searchPageController
                                .searchResult.value[index].cover,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[100],
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.width / 3,
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          )),
    );
  }
}
