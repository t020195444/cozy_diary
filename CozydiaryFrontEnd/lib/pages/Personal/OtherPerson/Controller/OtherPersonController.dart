import 'package:cozydiary/Model/trackerListModel.dart';
import 'package:cozydiary/pages/Personal/Service/personalService.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:hive/hive.dart';
import '../../../../Model/catchPersonalModel.dart';
import '../../../../Model/postCoverModel.dart';
import '../../../../Model/trackerModel.dart';

class OtherPersonPageController extends GetxController {
  OtherPersonPageController({required this.otherUid});

  var constraintsHeight = 0.0.obs;
  var readmore = true.obs;
  var difference = 0.0;
  var isLoading = true.obs;
  final String otherUid;
  var userUid;
  var isFollow = false.obs;
  var userData = UserData(
          uid: 0,
          googleId: "",
          name: "",
          age: 0,
          sex: 0,
          introduction: "",
          pic: "",
          birth: [],
          createTime: [],
          email: "",
          tracker: [],
          follower: [],
          userCategoryList: [],
          picResize: "")
      .obs;
  var postCover = <PostCoverData>[].obs;
  var trackerList = <TrackerList>[];
  var collectedPostCover = <PostCoverData>[].obs;
  // int tid = -1;

  @override
  void onInit() {
    userUid = Hive.box("UidAndState").get("uid");
    getOtherUserData();
    getUserPostCover();
    getCollectedPostCover();
    super.onInit();
  }

  Future<void> getOtherUserData() async {
    try {
      isLoading(true);
      var UserData = await PersonalService.fetchUserData(otherUid);
      if (UserData != null) {
        if (UserData.status == 200) {
          userData.value = UserData.data;
          if (userData.value.follower.isEmpty) {
            isFollow(false);
          } else {
            for (Follower follower in userData.value.follower) {
              if (follower.tracker1 == userUid) {
                // tid = follower.tid;
                isFollow.value = true;
                break;
              } else {
                isFollow.value = false;
              }
              ;
            }
          }
        }
      }
    } finally {}
  }

  void getUserPostCover() async {
    try {
      var Posts = await PersonalService.fetchUserPostCover(otherUid);
      if (Posts != null) {
        if (Posts.status == 200) {
          postCover.value = Posts.data;
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void addTracker() async {
    try {
      AddTrackerModel trackerModel =
          AddTrackerModel(tracker1: userUid, tracker2: otherUid);
      var trackerJsonData = addTrackerModelToJson(trackerModel);
      var trackerResponse = await PersonalService.addTracker(trackerJsonData);
      if (trackerResponse == 200) {
        if (isFollow.value) {
          isFollow.value = false;
        } else
          isFollow.value = true;
      }
      ;
    } finally {}
  }

  void getTracker() async {
    try {
      var trackerResponse = await PersonalService.getTracker(otherUid);

      if (trackerResponse.message == 200) {
        trackerList = trackerResponse.data;
      }
    } finally {}
  }

  Future<void> getCollectedPostCover() async {
    try {
      isLoading(true);
      var Posts = await PersonalService.fetchUserCollectedPostCover(otherUid);
      if (Posts != null) {
        if (Posts.status == 200) {
          collectedPostCover.value = Posts.data;
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
