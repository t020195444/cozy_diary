import 'dart:convert';

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
  final String pid;
  ViewPostController({required this.pid});

  @override
  void onInit() async {
    currViewPostID = pid;
    await getPostDetail();
    super.onInit();
  }

  //抓貼文資料
  getPostDetail() async {
    try {
      PostDetailModel data = await PostService.getPostDetail(currViewPostID);

      if (data.status == 200) {
        if (data.data != null) {
          currViewPostDetial.value = jsonDecode(postDetailModelToJson(data));
          currViewPostDetial.value = currViewPostDetial.value['data'];

          currViewPostDetial.refresh();
        }
        print(currViewPostDetial);
        likeButtonCheck();
      }
      isLoading(true);
    } finally {
      isLoading(false);
    }
  }

  //新增留言
  postComments(String comment) async {
    var uid = Hive.box("UidAndState").get('uid');
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
    var uid = Hive.box("UidAndState").get('uid');
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

  //按讚偵測
  RxBool buttonIsLiked = false.obs;
  likeButtonCheck() {
    var uid = Hive.box("UidAndState").get('uid');

    for (int i = 0; i < currViewPostDetial['likeList'].length; i++) {
      if (currViewPostDetial['likeList'][i]['uid'] == uid) {
        buttonIsLiked.value = true;
      }
    }
    if (currViewPostDetial['likeList'].length == 0) {
      buttonIsLiked.value = false;
    }
  }
}
