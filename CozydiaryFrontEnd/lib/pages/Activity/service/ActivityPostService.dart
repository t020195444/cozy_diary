import 'dart:convert';

import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/HomePostController.dart';
import 'package:cozydiary/api.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';

import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

class ActivityPostService {
  static Dio dio = Dio();
  static var getPostCoverUri =
      'http://140.131.114.166:80/getPostCoverByUserCategory?uid=116177189475554672826';
  static var writeActivityPostUri = 'http://140.131.114.166:80/addActivity';

  static var postController = Get.put(ActivityPostController());

  static Map activityDetailList = {};

  static getActivityDetail(String i) async {
    activityDetailList = {};
    var response = await dio.get(Api.ipUrl + Api.getActivityDetail + i);
    var data = response.data;
    List tempPathList = [];
    for (int j = 0; j < data['data']['activityFiles'].length; j++) {
      tempPathList.add(data['data']['activityFiles'][j]['activityUrl']);
    }
    activityDetailList['title'] = data['data']['activityName'];
    activityDetailList['content'] = data['data']['content'];
    activityDetailList['url'] = tempPathList;
    print(data);
  }

  static List postPid = [];

  static Future<ActivityPostCoverModule> fetchPostCover() async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getPostCoverUri);
    print(response.data.toString());
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = activityPostCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<dynamic> postPostData(FormData formData) async {
    print(formData);
    return await dio.post(writeActivityPostUri, data: formData);
  }
}
