import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/createPostController.dart';
import 'ArticlePage.dart';

class PickPhotoPage extends StatefulWidget {
  @override
  State<PickPhotoPage> createState() => _PickPhotoPageState();
}

class _PickPhotoPageState extends State<PickPhotoPage> {
  @override
  Widget build(BuildContext context) {
    //Controller
    final _createPostController = CreatePostController();

    //initState
    _createPostController.fetchMedia();
    _createPostController.getList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  if (CreatePostController.pickedList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: '沒選照片',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArticlePage()),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '下一步',
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Obx(
                () => Container(
                  child: _createPostController.isPicked == true
                      ? _createPostController.currPic[0]
                      : Container(
                          color: Colors.white,
                        ),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                flex: 6,
                child: GridView.builder(
                    itemCount: CreatePostController.mediaList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int i) {
                      return Obx(
                        () => GestureDetector(
                            onTap: () {
                              _createPostController.isPicked.value = true;
                              _createPostController.changeCurrPic(i);
                            },
                            child: Stack(
                              children: [
                                Container(
                                  child: CreatePostController.mediaList[i],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(129, 68, 68, 68),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                      child: CreatePostController.checkBox[i] ==
                                              true
                                          ? Icon(Icons.check_circle,
                                              color: Colors.blue)
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
