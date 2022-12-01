import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../HomePageTabbar.dart';
import '../controller/createPostController.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final _createPostController = Get.find<CreatePostController>();

    final titleCtr = TextEditingController();
    final contentCtr = TextEditingController();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('最後一步！'),
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
          body: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () {
                        print(_createPostController.showList);
                        Get.to(_showPicPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: _createPostController.showList[0],
                      ),
                    ),
                  )),
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
              Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        _createPostController.categoryList['data'].length,
                    itemBuilder: ((context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Obx(
                                () => ElevatedButton(
                                  onPressed: () {
                                    _createPostController.selectCategory(index);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      backgroundColor: _createPostController
                                                      .categoryList['data']
                                                  [index] ==
                                              _createPostController
                                                  .selectedMap.value
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context)
                                              .primaryColorLight),
                                  child: Text(
                                    _createPostController.categoryList['data']
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
    );
  }
}

class _showPicPage extends StatelessWidget {
  _showPicPage({Key? key}) : super(key: key);
  final _createPostController = Get.put(CreatePostController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {Get.back()},
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 150, bottom: 150),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: _createPostController.showList[index]),
              );
            },
            itemCount: _createPostController.showList.length),
      ),
    );
  }
}
