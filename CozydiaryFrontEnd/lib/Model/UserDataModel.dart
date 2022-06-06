import 'dart:convert';

UserDataModel userDataModelFromJson(String str) =>
    UserDataModel.fromJson(json.decode(str));

String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    required this.user,
  });

  User user;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.googleId,
    required this.name,
    required this.sex,
    required this.introduction,
    required this.birth,
    required this.email,
    required this.pic,
  });

  String googleId;
  String name;
  String sex;
  String introduction;
  DateTime birth;
  String email;
  String pic;

  factory User.fromJson(Map<String, dynamic> json) => User(
        googleId: json["googleId"],
        name: json["name"],
        sex: json["sex"],
        introduction: json["introduction"],
        birth: DateTime.parse(json["birth"]),
        email: json["email"],
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "googleId": googleId,
        "name": name,
        "sex": sex,
        "introduction": introduction,
        "birth":
            "${birth.year.toString().padLeft(4, '0')}-${birth.month.toString().padLeft(2, '0')}-${birth.day.toString().padLeft(2, '0')}",
        "email": email,
        "pic": pic,
      };
}
