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
  PostDetail(
      {required this.pid,
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
      required this.likeList});

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
  List<LikeList> likeList;

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
      comments:
          List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
      likeList: List<LikeList>.from(
          json["likeList"].map((x) => LikeList.fromJson(x))));

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
        "likeList": List<dynamic>.from(likeList.map((x) => x.toJson())),
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
  List<RepliesComment> repliesComments;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      commentId: json["commentId"],
      text: json["text"],
      uid: json["uid"],
      commentTime: DateTime.parse(json["commentTime"]),
      likes: json["likes"],
      pid: json["pid"],
      username: json["username"],
      pic: json["pic"],
      repliesComments: List<RepliesComment>.from(
          json["repliesComments"].map((x) => RepliesComment.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "text": text,
        "uid": uid,
        "commentTime": commentTime.toIso8601String(),
        "likes": likes,
        "pid": pid,
        "username": username,
        "pic": pic,
        "repliesComments":
            List<dynamic>.from(repliesComments.map((x) => x.toJson())),
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

class LikeList {
  LikeList(
      {required this.pid,
      required this.uid,
      required this.like_time,
      required this.type});

  int pid;
  String uid;
  String like_time;
  int type;

  factory LikeList.fromJson(Map<String, dynamic> json) => LikeList(
      pid: json["pid"],
      uid: json["uid"].toString(),
      like_time: json["like_time"],
      type: json['type']);

  Map<String, dynamic> toJson() =>
      {"pid": pid, "uid": uid, "like_time": like_time, "type": type};
}

class RepliesComment {
  RepliesComment({
    required this.rid,
    required this.text,
    required this.uid,
    required this.repliesTime,
    required this.likes,
    required this.commentId,
    required this.username,
    required this.pic,
  });

  int rid;
  String text;
  String uid;
  DateTime repliesTime;
  int likes;
  int commentId;
  String username;
  String pic;

  factory RepliesComment.fromJson(Map<String, dynamic> json) => RepliesComment(
        rid: json["rid"],
        text: json["text"],
        uid: json["uid"],
        repliesTime: DateTime.parse(json["repliesTime"]),
        likes: json["likes"],
        commentId: json["commentId"],
        username: json["username"],
        pic: json["pic"],
      );

  Map<String, dynamic> toJson() => {
        "rid": rid,
        "text": text,
        "uid": uid,
        "repliesTime": repliesTime.toIso8601String(),
        "likes": likes,
        "commentId": commentId,
        "username": username,
        "pic": pic,
      };
}
