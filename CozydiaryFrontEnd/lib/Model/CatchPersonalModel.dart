// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.data,
    required this.message,
    required this.status,
  });

  Data data;
  String message;
  int status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  Data({
    required this.uid,
    required this.googleId,
    required this.name,
    required this.age,
    required this.sex,
    required this.introduction,
    required this.pic,
    required this.birth,
    required this.createTime,
    required this.email,
    required this.tracker,
    required this.follower,
    required this.userCategoryList,
  });

  int uid;
  String googleId;
  String name;
  int age;
  int sex;
  String introduction;
  String pic;
  List<int> birth;
  List<int> createTime;
  String email;
  List<dynamic> tracker;
  List<Follower> follower;
  List<UserCategoryList> userCategoryList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        uid: json["uid"],
        googleId: json["googleId"],
        name: json["name"],
        age: json["age"],
        sex: json["sex"],
        introduction: json["introduction"],
        pic: json["pic"],
        birth: List<int>.from(json["birth"].map((x) => x)),
        createTime: List<int>.from(json["create_time"].map((x) => x)),
        email: json["email"],
        tracker: List<dynamic>.from(json["tracker"].map((x) => x)),
        follower: List<Follower>.from(
            json["follower"].map((x) => Follower.fromJson(x))),
        userCategoryList: List<UserCategoryList>.from(
            json["userCategoryList"].map((x) => UserCategoryList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "googleId": googleId,
        "name": name,
        "age": age,
        "sex": sex,
        "introduction": introduction,
        "pic": pic,
        "birth": List<dynamic>.from(birth.map((x) => x)),
        "create_time": List<dynamic>.from(createTime.map((x) => x)),
        "email": email,
        "tracker": List<dynamic>.from(tracker.map((x) => x)),
        "follower": List<dynamic>.from(follower.map((x) => x.toJson())),
        "userCategoryList":
            List<dynamic>.from(userCategoryList.map((x) => x.toJson())),
      };
}

class Follower {
  Follower({
    required this.fid,
    required this.follower1,
    required this.follower2,
    required this.followTime,
  });

  int fid;
  String follower1;
  String follower2;
  List<int> followTime;

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        fid: json["fid"],
        follower1: json["follower1"].toString(),
        follower2: json["follower2"].toString(),
        followTime: List<int>.from(json["follow_time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "follower1": follower1,
        "follower2": follower2,
        "follow_time": List<dynamic>.from(followTime.map((x) => x)),
      };
}

class UserCategoryList {
  UserCategoryList({
    required this.uid,
    required this.cid,
  });

  String uid;
  int cid;

  factory UserCategoryList.fromJson(Map<String, dynamic> json) =>
      UserCategoryList(
        uid: json["uid"],
        cid: json["cid"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "cid": cid,
      };
}
