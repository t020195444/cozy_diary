// To parse this JSON data, do
//
//     final addTrackerModel = addTrackerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddTrackerModel addTrackerModelFromJson(String str) =>
    AddTrackerModel.fromJson(json.decode(str));

String addTrackerModelToJson(AddTrackerModel data) =>
    json.encode(data.toJson());

class AddTrackerModel {
  AddTrackerModel({
    required this.follower1,
    required this.follower2,
  });

  String follower1;
  String follower2;

  factory AddTrackerModel.fromJson(Map<String, dynamic> json) =>
      AddTrackerModel(
        follower1: json["follower1"],
        follower2: json["follower2"],
      );

  Map<String, dynamic> toJson() => {
        "follower1": follower1,
        "follower2": follower2,
      };
}
