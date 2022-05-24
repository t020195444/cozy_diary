import 'dart:convert';

import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/PostCoverController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostCoverTest extends StatelessWidget {
  const PostCoverTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var jsonDATA = {
      "data": [
        {
          "userName": "楊哲邊",
          "userPic": "Users/User/Desktop/加密貨幣筆記/趨勢分析 重點!!!.png",
          "likes": 2,
          "cover":
              "/Users/yangzhelun/Desktop/development/uploadFile/116177189475554672811/kobe2.jpeg",
          "title": "你好",
          "categoryName": "旅遊"
        },
        {
          "userName": "將和",
          "userPic":
              "/Users/yangzhelun/Desktop/development/uploadFile/116177189475554672811/kobe2.jpeg",
          "likes": 1,
          "cover":
              "/Users/yangzhelun/Desktop/development/uploadFile/116177189475554672811/kobe2.jpeg",
          "title": "航海王",
          "categoryName": "籃球"
        }
      ],
      "message": "獲取用戶貼文成功",
      "status": 200
    };

    var controller = Get.put(PostCoverController());
    List<PostCoverData> postCoverData = controller.postCover.value;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(postCoverData[1].categoryName);
        // var data = postCoverModuleFromJson(response);

        // print(data.data);
      }),
    );
  }
}
