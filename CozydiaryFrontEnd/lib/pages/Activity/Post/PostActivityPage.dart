import 'dart:io';

import 'package:cozydiary/pages/Activity/Post/ActivityArticlePage.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostActivityPage extends StatefulWidget {
  @override
  State<PostActivityPage> createState() => _PostActivityPageState();
}

class _PostActivityPageState extends State<PostActivityPage> {
  @override
  Widget build(BuildContext context) {
    //Controller
    final postController = Get.put(ActivityPostController());
    final _refreshController = RefreshController(initialRefresh: false);

    void _load() async {
      await postController.loadMorePic();

      _refreshController.loadComplete();
    }

    //initState
    postController.fetchMedia();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('發起活動'),
          actions: [
            TextButton(
                onPressed: () {
                  postController.showList.value = [];
                  postController.showList.value =
                      ActivityPostController.pickedList;
                  if (ActivityPostController.pickedList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: '沒選照片',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  } else {
                    Get.to(() => ActivityArticlePage());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '下一步',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ))
          ],
        ),
        body: Column(
          children: [
            Obx(() => postController.currPic.isEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Center(child: Text('選擇一張照片吧！')),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width * 1.05,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(postController.currPic.value)),
                        ),
                      ),
                    ),
                  )),
            Obx(
              () => Expanded(
                flex: 6,
                child: postController.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scrollbar(
                        child: SmartRefresher(
                          header: WaterDropHeader(),
                          controller: _refreshController,
                          enablePullDown: false,
                          enablePullUp: true,
                          onLoading: _load,
                          child: GridView.builder(
                              itemCount:
                                  ActivityPostController.mediaList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int i) {
                                return Obx(
                                  () => GestureDetector(
                                      onTap: () {
                                        postController.isPicked.value = true;
                                        postController.changeCurrPic(i);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: ActivityPostController
                                                .mediaList[i],
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      129, 68, 68, 68),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child: ActivityPostController
                                                            .checkBox[i]
                                                            .value ==
                                                        true
                                                    ? Icon(
                                                        Icons.check_circle,
                                                        color: Color.fromARGB(
                                                            147, 26, 26, 26),
                                                      )
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
