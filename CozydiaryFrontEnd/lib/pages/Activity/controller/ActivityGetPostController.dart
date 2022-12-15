import 'package:cozydiary/Model/catchPersonalModel.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:cozydiary/pages/Activity/service/ActivityService.dart';
import 'package:cozydiary/pages/Personal/Service/PersonalService.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:hive_flutter/hive_flutter.dart';

class ActivityGetPostController extends GetxController {
  var loginController = Get.put(LoginController());
  //variable
  RxInt activityId = 0.obs;
  RxString activityHolder = "".obs;
  RxString activityTitle = "".obs;
  RxString activityContent = "".obs;
  RxList<dynamic> activityTime = [].obs;
  RxList<dynamic> activityDeadlineTime = [].obs;
  RxDouble activityLat = 0.0.obs;
  RxDouble activityLng = 0.0.obs;
  RxString activityLocation = "".obs;
  RxInt activityLike = 0.obs;
  RxInt activityPeople = 0.obs;
  RxInt activityPayment = 0.obs;
  RxInt activitybudget = 0.obs;
  RxInt actId = 1.obs;
  int currentPage = 0;
  RxBool isPicked = false.obs;
  RxInt selectActType = 1.obs;
  RxInt selectActPayment = 1.obs;
  RxBool isLike = false.obs;
  RxBool isLoding = true.obs;
  RxString participantContent = "".obs;
  RxBool isParticipant = false.obs;
  RxList<dynamic> activityParticipant = [].obs; //參加人列表
  RxList<dynamic> checkActivityParticipant = [].obs; //審核列表
  RxList<dynamic> checkActivityHistory = [].obs; //歷史列表
  RxList<dynamic> activityHistoryList = [].obs; //歷史列表(存放詳細資料)
  RxList<dynamic> activityHistoryUser = [].obs; //歷史列表(存放個人詳細資料)
  RxList<dynamic> checkActivitLike = [].obs; //按讚列表

  Map updateParticipantData = {}; //參加人資料

  //刪除活動
  deleteActivity(String aid) async {
    await ActivityService().deleteActivity(aid);
    Get.back();
    update();
  }

  //按讚列表
  checkLikeList(String aid) async {
    checkActivitLike.value = await ActivityService().activityLikesList(aid);
    if (checkActivitLike.length == 0) {
      isLike.value = false;
    }
    for (var i = 0; i < checkActivitLike.length; i++) {
      if (checkActivitLike[i]['uid'] == Hive.box("UidAndState").get("uid")) {
        isLike.value = true;
        break;
      } else {
        isLike.value = false;
      }
    }

    // await ActivityPostService.getActivityDetail(activityId.value.toString());
    update();
  }

  //按讚
  checkLike(String uid) async {
    await ActivityService().checkLike(uid, activityId.value.toString());
    await checkLikeList(activityId.value.toString());
    await ActivityPostService.getActivityDetail(activityId.value.toString());
    update();
  }

  //審核 通過/未審核
  checkParticipant(String uid) async {
    await ActivityService().checkParticipant(uid, activityId.value.toString());
    update();
  }

  //獲取審核列表
  getActivityParticipantList() async {
    checkActivityParticipant.value =
        await ActivityService().getParticipantList(activityId.value.toString());
    update();
  }

  //獲取使用者參與活動列表
  getActivityHistoryList(String uid) async {
    activityHistoryList.value = [];
    activityHistoryUser.value = [];
    checkActivityHistory.value = await ActivityService().getHistoryList(uid);
    for (var i = 0; i < checkActivityHistory.length; i++) {
      activityHistoryList.add(await ActivityPostService.getActivityDetail(
          checkActivityHistory[i]['aid'].toString()));
    }
    for (var i = 0; i < activityHistoryList.length; i++) {
      activityHistoryUser.add(await ActivityService.getUserData(
          activityHistoryList[i]['holder'].toString()));
    }
    update();
  }

  //判斷是否已經報名
  isActivityParticipant(list) async {
    for (var i = 0; i < list.length; i++) {
      if (list[i]['participant'] == Hive.box("UidAndState").get("uid")) {
        isParticipant.value = true;
        break;
      } else {
        isParticipant.value = false;
      }
    }
  }

  //報名活動
  setUpdateParticipantData(id) async {
    updateParticipantData = {
      "participant": Hive.box("UidAndState").get("uid"),
      "reason": participantContent.value.toString(),
      "aid": id,
    };
    await ActivityService().updateParticipant(updateParticipantData); //呼叫報名API
    await ActivityPostService.getActivityDetail(id); //重新拉活動資訊
    update(); //更新
  }

  late final userData = UserData(
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
      picResize: "",
      userCategoryList: []).obs;

  getHolder(String data) async {
    var UserData = await PersonalService.fetchUserData(data);
    if (UserData != null) {
      if (UserData.status == 200) {
        userData.value = UserData.data;
      }
    }
  }

  @override
  void onInit() {
    participantContent.value = "";
    super.onInit();
  }

  Map actType = {
    1: "旅遊",
    2: "收藏",
    3: "社交",
    4: "戶外",
    5: "運動",
    6: "創作",
    7: "娛樂",
    8: "服務",
  };
  Map actPayment = {
    1: "我來請客",
    2: "你來買單",
    3: "各付各的",
    4: "平均分攤",
  };

  void setPost(data) async {
    activityId.value = data['data']['aid'];
    activityHolder.value = data['data']['holder'];
    activityTitle.value = data['data']['activityName'];
    activityContent.value = data['data']['holder'];
    activityTime.value = data['data']['activityTime'];
    activityDeadlineTime.value = data['data']['auditTime'];
    activityLat.value = data['data']['placeLat'];
    activityLng.value = data['data']['placeLng'];
    activityLike.value = data['data']['likes'];
    activityPeople.value = data['data']['participants'];
    activityPayment.value = data['data']['payment'];
    activitybudget.value = data['data']['budget'];
    actId.value = data['data']['actId'];
    selectActPayment.value = data['data']['payment'];
    activityParticipant.value = data['data']["participant"];
    isLoding.value = false;
  }
}
