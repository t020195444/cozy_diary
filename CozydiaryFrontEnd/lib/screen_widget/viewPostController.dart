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
      postTime: DateTime(0),
      modifyTime: 0,
      cover: "",
      cid: 0,
      postLng: 0,
      postLat: 0,
      postFiles: <PostFile>[],
      comments: <Comment>[]).obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  postComments(String comment) async {
    var uid = Hive.box("UidAndState").get('uid');
    var commentJson = {};
    commentJson = {'text': comment, 'uid': uid, 'pid': currViewPostID};
    postCommentData(commentJson);
    PostService.getPostDetail(currViewPostID);
    currViewPostDetial.refresh();
  }

  Future<dynamic> postCommentData(Map formData) async {
    return await dio.post(Api.ipUrl + Api.postComment, data: formData);
  }

  getCommentTime(int i) {
    var commentTime = currViewPostDetial.value.comments[i].commentTime;

    var now = DateTime.now();
  }

  void getPostDetail() async {
    isLoading(true);
    try {
      PostDetailModel data = await PostService.getPostDetail(currViewPostID);
      // print(postDetailModelToJson(data));
      if (data.status == 200) {
        if (data != null) {
          currViewPostDetial.value = data.data;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
