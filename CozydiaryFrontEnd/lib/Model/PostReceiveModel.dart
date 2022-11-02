// To parse this JSON data, do
//
//     final postReceiveModel = postReceiveModelFromJson(jsonString);

import 'dart:convert';

PostReceiveModel postReceiveModelFromJson(String str) =>
    PostReceiveModel.fromJson(json.decode(str));

String postReceiveModelToJson(PostReceiveModel data) =>
    json.encode(data.toJson());

class PostReceiveModel {
  PostReceiveModel({
    required this.data,
    required this.message,
    required this.status,
  });

  String data;
  String message;
  int status;

  factory PostReceiveModel.fromJson(Map<String, dynamic> json) =>
      PostReceiveModel(
        data: json["data"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "status": status,
      };
}
