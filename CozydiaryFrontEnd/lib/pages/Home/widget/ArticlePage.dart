import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

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
                  print(_createPostController.pickedList);
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
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.75,
                  child: _showPicPage(),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(20.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       Get.to(_showPicPage());
                //     },
                //     child: Obx(() => Padding(
                //           padding: const EdgeInsets.only(bottom: 8.0),
                //           child: Container(
                //             width: MediaQuery.of(context).size.width,
                //             height: MediaQuery.of(context).size.height * 0.3,
                //             decoration: BoxDecoration(
                //               image: DecorationImage(
                //                 fit: BoxFit.cover,
                //                 image: AssetImage(
                //                     _createPostController.showList[0]),
                //               ),
                //             ),
                //           ),
                //         )),
                //   ),
                // ),
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
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          CreatePostController.categoryList['data'].length,
                      itemBuilder: ((context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Obx(
                                  () => ElevatedButton(
                                    onPressed: () {
                                      _createPostController
                                          .selectCategory(index);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        backgroundColor: CreatePostController
                                                        .categoryList['data']
                                                    [index] ==
                                                _createPostController
                                                    .selectedMap.value
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .primaryColorLight),
                                    child: Text(
                                      CreatePostController.categoryList['data']
                                          [index]['category'],
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                )));
                      })),
                ),
              ],
            ),
          ),
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
          return Obx(() => Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _createPostController.changePicSize(
                            _createPostController.showList[index], index);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 800,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                _createPostController.showList[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
