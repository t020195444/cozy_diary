import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api.dart';
import '../HomePageTabbar.dart';
import '../controller/createPostController.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final _createPostController = CreatePostController();

    final titleCtr = TextEditingController();
    final contentCtr = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                _createPostController.setContent(
                    titleCtr.text, contentCtr.text);
                await _createPostController.goToDataBase();

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
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
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
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
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
          Expanded(
            flex: 1,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CreatePostController.categoryList['data'].length,
                itemBuilder: ((context, index) {
                  return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            onPressed: () {
                              _createPostController.getList();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                side: BorderSide(color: Colors.black, width: 2),
                                backgroundColor:
                                    Color.fromARGB(255, 239, 239, 239)),
                            child: Text(
                              CreatePostController.categoryList['data'][index]
                                  ['category'],
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          )));
                })),
          ),
          Expanded(flex: 3, child: Container())
        ],
      ),
    );
  }
}
