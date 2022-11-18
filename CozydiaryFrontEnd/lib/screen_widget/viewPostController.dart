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
  RxMap currViewPostDetial = {}.obs;
  RxBool isLoading = true.obs;
  static var currPostCover;

  @override
  void onInit() {
    super.onInit();
  }

  postComments(String comment) async {
    var uid = Hive.box("UidAndState").get('uid');
    var commentJson = {};
    commentJson = {'text': comment, 'uid': uid, 'pid': currViewPostID};
    await postCommentData(commentJson);
    await getPostDetail();
  }

  Future<dynamic> postCommentData(Map formData) async {
    return await dio.post(Api.ipUrl + Api.postComment, data: formData);
  }

  getPostDetail() async {
    try {
      PostDetailModel data = await PostService.getPostDetail(currViewPostID);
      if (data.status == 200) {
        if (data != null) {
          currViewPostDetial.value = jsonDecode(postDetailModelToJson(data));
          currViewPostDetial.value = currViewPostDetial.value['data'];
          print(currViewPostDetial);
          currViewPostDetial.refresh();
        }
        likeButtonCheck();
      }
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  deleteComment(var cid) async {
    await dio.post(Api.ipUrl + Api.deleteComment + cid.toString());
    await getPostDetail();
  }

  updateComment(String cid, String text) async {
    await dio.post(
        Api.ipUrl + Api.updateComment + 'cid=' + cid + '&' + 'text=' + text);
    await getPostDetail();
  }

  updatePost(String pid, String title, String content) async {
    var updateJson = {};
    updateJson = {'pid': pid, 'title': title, 'content': content};
    await dio.post(Api.ipUrl + Api.updatePost, data: updateJson);
    await getPostDetail();
  }

  updateLikes(String pid, String uid) async {
    await dio
        .post(Api.ipUrl + Api.updatePostLikes + 'pid=' + pid + '&uid=' + uid);
    likeButtonCheck();
    getPostDetail();
  }

  deletePost(String pid) async {
    await dio.post(Api.ipUrl + Api.deletePost + pid);
  }

  RxBool buttonIsLiked = false.obs;
  likeButtonCheck() {
    var uid = Hive.box("UidAndState").get('uid');
    for (int i = 0; i < currViewPostDetial['likeList'].length; i++) {
      if (currViewPostDetial['likeList'][i]['uid'] == uid ||
          currViewPostDetial['likeList'][i]['type'] == 0) {
        buttonIsLiked.value = true;
      }
    }
  }
}
