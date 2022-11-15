// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.data,
    required this.message,
    required this.status,
  });

  UserData data;
  String message;
  int status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        data: UserData.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class UserData {
  UserData({
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
    required this.picResize,
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
  List<Follower> tracker;
  List<Follower> follower;
  List<UserCategoryList> userCategoryList;
  String picResize;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
      tracker:
          List<Follower>.from(json["tracker"].map((x) => Follower.fromJson(x))),
      follower: List<Follower>.from(
          json["follower"].map((x) => Follower.fromJson(x))),
      userCategoryList: List<UserCategoryList>.from(
          json["userCategoryList"].map((x) => UserCategoryList.fromJson(x))),
      picResize: json["picResize"]);

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
        "tracker": List<dynamic>.from(tracker.map((x) => x.toJson())),
        "follower": List<dynamic>.from(follower.map((x) => x.toJson())),
        "userCategoryList":
            List<dynamic>.from(userCategoryList.map((x) => x.toJson())),
        "picResize": picResize
      };
}

class Follower {
  Follower({
    required this.tid,
    required this.tracker1,
    required this.tracker2,
    required this.trackTime,
  });

  int tid;
  String tracker1;
  String tracker2;
  List<int> trackTime;

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
        tid: json["tid"],
        tracker1: json["tracker1"],
        tracker2: json["tracker2"],
        trackTime: List<int>.from(json["trackTime"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "tracker1": tracker1,
        "tracker2": tracker2,
        "trackTime": List<dynamic>.from(trackTime.map((x) => x)),
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
