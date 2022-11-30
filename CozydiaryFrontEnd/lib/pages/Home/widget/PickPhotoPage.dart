import 'package:cozydiary/pages/Home/widget/ArticlePage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/createPostController.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PickPhotoPage extends StatelessWidget {
  const PickPhotoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final _createPostController = Get.put(CreatePostController());
    final _refreshController = RefreshController(initialRefresh: false);

    void _load() async {
      await _createPostController.loadMorePic();

      _refreshController.loadComplete();
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('選擇照片'),
          actions: [
            TextButton(
                onPressed: () {
                  _createPostController.showList.value = [];
                  _createPostController.showList.value =
                      _createPostController.pickedList;
                  if (_createPostController.showList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: '沒選照片',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  } else {
                    Get.to(() => ArticlePage());
                    // Get.to(() => ArticlePage());
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
            Obx(
              () => Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: _createPostController.currPic.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Image.asset(_createPostController.currPic.value)),
            ),
            Obx(
              () => Expanded(
                flex: 6,
                child: _createPostController.isLoading.value == true
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
                              itemCount: _createPostController.mediaList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (BuildContext context, int i) {
                                return Obx(
                                  () => GestureDetector(
                                      onTap: () {
                                        _createPostController.isPicked.value =
                                            true;
                                        _createPostController.changeCurrPic(i);
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            child: _createPostController
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
                                                child: _createPostController
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
            // Obx(
            //   () => Expanded(
            //       flex: 1,
            //       child: Row(
            //         children: [
            //           _createPostController.startNum != 0
            //               ? Expanded(
            //                   child: TextButton(
            //                       onPressed: () {
            //                         _createPostController.setRange(false);
            //                       },
            //                       child: Row(
            //                         mainAxisAlignment: MainAxisAlignment.center,
            //                         children: [Icon(Icons.photo), Text('上一頁')],
            //                       )),
            //                 )
            //               : Container(),
            //           Expanded(
            //             child: TextButton(
            //                 onPressed: () {
            //                   _createPostController.setRange(true);
            //                 },
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [Icon(Icons.photo), Text('下一頁')],
            //                 )),
            //           ),
            //         ],
            //       )),
            // )
          ],
        ),
      ),
    );
  }
}
