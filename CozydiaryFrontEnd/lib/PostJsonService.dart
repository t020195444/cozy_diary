import 'dart:convert';

import 'package:cozydiary/PostController.dart';
import 'package:cozydiary/pages/Home/widget/pick.dart';
import 'Model/PostCoverModel.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

class PostService {
  static Dio dio = Dio();
  static var getPostCoverUri =
      'http://140.131.114.166:80/getPostCoverByUserCategory?uid=';
  static var writePostUri = 'http://140.131.114.166:80/addPost';

  static var postController = Get.put(PostController());

  static Future<PostCoverModule?> fetchPostCover(String uid) async {
    var response = await dio.get(getPostCoverUri + uid);
    var jsonString = response.data;
    print(response.data.length);
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<dynamic> postPostData(FormData formData) async {
    return await dio.post(writePostUri, data: formData);
  }
}
