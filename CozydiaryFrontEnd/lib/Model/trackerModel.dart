// To parse this JSON data, do
//
//     final addTrackerModel = addTrackerModelFromJson(jsonString);

import 'dart:convert';

AddTrackerModel addTrackerModelFromJson(String str) =>
    AddTrackerModel.fromJson(json.decode(str));

String addTrackerModelToJson(AddTrackerModel data) =>
    json.encode(data.toJson());

class AddTrackerModel {
  AddTrackerModel({
    required this.tracker1,
    required this.tracker2,
  });

  String tracker1;
  String tracker2;

  factory AddTrackerModel.fromJson(Map<String, dynamic> json) =>
      AddTrackerModel(
        tracker1: json["tracker1"],
        tracker2: json["tracker2"],
      );

  Map<String, dynamic> toJson() => {
        "tracker1": tracker1,
        "tracker2": tracker2,
      };
}
