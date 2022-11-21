import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Activity/service/ActivityService.dart';
import "package:get/get.dart" hide FormData, MultipartFile, Response;

class ActivityController extends GetxController {
  var loginController = Get.put(LoginController());
  var postCover = <Activity>[].obs;
  var localPostCover = <Activity>[].obs;

  var isLoading = true.obs;
  var isLocalLoading = true.obs;

  late Post postsContext;
  var title = "".obs;
  var content = "".obs;
  var cover = "".obs;
  var postFiles = <PostFile>[];
  var cid = 0.obs;
  var imageFile = <String>[].obs;

  @override
  void onInit() {
    getPostCover();

    Activity(
      aid: 0,
      username: "",
      placeLng: 0,
      placeLat: 0,
      likes: 0,
      activityName: "",
      cover: "",
      pic: "",
      activityTime: [],
    );
    super.onInit();
  }

  getPostCover() async {
    try {
      isLoading(true);
      var Posts = await ActivityService.fetchPostCover();
      if (Posts != null) {
        if (Posts.status == 200) {
          postCover.value = Posts.data;
        }
      }
    } finally {
      isLoading(false);
    }
  }

  getLocalPostCover(String placeLat, String placeLng) async {
    try {
      isLocalLoading(true);
      var Posts = await ActivityService.fetchLocalPostCover(placeLat, placeLng);
      if (Posts != null) {
        if (Posts.status == 200) {
          localPostCover.value = Posts.data;
        }
      }
    } finally {
      isLocalLoading(false);
    }
  }
}
