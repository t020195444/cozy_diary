import 'package:cozydiary/Model/writePostModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:get/get.dart" hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';
import '../../../Model/categoryList.dart';
import '../../../Model/postCoverModel.dart';
import '../../../PostJsonService.dart';
import '../../Register/Service/registerService.dart';

class CategoryPostController extends GetxController {
  var postCover = <PostCoverData>[].obs;
  var isLoading = true.obs;
  var userCategory = <Category>[];
  String uid = Hive.box("UidAndState").get("uid");

  @override
  void onInit() {
    getPostCover("");
    setUserCategory();
    Post(
        uid: "",
        title: "",
        content: "",
        likes: 0,
        collects: 0,
        cover: "",
        cid: 0,
        postFiles: []);

    super.onInit();
  }

  Future<void> getPostCover(String cid) async {
    // print(cid);
    if (cid == "") {
      try {
        isLoading(true);
        var Posts = await PostService.fetchPostCover(uid);
        if (Posts != null) {
          if (Posts.status == 200) {
            postCover.value = Posts.data;
            // print("userCategory：" + Posts.data.toString());
            // update(['推薦']);
          }
        }
      } finally {
        isLoading.value = false;
      }
    } else {
      try {
        isLoading(true);
        var Posts = await PostService.fetchCategoryPostCover(cid);
        if (Posts != null) {
          if (Posts.status == 200) {
            postCover.value = Posts.data;
            // print("Category：" + Posts.data.toString());
            // update([cid.toString()]);
          }
        }
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> setUserCategory() async {
    CategoryListModel category = await RegisterService.fetchCategoryList();
    try {
      if (category.status == 200) {
        userCategory = category.data;
      }
    } finally {}
  }
}
