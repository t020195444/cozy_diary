import 'dart:convert';

import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/Model/PostReceiveModel.dart';
import 'package:cozydiary/Model/trackerListModel.dart';
import 'package:cozydiary/Model/trackerModel.dart';
// import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import '../../../Model/PostCoverModel.dart';
import '../../../api.dart';

class PersonalService {
  static Dio dio = Dio();

  static Future<UserModel?> fetchUserData(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(Api.ipUrl + Api.getUser + id);

    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);

    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = userModelFromJson(encodeJsonString);
    print(response.data);
    return fromJsonValue;
  }

  static Future<PostCoverModule?> fetchUserPostCover(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response =
        await dio.get(Api.ipUrl + Api.getPostCoverForPersonalPage + id);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<dynamic> addTracker(String jsonData) async {
    return await dio.post(Api.ipUrl + Api.addTracker, data: jsonData);
  }

  static Future<dynamic> deleteTracker(String tid) async {
    return await dio.post(Api.ipUrl + Api.deleteTracker + tid);
  }

  static Future<TrackerListModel> getTracker(String uid) async {
    var response = await dio.get(Api.ipUrl + Api.getTrackerList + uid);
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    var fromJsonValue = trackerListModelFromJson(encodeJsonString);

    return fromJsonValue;
  }

  static Future<PostReceiveModel> updateUser(String jsonData) async {
    var response = await dio.post(Api.ipUrl + Api.updateUser, data: jsonData);
    var responseData = response.data;
    var returnData = postReceiveModelFromJson(jsonEncode(responseData));

    return returnData;
  }

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
