import 'package:hive/hive.dart';
import "package:get/get.dart" hide FormData, MultipartFile, Response;
import '../../../Model/categoryList.dart';
import '../../../Model/postCoverModel.dart';
import '../../../PostJsonService.dart';
import '../../Register/Service/registerService.dart';

class CategoryPostController extends GetxController {
  final String cid;
  var postCover = <PostCoverData>[].obs;
  var isLoading = false.obs;
  var userCategory = <Category>[];
  String uid = Hive.box("UidAndState").get("uid");

  CategoryPostController({required this.cid});

  @override
  void onInit() {
    setUserCategory();
    getPostCover(cid);
    super.onInit();
  }

  Future<void> getPostCover(String cid) async {
    print("aksdjlsakjlsajdsalkd");
    isLoading(true);
    if (cid == "") {
      try {
        var Posts = await PostService.fetchPostCover(uid);
        if (Posts != null) {
          if (Posts.status == 200) {
            postCover.value = Posts.data;
          }
        }
      } finally {
        isLoading(false);
      }
    } else {
      try {
        var Posts = await PostService.fetchCategoryPostCover(cid);
        if (Posts != null) {
          if (Posts.status == 200) {
            postCover.value = Posts.data;
          }
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> setUserCategory() async {
    CategoryListModel category = await RegisterService.fetchCategoryList();
    try {
      if (category.status == 200) {
        userCategory = category.data;
      }
    } finally {}
  }
}
