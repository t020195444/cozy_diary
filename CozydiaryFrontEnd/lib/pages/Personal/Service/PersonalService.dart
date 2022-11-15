import 'dart:convert';
import 'package:cozydiary/Model/PostReceiveModel.dart';
import 'package:cozydiary/Model/trackerListModel.dart';
// import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import '../../../Model/catchPersonalModel.dart';
import '../../../Model/postCoverModel.dart';
import '../../../api.dart';

class PersonalService {
  static Dio dio = Dio();
  //利用uid抓取使用者資料
  static Future<UserModel?> fetchUserData(String id) async {
    var response = await dio.get(Api.ipUrl + Api.getUser + id);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = userModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  //抓取使用者貼文
  static Future<PostCoverModule?> fetchUserPostCover(String id) async {
    var response =
        await dio.get(Api.ipUrl + Api.getPostCoverForPersonalPage + id);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    print(encodeJsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  //追蹤
  static Future<int> addTracker(String jsonData) async {
    var response = await dio.post(Api.ipUrl + Api.addTracker, data: jsonData);
    return response.statusCode!;
  }

  //取消追蹤
  static Future<dynamic> deleteTracker(String tid) async {
    return await dio.post(Api.ipUrl + Api.deleteTracker + tid);
  }

  //獲取追蹤者清單
  static Future<TrackerListModel> getTracker(String uid) async {
    var response = await dio.get(Api.ipUrl + Api.getTrackerList + uid);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = trackerListModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  //獲取追蹤者清單
  static Future<TrackerListModel> getFollower(String uid) async {
    var response = await dio.get(Api.ipUrl + Api.getFollowerList + uid);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = trackerListModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  //編輯個人資料
  static Future<PostReceiveModel> updateUser(String jsonData) async {
    var response = await dio.post(Api.ipUrl + Api.updateUser, data: jsonData);
    var responseData = response.data;
    var returnData = postReceiveModelFromJson(jsonEncode(responseData));

    return returnData;
  }

  //更改使用者圖片
  static Future<PostReceiveModel> changeProfilePic(
      FormData formData, String uid, String fileName) async {
    var response = await dio.post(
        Api.ipUrl + "changeProfilePic?uid=$uid&fileName=$fileName",
        data: formData);
    var responseData = response.data;
    var returnData = postReceiveModelFromJson(jsonEncode(responseData));
    return returnData;
  }
}
