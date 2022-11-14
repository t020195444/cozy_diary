import 'package:cozydiary/pages/Activity/ActivityArticlePage.dart';
import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostActivityPage extends StatefulWidget {
  @override
  State<PostActivityPage> createState() => _PostActivityPageState();
}

class _PostActivityPageState extends State<PostActivityPage> {
  @override
  Widget build(BuildContext context) {
    //Controller
    final postController = Get.put(ActivityPostController());

    //initState
    postController.fetchMedia();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('發起活動'),
          actions: [
            TextButton(
                onPressed: () {
                  if (ActivityPostController.pickedList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: '沒選照片',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Get.to(() => ActivityArticlePage());
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
                  child: postController.isPicked == true
                      ? postController.currPic[0]
                      : Container(
                          color: Colors.white,
                          child: Center(child: Text("尚未選擇照片")),
                        ),
                ),
              ),
            ),
            Obx(
              () => Expanded(
                flex: 6,
                child: GridView.builder(
                    itemCount: ActivityPostController.mediaList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                  child: ActivityPostController.mediaList[i],
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
                                      child:
                                          ActivityPostController.checkBox[i] ==
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
