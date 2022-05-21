// To parse this JSON data, do
//
//     final postModule = postModuleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostModule postModuleFromJson(String str) => PostModule.fromJson(json.decode(str));

String postModuleToJson(PostModule data) => json.encode(data.toJson());

class PostModule {
    PostModule({
        required this.googleId,
        required this.name,
        required this.age,
        required this.sex,
        required this.introduction,
        required this.birth,
        required this.email,
        required this.pic,
    });

    String googleId;
    String name;
    int age;
    String sex;
    String introduction;
    DateTime birth;
    String email;
    String pic;

    factory PostModule.fromJson(Map<String, dynamic> json) => PostModule(
        googleId: json["google_id"],
        name: json["name"],
        age: json["age"],
        sex: json["sex"],
        introduction: json["introduction"],
        birth: DateTime.parse(json["birth"]),
        email: json["email"],
        pic: json["pic"],
    );

    Map<String, dynamic> toJson() => {
        "google_id": googleId,
        "name": name,
        "age": age,
        "sex": sex,
        "introduction": introduction,
        "birth": "${birth.year.toString().padLeft(4, '0')}-${birth.month.toString().padLeft(2, '0')}-${birth.day.toString().padLeft(2, '0')}",
        "email": email,
        "pic": pic,
    };
}

