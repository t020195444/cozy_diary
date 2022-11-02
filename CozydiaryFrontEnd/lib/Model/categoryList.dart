// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    required this.data,
    required this.message,
    required this.status,
  });

  List<Category> data;
  String message;
  int status;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        data:
            List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class Category {
  Category({
    required this.cid,
    required this.category,
  });

  int cid;
  String category;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        cid: json["cid"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "category": category,
      };
}
