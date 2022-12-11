import 'package:cozydiary/Model/SearchDataModel.dart';
import 'package:cozydiary/PostJsonService.dart';
import 'package:get/get.dart';

import '../../Personal/Service/PersonalService.dart';

class SearchPageController extends GetxController {
  SearchPageController();
  var searchResult = <SearchData>[].obs;
  var isSearching = false.obs;
  var username = "";
  var userPic = "";

  Future<void> searchPost(String keyText, String limit) async {
    isSearching(true);
    var getData = await PostService.searchPost(keyText, limit);

    try {
      if (getData != null && getData.status == 200) {
        searchResult.value = getData.data;
      }
    } finally {
      isSearching(false);
    }
  }

  Future<void> getOtherUserData(int index) async {
    try {
      var UserData =
          // ignore: invalid_use_of_protected_member
          await PersonalService.fetchUserData(searchResult.value[index].uid);
      if (UserData != null) {
        if (UserData.status == 200) {
          username = UserData.data.name;
          userPic = UserData.data.pic;
        }
      }
    } finally {}
  }
}
