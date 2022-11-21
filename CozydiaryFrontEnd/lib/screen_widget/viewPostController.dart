import 'dart:convert';

import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:hive/hive.dart';

import '../Model/postDetailModel.dart';
import '../PostJsonService.dart';
import '../api.dart';

class ViewPostController extends GetxController {
  Dio dio = Dio();

  String currViewPostID = '';
  var currViewPostDetial = PostDetail(
      pid: 0,
      uid: "",
      title: "",
      content: "",
      likes: 0,
      collects: 0,
      postTime: DateTime.now(),
      modifyTime: "",
      cover: "",
      cid: 0,
      postLng: 0,
      postLat: 0,
      postFiles: [],
      comments: [],
      likeList: []).obs;
  RxBool isLoading = true.obs;
  var uid = Hive.box("UidAndState").get('uid');
  //按讚偵測
  RxBool buttonIsLiked = false.obs;
  var buttonIsCollected = false.obs;
  static var currPostCover;

  @override
  void onInit() {
    super.onInit();
  }

  //抓貼文資料
  getPostDetail() async {
    try {
      PostDetailModel data = await PostService.getPostDetail(currViewPostID);
      if (data.status == 200) {
        if (data != null) {
          currViewPostDetial.value = data.data;
          print(postDetailModelToJson(data));
          currViewPostDetial.refresh();
        }
        likeButtonCheck();
      }
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  //新增留言
  postComments(String comment) async {
    var commentJson = {};
    commentJson = {'text': comment, 'uid': uid, 'pid': currViewPostID};
    await postCommentData(commentJson);
    await getPostDetail();
  }

  //留言api
  Future<dynamic> postCommentData(Map formData) async {
    return await dio.post(Api.ipUrl + Api.postComment, data: formData);
  }

  //刪除留言
  deleteComment(var cid) async {
    await dio.post(Api.ipUrl + Api.deleteComment + cid.toString());
    await getPostDetail();
  }

  // 更新留言
  updateComment(String cid, String text) async {
    await dio.post(
        Api.ipUrl + Api.updateComment + 'cid=' + cid + '&' + 'text=' + text);
    await getPostDetail();
  }

  //新增附屬留言
  postAdditionComment(String comment, String cid) async {
    var commentJson = {};
    commentJson = {'text': comment, 'uid': uid, 'cid': cid};
    print(commentJson);
    await postAdditionCommentData(commentJson);
    await getPostDetail();
  }

  //附屬留言api
  Future<dynamic> postAdditionCommentData(Map formData) async {
    return await dio.post(Api.ipUrl + Api.postAdditionComment, data: formData);
  }

  //刪除附屬留言

  //更新附屬留言

  // 更新貼文
  updatePost(String pid, String title, String content) async {
    var updateJson = {};
    updateJson = {'pid': pid, 'title': title, 'content': content};
    await dio.post(Api.ipUrl + Api.updatePost, data: updateJson);
    await getPostDetail();
  }

  // 刪除貼文
  deletePost(String pid) async {
    await dio.post(Api.ipUrl + Api.deletePost + pid);
  }

  // 按讚
  updateLikes(String pid, String uid) async {
    await dio
        .post(Api.ipUrl + Api.updatePostLikes + 'pid=' + pid + '&uid=' + uid);
    await getPostDetail();
    likeButtonCheck();
  }

  updateCollects(String pid, String uid) async {
    await dio
        .post(Api.ipUrl + Api.updateCollects + 'pid=' + pid + '&uid=' + uid);
    await getPostDetail();
    likeButtonCheck();
  }

  likeButtonCheck() {
    if (currViewPostDetial.value.likeList.length == 0) {
      buttonIsLiked.value = false;
    }
    currViewPostDetial.value.likeList.forEach((element) {
      if (element.uid == uid) {
        buttonIsLiked.value = true;
      }
    });
  }

  collectButtonCheck() {
    if (currViewPostDetial.value.likeList.length == 0) {
      buttonIsLiked.value = false;
    }
    currViewPostDetial.value.likeList.forEach((element) {
      if (element.uid == uid) {
        buttonIsLiked.value = true;
      }
    });
  }
}
