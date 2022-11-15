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
}
