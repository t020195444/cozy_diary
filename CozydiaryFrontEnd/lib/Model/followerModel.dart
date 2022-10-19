// To parse this JSON data, do
//
//     final addTrackerModel = addTrackerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AddFollowerModel addFollowerModelFromJson(String str) =>
    AddFollowerModel.fromJson(json.decode(str));

String addFollowerModelToJson(AddFollowerModel data) =>
    json.encode(data.toJson());

class AddFollowerModel {
  AddFollowerModel({
    required this.follower1,
    required this.follower2,
  });

  String follower1;
  String follower2;

  factory AddFollowerModel.fromJson(Map<String, dynamic> json) =>
      AddFollowerModel(
        follower1: json["follower1"],
        follower2: json["follower2"],
      );

  Map<String, dynamic> toJson() => {
        "follower1": follower1,
        "follower2": follower2,
      };
}
