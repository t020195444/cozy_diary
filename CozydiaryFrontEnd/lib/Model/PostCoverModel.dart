// To parse this JSON data, do
//
//     final previewPostModule = previewPostModuleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostCoverModule postCoverModuleFromJson(String str) =>
    PostCoverModule.fromJson(json.decode(str));

String postCoverModuleToJson(PostCoverModule data) =>
    json.encode(data.toJson());

class PostCoverModule {
  PostCoverModule({
    required this.data,
    required this.message,
    required this.status,
  });

  List<PostCoverData> data;
  String message;
  int status;

  factory PostCoverModule.fromJson(Map<String, dynamic> json) =>
      PostCoverModule(
        data: List<PostCoverData>.from(
            json["data"].map((x) => PostCoverData.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class PostCoverData {
  PostCoverData({
    required this.userName,
    required this.userPic,
    required this.likes,
    required this.cover,
    required this.title,
    required this.categoryName,
  });

  String userName;
  String userPic;
  int likes;
  String cover;
  String title;
  String categoryName;

  factory PostCoverData.fromJson(Map<String, dynamic> json) => PostCoverData(
        userName: json["userName"],
        userPic: json["userPic"],
        likes: json["likes"],
        cover: json["cover"],
        title: json["title"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "userPic": userPic,
        "likes": likes,
        "cover": cover,
        "title": title,
        "categoryName": categoryName,
      };
}
