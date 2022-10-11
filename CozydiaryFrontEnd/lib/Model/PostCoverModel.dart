// To parse this JSON data, do
//
//     final previewPostModule = previewPostModuleFromJson(jsonString);

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
  PostCoverData(
      {required this.pid,
      required this.username,
      required this.pic,
      required this.likes,
      required this.cover,
      required this.title,
      required this.uid
      // required this.categoryName,
      });
  int pid;
  String username;
  String pic;
  int likes;
  String cover;
  String title;
  String uid;
  // String categoryName;

  factory PostCoverData.fromJson(Map<String, dynamic> json) => PostCoverData(
      pid: json["pid"],
      username: json["username"],
      pic: json["pic"],
      likes: json["likes"],
      cover: json["cover"],
      title: json["title"],
      uid: json["uid"]
      // categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "username": username,
        "pic": pic,
        "likes": likes,
        "cover": cover,
        "title": title,
        "uid": uid,
        // "categoryName": categoryName,
      };
}
