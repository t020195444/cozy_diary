import 'dart:convert';

RegisterUserDataModel registerUserDataModelFromJson(String str) =>
    RegisterUserDataModel.fromJson(json.decode(str));

String registerUserDataModelToJson(RegisterUserDataModel data) =>
    json.encode(data.toJson());

class RegisterUserDataModel {
  RegisterUserDataModel({
    required this.user,
  });

  RegisterUserData user;

  factory RegisterUserDataModel.fromJson(Map<String, dynamic> json) =>
      RegisterUserDataModel(
        user: RegisterUserData.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
      };
}

class RegisterUserData {
  RegisterUserData({
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

  factory RegisterUserData.fromJson(Map<String, dynamic> json) =>
      RegisterUserData(
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
