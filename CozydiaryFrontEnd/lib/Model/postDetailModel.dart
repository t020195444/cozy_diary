// To parse this JSON data, do
//
//     final postDetailModel = postDetailModelFromJson(jsonString);

import 'dart:convert';

PostDetailModel postDetailModelFromJson(String str) =>
    PostDetailModel.fromJson(json.decode(str));

String postDetailModelToJson(PostDetailModel data) =>
    json.encode(data.toJson());

class PostDetailModel {
  PostDetailModel({
    required this.data,
    required this.message,
    required this.status,
  });

  PostDetail data;
  String message;
  int status;

  factory PostDetailModel.fromJson(Map<String, dynamic> json) =>
      PostDetailModel(
        data: PostDetail.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class PostDetail {
  PostDetail({
    required this.pid,
    required this.uid,
    required this.title,
    required this.content,
    required this.likes,
    required this.collects,
    required this.postTime,
    required this.modifyTime,
    required this.cover,
    required this.cid,
    required this.postLng,
    required this.postLat,
    required this.postFiles,
    required this.comments,
  });

  int pid;
  String uid;
  String title;
  String content;
  int likes;
  int collects;
  DateTime postTime;
  dynamic modifyTime;
  String cover;
  int cid;
  double postLng;
  double postLat;
  List<PostFile> postFiles;
  List<Comment> comments;

  factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
        pid: json["pid"],
        uid: json["uid"],
        title: json["title"],
        content: json["content"],
        likes: json["likes"],
        collects: json["collects"],
        postTime: DateTime.parse(json["post_time"]),
        modifyTime: json["modify_time"],
        cover: json["cover"],
        cid: json["cid"],
        postLng: json["postLng"],
        postLat: json["postLat"],
        postFiles: List<PostFile>.from(
            json["postFiles"].map((x) => PostFile.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pid": pid,
        "uid": uid,
        "title": title,
        "content": content,
        "likes": likes,
        "collects": collects,
        "post_time": postTime.toIso8601String(),
        "modify_time": modifyTime,
        "cover": cover,
        "cid": cid,
        "postLng": postLng,
        "postLat": postLat,
        "postFiles": List<dynamic>.from(postFiles.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    required this.commentId,
    required this.text,
    required this.uid,
    required this.commentTime,
    required this.likes,
    required this.pid,
    required this.username,
    required this.pic,
    required this.repliesComments,
  });

  int commentId;
  String text;
  String uid;
  DateTime commentTime;
  int likes;
  int pid;
  String username;
  String pic;
  List<dynamic> repliesComments;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["commentId"],
        text: json["text"],
        uid: json["uid"],
        commentTime: DateTime.parse(json["commentTime"]),
        likes: json["likes"],
        pid: json["pid"],
        username: json["username"],
        pic: json["pic"],
        repliesComments:
            List<dynamic>.from(json["repliesComments"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "text": text,
        "uid": uid,
        "commentTime": commentTime.toIso8601String(),
        "likes": likes,
        "pid": pid,
        "username": username,
        "pic": pic,
        "repliesComments": List<dynamic>.from(repliesComments.map((x) => x)),
      };
}

class PostFile {
  PostFile({
    required this.fid,
    required this.postUrl,
  });

  int fid;
  String postUrl;

  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
        fid: json["fid"],
        postUrl: json["postUrl"],
      );

  Map<String, dynamic> toJson() => {
        "fid": fid,
        "postUrl": postUrl,
      };
}
