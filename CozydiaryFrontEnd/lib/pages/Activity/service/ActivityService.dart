import 'dart:convert';

import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:cozydiary/api.dart';
import 'package:dio/dio.dart';

class ActivityService {
  static Dio dio = Dio();
  static var getActivityUri =
      'http://140.131.114.166:80/getActivityCover?option=2';

  addActivity(jsonString) async {
    await updateParticipant(jsonString);
  }

  //報名活動
  Future<dynamic> updateParticipant(Map formData) async {
    return await dio.post(Api.ipUrl + Api.updateParticipant, data: formData);
  }

  static Future<UserModel?> fetchActivityData() async {
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
