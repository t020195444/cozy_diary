// To parse this JSON data, do
//
//     final activityPostCoverModule = activityPostCoverModuleFromJson(jsonString);

import 'dart:convert';

ActivityPostCoverModule activityPostCoverModuleFromJson(String str) =>
    ActivityPostCoverModule.fromJson(json.decode(str));

String activityPostCoverModuleToJson(ActivityPostCoverModule data) =>
    json.encode(data.toJson());

class ActivityPostCoverModule {
  ActivityPostCoverModule({
    required this.data,
    required this.message,
    required this.status,
  });
  List<Activity> data;
  String message;
  int status;

  factory ActivityPostCoverModule.fromJson(Map<String, dynamic> json) =>
      ActivityPostCoverModule(
        data:
            List<Activity>.from(json["data"].map((x) => Activity.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class Activity {
  Activity({
    required this.username,
    required this.placeLng,
    required this.placeLat,
    required this.likes,
    required this.activityName,
    required this.cover,
    required this.activityTime,
    required this.pic,

    // required this.postFiles,
  });

  String username;
  double placeLng;
  double placeLat;
  int likes;
  String activityName;
  String cover;
  String pic;
  List<int> activityTime;
  // List<ActivityPostFile> postFiles;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        username: json["username"],
        placeLng: json["placeLng"].toDouble(),
        placeLat: json["placeLat"].toDouble(),
        likes: json["likes"],
        pic: json["pic"],
        activityName: json["activityName"],
        cover: json["cover"],
        activityTime: List<int>.from(json["activityTime"].map((x) => x)),
        // postFiles: List<ActivityPostFile>.from(
        //     json["postFiles"].map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "placeLng": placeLng,
        "placeLat": placeLat,
        "pic": pic,
        "likes": likes,
        "activityName": activityName,
        "cover": cover,
        "activityTime": List<int>.from(activityTime.map((x) => x)),
        // "postFiles": List<dynamic>.from(postFiles.map((x) => x.toJson())),
      };
}
