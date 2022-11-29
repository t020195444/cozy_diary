import 'package:cozydiary/pages/Home/controller/searchPageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen_widget/viewPostScreen.dart';

class SerchPage extends StatelessWidget {
  SerchPage({Key? key}) : super(key: key);
  SearchPageController searchPageController = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        title: TextField(
          onChanged: (value) => searchPageController.searchPost(value, "50"),
          controller: TextEditingController(),
          decoration: InputDecoration(
              hintText: "搜尋貼文...",
              fillColor: Colors.transparent,
              focusedBorder: UnderlineInputBorder()),
        ),
      ),
      body: GridView.builder(
        itemCount: searchPageController.searchResult.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => Get.to(
              () => ViewPostScreen(
                  username: searchPageController.searchResult[index].username,
                  ownerPicUrl: searchPageController.searchResult[index].pic,
                  ownerUid: searchPageController.searchResult[index].uid,
                  pid: searchPageController.searchResult[index].pid.toString()),
              transition: Transition.fadeIn,
            ),
            child:
                Image.asset(searchPageController.searchResult.value[index].pic),
          );
        },
      ),
    );
  }
}
