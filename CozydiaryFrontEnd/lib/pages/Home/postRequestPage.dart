import 'package:cozydiary/pages/Activity/PostActivityPage.dart';
import 'package:cozydiary/pages/Home/widget/pickPhotoPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostRequestPage extends StatelessWidget {
  const PostRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          margin: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "貼文",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Divider(
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                onTap: () => Get.to(PickPhotoPage()),
                leading: Container(
                  child: Icon(
                    Icons.post_add,
                    size: 64,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "發佈貼文",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "來分享你的生活與聚會心得吧~",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                child: Text(
                  "活動",
                  style: TextStyle(
                    fontSize: 32,
                  ),
                ),
              ),
              Divider(
                indent: 16,
                endIndent: 16,
              ),
              ListTile(
                onTap: () => Get.to(PostActivityPage()),
                leading: Container(
                  child: Icon(
                    Icons.post_add,
                    size: 64,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "發起活動",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "開始你的交友聚會，增加自己的人脈吧！",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
