import 'dart:convert';
import 'package:cozydiary/Model/postDetailModel.dart';
import 'package:cozydiary/pages/Home/controller/homePostController.dart';

import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';
import 'Model/postCoverModel.dart';
import 'api.dart';

class PostService {
  static Dio dio = Dio();
  static var postController = Get.put(HomePostController());
  static List postPid = [];

  static Future<PostDetailModel> getPostDetail(String pid) async {
    var response = await dio.get(Api.ipUrl + Api.getPostDetail + pid);
    var data = response.data;
    var encodeJsonString = jsonEncode(data);
    var fromJsonValue = postDetailModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  //獲取主頁貼文預設圖
  static Future<PostCoverModule?> fetchPostCover(String uid) async {
    var response =
        await dio.get(Api.ipUrl + Api.getPostCoverByUserCategory + uid);

    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);

    return fromJsonValue;
  }

  //依照類別獲取貼文預設圖
  static Future<PostCoverModule?> fetchCategoryPostCover(String cid) async {
    var response = await dio.get(Api.ipUrl + Api.getPostCoverByCategory + cid);

    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);

    return fromJsonValue;
  }

  //獲取所有貼文
  static Future<PostCoverModule?> fetchAllPostCover() async {
    var response = await dio.get(Api.ipUrl + Api.getAllPost);

    var jsonString = response.data;
    // for (int i = 0; i < jsonString.length; i++) {
    //   postPid.add(jsonString['data'][i]['pid']);
    // }
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);

    return fromJsonValue;
  }

  //發文
  static Future<dynamic> postPostData(FormData formData) async {
    return await dio.post(Api.ipUrl + Api.addPost, data: formData);
  }
}
