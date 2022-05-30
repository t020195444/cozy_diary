import 'package:cozydiary/PostCoverJsonService.dart';

import 'Model/PostCoverModel.dart';
import "package:get/get.dart";
import 'package:meta/meta.dart';
import 'dart:convert';

class PostCoverController extends GetxController {
  var postCover = <PostCoverData>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    getPostCover();
    super.onInit();
  }

  void getPostCover() async {
    try {
      isLoading(true);
      var Posts = await PostCoverService.fetchPostCover();
      if (Posts != null) {
        if (Posts.status == 200) {
          postCover.value = Posts.data;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
