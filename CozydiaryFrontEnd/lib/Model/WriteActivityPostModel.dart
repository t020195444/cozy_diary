// To parse this JSON data, do
//
//     final writeActivityPostModel = writeActivityPostModelFromJson(jsonString);

import 'dart:convert';

WriteActivityPostModel writeActivityPostModelFromJson(String str) =>
    WriteActivityPostModel.fromJson(json.decode(str));

String writeActivityPostModelToJson(WriteActivityPostModel data) =>
    json.encode(data.toJson());

class WriteActivityPostModel {
  WriteActivityPostModel({
    required this.activity,
  });

  Activity activity;

  factory WriteActivityPostModel.fromJson(Map<String, dynamic> json) =>
      WriteActivityPostModel(
        activity: Activity.fromJson(json["activity"]),
      );

  Map<String, dynamic> toJson() => {
        "activity": activity.toJson(),
      };
}

class Activity {
  Activity({
    required this.holder,
    required this.placeLng,
    required this.placeLat,
    required this.likes,
    required this.activityName,
    required this.cover,
    required this.activityTime,
    required this.auditTime,
    required this.payment,
    required this.budget,
    required this.content,
    required this.actId,
  });

  String holder;
  double placeLng;
  double placeLat;
  int likes;
  String activityName;
  String cover;
  String activityTime;
  String auditTime;
  int payment;
  int budget;
  String content;
  int actId;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        holder: json["holder"],
        placeLng: json["placeLng"].toDouble(),
        placeLat: json["placeLat"].toDouble(),
        likes: json["likes"],
        activityName: json["activityName"],
        cover: json["cover"],
        activityTime: json["activityTime"],
        auditTime: json["auditTime"],
        payment: json["payment"],
        budget: json["budget"],
        content: json["content"],
        actId: json["actId"],
      );

  Map<String, dynamic> toJson() => {
        "holder": holder,
        "placeLng": placeLng,
        "placeLat": placeLat,
        "likes": likes,
        "activityName": activityName,
        "cover": cover,
        "activityTime": activityTime,
        "auditTime": auditTime,
        "payment": payment,
        "budget": budget,
        "content": content,
        "actId": actId,
      };
}

class ActivityPostFile {
  ActivityPostFile({
    required this.postUrl,
  });

  String postUrl;

  factory ActivityPostFile.fromJson(Map<String, dynamic> json) =>
      ActivityPostFile(
        postUrl: json["postUrl"],
      );

  Map<String, dynamic> toJson() => {
        "postUrl": postUrl,
      };
}
