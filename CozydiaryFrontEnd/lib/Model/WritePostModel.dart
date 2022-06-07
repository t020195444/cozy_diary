// To parse this JSON data, do
//
//     final writePostModule = writePostModuleFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WritePostModule writePostModuleFromJson(String str) =>
    WritePostModule.fromJson(json.decode(str));

String writePostModuleToJson(WritePostModule data) =>
    json.encode(data.toJson());

class WritePostModule {
  WritePostModule({
    required this.post,
  });

  Post post;

  factory WritePostModule.fromJson(Map<String, dynamic> json) =>
      WritePostModule(
        post: Post.fromJson(json["post"]),
      );

  Map<String, dynamic> toJson() => {
        "post": post.toJson(),
      };
}

class Post {
  Post({
    required this.uid,
    required this.title,
    required this.content,
    required this.likes,
    required this.collects,
    required this.cover,
    required this.cid,
    required this.postFiles,
  });

  String uid;
  String title;
  String content;
  int likes;
  int collects;
  String cover;
  int cid;
  List<PostFile> postFiles;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        uid: json["uid"],
        title: json["title"],
        content: json["content"],
        likes: json["likes"],
        collects: json["collects"],
        cover: json["cover"],
        cid: json["cid"],
        postFiles: List<PostFile>.from(
            json["postFiles"].map((x) => PostFile.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "title": title,
        "content": content,
        "likes": likes,
        "collects": collects,
        "cover": cover,
        "cid": cid,
        "postFiles": List<dynamic>.from(postFiles.map((x) => x.toJson())),
      };
}

class PostFile {
  PostFile({
    required this.postUrl,
  });

  String postUrl;

  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
        postUrl: json["postUrl"],
      );

  Map<String, dynamic> toJson() => {
        "postUrl": postUrl,
      };
}
