import 'dart:convert';

import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/api.dart';
import 'package:dio/dio.dart';

class ActivityService {
  static Dio dio = Dio();
  static var getActivityUri =
      'http://140.131.114.166:80/getActivityCover?option=2';

  //活動按讚列表
  Future<dynamic> activityLikesList(String aid) async {
    var response = await dio.get(Api.ipUrl + Api.activityLikesList + aid);
    var jsonString = response.data;
    return jsonString['data'];
  }

  //刪除活動
  Future<dynamic> deleteActivity(String aid) async {
    return await dio.post(Api.ipUrl + Api.deleteActivity + aid);
  }

  //活動按讚
  Future<dynamic> checkLike(String uid, String aid) async {
    return await dio.post(
        Api.ipUrl + Api.updateActivityLikes + "?aid=" + aid + "&uid=" + uid);
  }

  //報名活動API
  Future<dynamic> updateParticipant(Map formData) async {
    return await dio.post(Api.ipUrl + Api.updateParticipant, data: formData);
  }

  //審核列表API
  Future<dynamic> getParticipantList(String i) async {
    var response = await dio.get(Api.ipUrl + Api.getParticipantList + i);

    var jsonString = response.data;

    return jsonString['data'];
  }

//活動歷史紀錄
  Future<dynamic> getActivityHistoryDetail(String i) async {
    var response = await dio.get(Api.ipUrl + Api.getActivityDetail + i);

    var jsonString = response.data;

    return jsonString['data'];
  }

  //利用uid抓取使用者資料
  static Future<dynamic> getUserData(String id) async {
    var response = await dio.get(Api.ipUrl + Api.getUser + id);

    var jsonString = response.data;

    return jsonString['data'];
  }

  //歷史紀錄活動列表API
  Future<dynamic> getHistoryList(String uid) async {
    var response = await dio.get(Api.ipUrl + Api.getUserParticipated + uid);

    var jsonString = response.data;

    return jsonString['data'];
  }

  //審核通過/不通過API
  Future<dynamic> checkParticipant(String uid, String aid) async {
    return await dio.post(
        Api.ipUrl + Api.updateApplication + "?uid=" + uid + "&aid=" + aid);
  }

  static Future<UserModel?> fetchActivityData() async {
    var response = await dio.get(getActivityUri);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = userModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<ActivityPostCoverModule?> fetchPostCover() async {
    var response = await dio.get(getActivityUri);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = activityPostCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<ActivityPostCoverModule?> fetchLocalPostCover(
      String placeLat, String placeLng) async {
    var response = await dio.get(Api.ipUrl +
        Api.getActivityCoverByPlace +
        placeLat +
        "&placeLng=" +
        placeLng);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = activityPostCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }
}
