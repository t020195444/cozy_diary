import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/PostJsonService.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'Model/PostCoverModel.dart';
import "package:get/get.dart" hide FormData, MultipartFile, Response;
import 'dart:convert';
import 'package:dio/dio.dart';

class PostController extends GetxController {
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
      var Posts = await PostService.fetchPostCover();
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
