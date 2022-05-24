import 'package:cozydiary/PostCoverController.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:http/http.dart' as http;
import 'Model/PostCoverModel.dart';
import 'package:get/get.dart';
import 'dart:convert';

class PostCoverService {
  static var client = http.Client();
  static var uri = 'http://172.20.10.3:8080/getPostCover';

  //測試資料
  /*
  static var jsonDATA = {
    "data": [
      {
        "userName": "楊哲邊",
        "userPic":
            "https://pgw.udn.com.tw/gw/photo.php?u=https://uc.udn.com.tw/photo/2022/04/14/0/16593636.png&x=0&y=0&sw=0&sh=0&sl=W&fw=1050",
        "likes": 2,
        "cover":
            "https://pgw.udn.com.tw/gw/photo.php?u=https://uc.udn.com.tw/photo/2022/04/14/0/16593636.png&x=0&y=0&sw=0&sh=0&sl=W&fw=1050",
        "title": "你好",
        "categoryName": "旅遊"
      },
      {
        "userName": "將和",
        "userPic":
            "https://thumbor.4gamers.com.tw/YwaEf7dUGMP4zZSAesSwmT1CIKE=/800x0/filters:extract_cover():no_upscale():quality(80)/https%3A%2F%2Fimg.4gamers.com.tw%2Fpuku-clone-version%2F1076d60dcb8321ce077f552ab7936e838c676fa4.jpg",
        "likes": 1,
        "cover":
            "https://thumbor.4gamers.com.tw/YwaEf7dUGMP4zZSAesSwmT1CIKE=/800x0/filters:extract_cover():no_upscale():quality(80)/https%3A%2F%2Fimg.4gamers.com.tw%2Fpuku-clone-version%2F1076d60dcb8321ce077f552ab7936e838c676fa4.jpg",
        "title": "航海王",
        "categoryName": "籃球"
      }
    ],
    "message": "獲取用戶貼文成功",
    "status": 200
  };*/

  static Future<PostCoverModule?> fetchPostCover() async {
    //測試資料
    // return postCoverModuleFromJson(json.encode(jsonDATA));
    var response = await client.get(Uri.parse(uri));
    if (response == 200) {
      var jsonString = response.body;
    } else {
      return null;
    }
  }
}
