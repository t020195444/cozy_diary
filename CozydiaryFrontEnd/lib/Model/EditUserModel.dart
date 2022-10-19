// To parse this JSON data, do
//
//     final editUserModel = editUserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

EditUserModel editUserModelFromJson(String str) =>
    EditUserModel.fromJson(json.decode(str));

String editUserModelToJson(EditUserModel data) => json.encode(data.toJson());

class EditUserModel {
  EditUserModel({
    required this.googleId,
    required this.name,
    required this.sex,
    required this.introduction,
    required this.birth,
  });

  String googleId;
  String name;
  String sex;
  String introduction;
  DateTime birth;

  factory EditUserModel.fromJson(Map<String, dynamic> json) => EditUserModel(
        googleId: json["google_id"],
        name: json["name"],
        sex: json["sex"],
        introduction: json["introduction"],
        birth: DateTime.parse(json["birth"]),
      );

  Map<String, dynamic> toJson() => {
        "google_id": googleId,
        "name": name,
        "sex": sex,
        "introduction": introduction,
        "birth":
            "${birth.year.toString().padLeft(4, '0')}-${birth.month.toString().padLeft(2, '0')}-${birth.day.toString().padLeft(2, '0')}",
      };
}
