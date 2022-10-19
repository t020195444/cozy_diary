// To parse this JSON data, do
//
//     final trackerListModel = trackerListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TrackerListModel trackerListModelFromJson(String str) =>
    TrackerListModel.fromJson(json.decode(str));

String trackerListModelToJson(TrackerListModel data) =>
    json.encode(data.toJson());

class TrackerListModel {
  TrackerListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<TrackerList> data;
  String message;
  int status;

  factory TrackerListModel.fromJson(Map<String, dynamic> json) =>
      TrackerListModel(
        data: List<TrackerList>.from(
            json["data"].map((x) => TrackerList.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class TrackerList {
  TrackerList({
    required this.tracker1,
    required this.tracker2,
    required this.name,
    required this.trackTime,
    required this.pic,
  });

  String tracker1;
  String tracker2;
  String name;
  List<int> trackTime;
  String pic;

  factory TrackerList.fromJson(Map<String, dynamic> json) => TrackerList(
        tracker1: json["tracker1"],
        tracker2: json["tracker2"],
        name: json["name"],
        trackTime: List<int>.from(json["trackTime"].map((x) => x)),
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "tracker1": tracker1,
        "tracker2": tracker2,
        "name": name,
        "trackTime": List<dynamic>.from(trackTime.map((x) => x)),
        "pic": pic,
      };
}
