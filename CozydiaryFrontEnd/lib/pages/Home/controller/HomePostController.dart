import 'package:cozydiary/Model/writePostModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import "package:get/get.dart" hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';
import '../../../Model/categoryList.dart';
import '../../../Model/postCoverModel.dart';
import '../../Register/Service/registerService.dart';

class HomePostController extends GetxController {
  var postCover = <PostCoverData>[].obs;
  var isLoading = true.obs;
  late Post postsContext;
  var title = "".obs;
  var content = "".obs;
  var cover = "".obs;
  var postFiles = <PostFile>[].obs;
  var cid = 0.obs;
  var imageFile = <String>[].obs;
  var userCategory = <Category>[];
  late List<Tab> nestedTabs = <Tab>[];
  late List<Widget> screen = <Widget>[];
  String uid = Hive.box("UidAndState").get("uid");

  @override
  void onInit() {
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

  Future<void> setUserCategory() async {
    CategoryListModel category = await RegisterService.fetchCategoryList();
    try {
      if (category.status == 200) {
        userCategory = category.data;
      }
    } finally {}
  }

  void setPost() {
    postsContext = Post(
        uid: uid,
        title: title.value,
        content: content.value,
        likes: 0,
        collects: 0,
        cover: cover.value,
        cid: cid.value,
        postFiles: postFiles);
  }

  Future<FormData> writePost() async {
    setPost();

    WritePostModule writePost = WritePostModule(post: postsContext);
    FormData formData = FormData.fromMap(writePost.toJson());
    // int index = 1;
    imageFile.asMap().forEach((key, value) async {
      formData.files.addAll([
        MapEntry(
            "file",
            await MultipartFile.fromFile(value,
                filename: value.split("/").last + "-" + key.toString()))
      ]);
    });

    return formData;
  }
}
