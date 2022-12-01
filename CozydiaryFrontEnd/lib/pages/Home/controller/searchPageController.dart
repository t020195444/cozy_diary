import 'package:cozydiary/Model/SearchDataModel.dart';
import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/Model/postDetailModel.dart';
import 'package:cozydiary/PostJsonService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../Personal/Service/PersonalService.dart';

class SearchPageController extends GetxController {
  SearchPageController();
  var searchResult = <SearchData>[].obs;
  var isSearching = false.obs;
  var username = "";
  var userPic = "";

  Future<void> searchPost(String keyText, String limit) async {
    var getData = await PostService.searchPost(keyText, limit);
    print(getData);
    isSearching(true);
    try {
      if (getData != null && getData.message == 200) {
        searchResult.value = getData.data;
      }
    } finally {
      isSearching(false);
    }
  }

  Future<void> getOtherUserData(int index) async {
    try {
      var UserData =
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
