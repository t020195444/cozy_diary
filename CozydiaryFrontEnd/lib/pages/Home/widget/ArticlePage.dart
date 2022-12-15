import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../HomePageTabbar.dart';
import '../controller/createPostController.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({Key? key}) : super(key: key);

  final _createPostController = Get.find<CreatePostController>();

  final titleCtr = TextEditingController();
  final contentCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('最後一步！'),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined)),
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                  onPressed: () async {
                    if (titleCtr.text == '' || contentCtr.text == '') {
                      Fluttertoast.showToast(
                          msg: "標題或內文不可為空白",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (_createPostController.selectedMap.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "請選擇類別",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blue,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      _createPostController.setContent(
                          titleCtr.text, contentCtr.text);

                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                backgroundColor:
                                    Theme.of(context).backgroundColor,
                                title: const Text('發文中...'),
                                content: Container(
                                    height: 150,
                                    width: 30,
                                    child: Center(
                                        child: CircularProgressIndicator())),
                              ));

                      await _createPostController.goToDataBase();

                      Get.offAll(HomePageTabbar());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '發布',
                      // style: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Container(
                  height: MediaQuery.of(context).size.width * 1.05,
                  child: _showPicPage(),
                ),
                Padding(
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
                Padding(
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
                Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: _createPostController.categoryImageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _createPostController.selectCategory(index);
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 20, top: 10),
                              child: Container(
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: _createPostController
                                    .categoryImageList[index],
                              ),
                            ),
                            Obx(
                              () => Positioned(
                                right: 10,
                                top: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(129, 68, 68, 68),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: _createPostController
                                                .currSelectedNumber ==
                                            index
                                        ? Icon(
                                            Icons.check_circle,
                                            color:
                                                Color.fromARGB(147, 26, 26, 26),
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ])),
        ),
      ),
    );
  }
}

class _showPicPage extends StatelessWidget {
  _showPicPage({Key? key}) : super(key: key);

  final _createPostController = Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PageView.builder(
        itemCount: _createPostController.showList.length,
        itemBuilder: (BuildContext context, int index) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _createPostController.changePicSize(
                        _createPostController.showList[index], index);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 1.05,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                            File(_createPostController.showList[index])),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
