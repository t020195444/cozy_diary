import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'PostController.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final postController = new PostController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
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
    );
  }
}
