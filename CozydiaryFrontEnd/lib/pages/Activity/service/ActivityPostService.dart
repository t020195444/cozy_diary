import 'dart:convert';
import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/api.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityGetPostController.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:dio/dio.dart';

class ActivityPostService {
  static Dio dio = Dio();
  static var getPostCoverUri =
      'http://140.131.114.166:80/getPostCoverByUserCategory?uid=116177189475554672826';
  static var writeActivityPostUri = 'http://140.131.114.166:80/addActivity';

  static var getpostController = Get.put(ActivityGetPostController());

  static Map activityDetailList = {};

  static getActivityDetail(String i) async {
    activityDetailList = {};
    var response = await dio.get(Api.ipUrl + Api.getActivityDetail + i);
    var data = response.data;

    List tempPathList = [];
    for (int j = 0; j < data['data']['activityFiles'].length; j++) {
      tempPathList.add(data['data']['activityFiles'][j]['activityUrl']);
    }
    getpostController.getHolder(data['data']['holder'].toString());
    getpostController.setPost(data);
    activityDetailList['holder'] = data['data']['holder'];
    activityDetailList['activityName'] = data['data']['activityName'];
    activityDetailList['placeLng'] = data['data']['placeLng'];
    activityDetailList['placeLat'] = data['data']['placeLat'];
    activityDetailList['likes'] = data['data']['likes'];

    activityDetailList['cover'] = data['data']['cover'];
    activityDetailList['actId'] = data['data']['actId'];
    activityDetailList['payment'] = data['data']['payment'];
    activityDetailList['budget'] = data['data']['budget'];
    activityDetailList['activityTime'] = data['data']['activityTime'];
    activityDetailList['auditTime'] = data['data']['auditTime'];
    activityDetailList['participants'] = data['data']['participants'];
    activityDetailList['participant'] = data['data']['participant'];
    activityDetailList['content'] = data['data']['content'];
    activityDetailList['url'] = tempPathList;

    return activityDetailList;
  }

  static List postPid = [];

  static Future<ActivityPostCoverModule> fetchPostCover() async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await dio.get(getPostCoverUri);
    ;
    var jsonString = response.data;
    var encodeJsonString = jsonEncode(jsonString);
    // var utf8JsonString = utf8Decoder.convert(response.bodyBytes);
    var fromJsonValue = activityPostCoverModuleFromJson(encodeJsonString);
    return fromJsonValue;
  }

  static Future<dynamic> postPostData(FormData formData) async {
    try {
      // ignore: unused_local_variable
      var response =
          await dio.post(Api.ipUrl + Api.addActivity, data: formData);
    } catch (e) {}

    return formData;
  }
}
