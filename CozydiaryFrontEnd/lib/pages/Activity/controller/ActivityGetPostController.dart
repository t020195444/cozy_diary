import 'package:cozydiary/Model/catchPersonalModel.dart';
import 'package:cozydiary/login_controller.dart';
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
  // RxList<dynamic> activityPeople = [].obs;
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

  Map updateParticipantData = {};

  setUpdateParticipantData() async {
    updateParticipantData = {
      "participant": Hive.box("UidAndState").get("uid"),
      "reason": participantContent.value.toString(),
      "aid": activityId.value,
    };
    print(updateParticipantData.toString());
    await ActivityService().addActivity(updateParticipantData);
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

  getHolder(data) async {
    var UserData = await PersonalService.fetchUserData(data);
    if (UserData != null) {
      if (UserData.status == 200) {
        userData.value = UserData.data;
      }
    }
  }

  @override
  void onInit() {
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
    // activityPeople.value = data['data']['participants'];
    activityPayment.value = data['data']['payment'];
    activitybudget.value = data['data']['budget'];
    actId.value = data['data']['actId'];
    selectActPayment.value = data['data']['payment'];
    isLoding.value = false;
  }
}