import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/PostJsonService.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  SearchPageController();
  var searchResult = <PostCoverData>[].obs;
  var isSearching = false.obs;

  Future<void> searchPost(String keyText, String limit) async {
    var getData = await PostService.searchPost(keyText, limit);
    isSearching(true);
    try {
      if (getData != null && getData.message == 200) {
        searchResult.value = getData.data;
      }
    } finally {
      isSearching(false);
    }
  }
}
