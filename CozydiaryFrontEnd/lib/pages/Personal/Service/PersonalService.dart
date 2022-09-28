import 'dart:convert';

import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/Model/trackerModel.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import '../../../Model/PostCoverModel.dart';

class PersonalService {
  static Dio dio = Dio();
  static List api = [
    "getUser?gid=",
    "getPostCoverForPersonalPage?uid=",
    "addTracker",
    "addFollower",
    "deleteTracker?tid="
  ];

  static var ipUrl = 'http://140.131.114.166:80/';

  static Future<UserModel?> fetchUserData(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    print(id);
    var response = await dio.get(ipUrl + api[0] + id);
    print(response.data);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = userModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<PostCoverModule?> fetchUserPostCover(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(ipUrl + api[1] + id);
    print(response.data.toString());
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<dynamic> addTracker(String jsonData) async {
    print(jsonData);

    return await dio.post(ipUrl + api[2], data: jsonData);
  }

  static Future<dynamic> deleteTracker(String tid) async {
    return await dio.post(ipUrl + api[4] + tid);
  }
}
