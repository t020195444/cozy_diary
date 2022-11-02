import 'dart:convert';

import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import '../../../Model/PostCoverModel.dart';

class ActivityService {
  static Dio dio = Dio();
  static var getActivityUri =
      'http://140.131.114.166:80/getActivityCover?option=2';

  static Future<UserModel?> fetchActivityData() async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getActivityUri);
    print(response.data);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = userModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<ActivityPostCoverModule?> fetchPostCover() async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getActivityUri);
    print(response.data.toString());
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = activityPostCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }
}
