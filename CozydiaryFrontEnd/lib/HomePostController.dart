import 'dart:io';

import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/PostJsonService.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'Model/PostCoverModel.dart';
import "package:get/get.dart" hide FormData, MultipartFile, Response;
import 'dart:convert';
import 'package:dio/dio.dart';

class HomePostController extends GetxController {
  var loginController = Get.put(LoginController());
  var postCover = <PostCoverData>[].obs;
  var isLoading = true.obs;
  late Post postsContext;
  var title = "".obs;
  var content = "".obs;
  var cover = "".obs;
  var postFiles = <PostFile>[];
  var cid = 0.obs;
  var imageFile = <String>[].obs;
  String uid = Hive.box("UidAndState").get("uid");

  @override
  void onInit() {
    getPostCover();
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

  void getPostCover() async {
    try {
      isLoading(true);
      var Posts = await PostService.fetchPostCover(uid);
      if (Posts != null) {
        if (Posts.status == 200) {
          postCover.value = Posts.data;
        }
      }
    } finally {
      isLoading.value = false;
    }
  }

  void setPost() {
    postsContext = Post(
        uid: loginController.id,
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
    imageFile.value.asMap().forEach((key, value) async {
      formData.files.addAll([
        MapEntry(
            "file",
            await MultipartFile.fromFile(value,
                filename: value.split("/").last + "-" + key.toString()))
      ]);
    });

    return formData;
  }

  @override
  void refresh() {
    getPostCover();
    // TODO: implement refresh

    super.refresh();
  }
}
