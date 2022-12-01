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
    final _createPostController = Get.put(CreatePostController());

    //initState
    // _createPostController.fetchMedia(_createPostController.startNum.value,
    //     _createPostController.endNum.value);
    _createPostController.fetchMedia();
    _createPostController.getList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('選擇照片'),
          actions: [
            TextButton(
                onPressed: () {
                  if (_createPostController.pickedList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: '沒選照片',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  } else {
                    Get.to(() => ArticlePage());
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
            Expanded(
              flex: 4,
              child: Obx(
                () => Container(
                    child: _createPostController.isPicked == true
                        ? _createPostController.currPic[0]
                        : Container(
                            child: Center(
                              child: Text('選擇一張照片吧！'),
                            ),
                          )),
              ),
            ),
            Obx(
              () => Expanded(
                flex: 6,
                child: _createPostController.isLoading.value == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        itemCount: _createPostController.mediaList.length,
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
                                      child: _createPostController.mediaList[i],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(129, 68, 68, 68),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)),
                                          ),
                                          child: _createPostController
                                                      .checkBox[i] ==
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
