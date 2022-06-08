import 'dart:convert';

import 'package:cozydiary/Model/CatchPersonalModel.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

import '../../../Model/PostCoverModel.dart';

class PersonalService {
  final googleId = "";
  static Dio dio = Dio();
  static var getUserUri = 'http://localhost:8080/getUser?gid=';
  static var getPostCoverForPersonalPageUri =
      'getPostCoverForPersonalPage?uid=';

  static Future<UserModel?> fetchUserData(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getUserUri + id);
    print(response.data.toString());
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = userModelFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<PostCoverModule?> fetchUserPostCover(String id) async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getPostCoverForPersonalPageUri + id);
    print(response.data.toString());
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = postCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }
}
