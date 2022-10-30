import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:hive/hive.dart';

import '../PostJsonService.dart';
import '../api.dart';

class viewPostController extends GetxController {
  Dio dio = Dio();

  static String currViewPostID = '';
  static RxMap currViewPostDetial = {}.obs;
  postComments(String comment) async {
    print(currViewPostDetial);
    var uid = Hive.box("UidAndState").get('uid');
    var commentJson = {};
    commentJson = {'text': comment, 'uid': uid, 'pid': currViewPostID};
    print(commentJson);
    postCommentData(commentJson);
    PostService.getPostDetail(currViewPostID);
    currViewPostDetial.refresh();
    print(currViewPostDetial);
  }

  Future<dynamic> postCommentData(Map formData) async {
    return await dio.post(Api.ipUrl + Api.postComment, data: formData);
  }

  getCommentTime(int i) {
    print(currViewPostDetial['data']['comments']);
    var commentTime = currViewPostDetial['data']['comments'][i]['commentTime'];
    var parseTime = DateTime.parse(commentTime);
    var now = DateTime.now();
    print(commentTime);
    print(parseTime);
    print(now);

    print(now.difference(parseTime).inHours);
  }
}
