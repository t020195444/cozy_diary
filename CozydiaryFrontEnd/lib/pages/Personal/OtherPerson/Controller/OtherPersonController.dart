import 'package:cozydiary/Model/trackerListModel.dart';
import 'package:cozydiary/pages/Personal/Service/personalService.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:hive/hive.dart';
import '../../../../Model/catchPersonalModel.dart';
import '../../../../Model/postCoverModel.dart';
import '../../../../Model/trackerModel.dart';

class OtherPersonPageController extends GetxController {
  var constraintsHeight = 0.0.obs;
  var readmore = true.obs;
  var difference = 0.0;
  var isLoading = true.obs;
  var otherUid = "";
  var userUid = "";
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
      userCategoryList: []).obs;
  var postCover = <PostCoverData>[].obs;
  var trackerList = <TrackerList>[];
  int tid = -1;
  @override
  void onInit() {
    userUid = Hive.box("UidAndState").get("uid");

    super.onInit();
  }

  void getOtherUserData() async {
    try {
      isLoading(true);
      var UserData = await PersonalService.fetchUserData(otherUid);
      if (UserData != null) {
        if (UserData.status == 200) {
          userData.value = UserData.data;

          for (Follower follower in userData.value.follower) {
            if (follower.tracker1 == userUid) {
              tid = follower.tid;
              isFollow.value = true;
              break;
            } else {
              isFollow.value = false;
            }
            ;
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

  void getConstraintsHeight(var height) {
    constraintsHeight.value = height;
    update();
  }

  void onTabReadmore() {
    readmore.value = !readmore.value;
    print(readmore.value);
  }

  void increaseAppbarHeight() {
    constraintsHeight.value = constraintsHeight.value + difference;
  }

  void reduceAppbarHeight() {
    constraintsHeight.value = constraintsHeight.value - difference;
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

  void deleteTracker() async {
    try {
      print(tid);
      if (tid != -1) {
        var trakerResponse =
            await PersonalService.deleteTracker(tid.toString());
        isFollow.value = false;
      } else
        print("沒有追蹤");
    } finally {}
  }

  void getTracker() async {
    try {
      var trackerResponse = await PersonalService.getTracker(otherUid);

      if (trackerResponse != null) {
        if (trackerResponse.message == 200) {
          trackerList = trackerResponse.data;
          print(trackerList[0]);
        }
      }
    } finally {}
  }
}
