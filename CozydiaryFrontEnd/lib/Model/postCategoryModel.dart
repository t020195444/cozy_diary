// To parse this JSON data, do
//
//     final postCategoryModel = postCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostCategoryModel postCategoryModelFromJson(String str) =>
    PostCategoryModel.fromJson(json.decode(str));

String postCategoryModelToJson(PostCategoryModel data) =>
    json.encode(data.toJson());

class PostCategoryModel {
  PostCategoryModel({
    required this.userCategory,
  });

  List<UserCategory> userCategory;

  factory PostCategoryModel.fromJson(Map<String, dynamic> json) =>
      PostCategoryModel(
        userCategory: List<UserCategory>.from(
            json["userCategory"].map((x) => UserCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userCategory": List<dynamic>.from(userCategory.map((x) => x.toJson())),
      };
}

class UserCategory {
  UserCategory({
    required this.uid,
    required this.cid,
  });

  String uid;
  int cid;

  factory UserCategory.fromJson(Map<String, dynamic> json) => UserCategory(
        uid: json["uid"],
        cid: json["cid"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "cid": cid,
      };
}
