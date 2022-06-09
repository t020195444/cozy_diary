import 'dart:convert';

import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import '../../../Model/PostCoverModel.dart';

class PersonalService {
  final googleId = "";
  static Dio dio = Dio();
  static var getUserUri = 'http://140.131.114.166:80/getUser?gid=';
  static var getPostCoverForPersonalPageUri =
      'http://140.131.114.166:80/getPostCoverForPersonalPage?uid=';

  static Future<UserModel?> fetchUserData(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getUserUri + "116177189475554672826");
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
    var response =
        await dio.get(getPostCoverForPersonalPageUri + "116177189475554672826");
    print(response.data.toString());
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }
}
