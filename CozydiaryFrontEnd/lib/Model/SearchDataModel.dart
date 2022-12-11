// To parse this JSON data, do
//
//     final searchDataModel = searchDataModelFromJson(jsonString);

import 'dart:convert';

SearchDataModel searchDataModelFromJson(String str) =>
    SearchDataModel.fromJson(json.decode(str));

String searchDataModelToJson(SearchDataModel data) =>
    json.encode(data.toJson());

class SearchDataModel {
  SearchDataModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<SearchData> data;
  String message;
  int status;

  factory SearchDataModel.fromJson(Map<String, dynamic> json) =>
      SearchDataModel(
        data: List<SearchData>.from(
            json["data"].map((x) => SearchData.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class SearchData {
  SearchData({
    required this.pid,
    required this.uid,
    required this.title,
    required this.cover,
    required this.cid,
  });

  int pid;
  String uid;
  String title;
  String cover;
  int cid;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        pid: json["pid"],
        uid: json["uid"],
        title: json["title"],
        cover: json["cover"],
        cid: json["cid"],
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "title": title,
        "cover": cover,
        "cid": cid,
      };
}
