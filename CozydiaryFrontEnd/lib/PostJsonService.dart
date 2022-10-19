import 'dart:convert';

import 'package:cozydiary/HomePostController.dart';

import 'Model/PostCoverModel.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import 'api.dart';

class PostService {
  static Dio dio = Dio();
  static var getPostCoverUri =
      'http://140.131.114.166:80/getPostCoverByUserCategory?uid=';
  static var getAllPostCoverUri = 'http://140.131.114.166:80/getAllPost';
  static var writePostUri = 'http://140.131.114.166:80/addPost';

  static var postController = Get.put(HomePostController());

  static Map postDetailList = {};
  static getPostDetail(String i) async {
    postDetailList = {};

    var response = await dio.get(Api.ipUrl + Api.getPostDetail);
    var data = response.data;
    List tempPathList = [];
    for (int j = 0; j < data['data']['postFiles'].length; j++) {
      tempPathList.add(data['data']['postFiles'][j]['postUrl']);
    }
    postDetailList['title'] = data['data']['title'];
    postDetailList['content'] = data['data']['content'];
    postDetailList['url'] = tempPathList;
    print(data);
  }

  static List postPid = [];

  static Future<PostCoverModule?> fetchPostCover(String uid) async {
    var response =
        await dio.get(Api.ipUrl + Api.getPostCoverByUserCategory + uid);

    var jsonString = response.data;
    // for (int i = 0; i < jsonString.length; i++) {
    //   postPid.add(jsonString['data'][i]['pid']);
    // }
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);

    return fromJsonValue;
  }

  static Future<PostCoverModule?> fetchAllPostCover() async {
    var response = await dio.get(getAllPostCoverUri);

    var jsonString = response.data;
    // for (int i = 0; i < jsonString.length; i++) {
    //   postPid.add(jsonString['data'][i]['pid']);
    // }
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);

    return fromJsonValue;
  }

  static Future<dynamic> postPostData(FormData formData) async {
    return await dio.post(Api.ipUrl + Api.addPost, data: formData);
  }
}
