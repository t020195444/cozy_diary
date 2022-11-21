import 'dart:convert';
import 'package:cozydiary/Model/categoryList.dart';
import 'package:dio/dio.dart';
import '../../../api.dart';

class RegisterService {
  static Future<int> registerUser(FormData formData) async {
    var response =
        await Dio().post(Api.ipUrl + Api.userRegister, data: formData);
    return response.statusCode!;
  }

  static Future<CategoryListModel> fetchCategoryList() async {
    var response = await Dio().get(Api.ipUrl + Api.getCategoryList);
    var encodeJsonData = json.encode(response.data);
    var returnData = categoryListModelFromJson(encodeJsonData);

    return returnData;
  }

  static Future<int> addCategory(String postData) async {
    var response =
        await Dio().post(Api.ipUrl + Api.addCategory, data: postData);
    return response.statusCode!;
  }

  static Future<CategoryListModel> fetchUserCategoryList(String uid) async {
    var response = await Dio().get(Api.ipUrl + Api.userCategoryList + uid);
    var encodeJsonData = json.encode(response.data);
    var returnData = categoryListModelFromJson(encodeJsonData);

    return returnData;
  }
}
