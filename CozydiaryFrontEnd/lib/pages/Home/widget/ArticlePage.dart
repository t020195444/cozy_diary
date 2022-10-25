import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../HomePageTabbar.dart';
import '../controller/PostController.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final postController = new PostController();

    final titleCtr = TextEditingController();
    final contentCtr = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                postController.setContent(titleCtr.text, contentCtr.text);
                postController.goToDataBase();
                Get.to(HomePageTabbar());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '發布',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: titleCtr,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '請輸入標題...',
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: contentCtr,
                cursorColor: Colors.red,
                maxLines: 7,
                maxLength: 150,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '請輸入內文...',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
