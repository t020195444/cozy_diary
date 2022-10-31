import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ArticlePage.dart';
import '../controller/PostController.dart';

class PickPhotoPage extends StatefulWidget {
  @override
  State<PickPhotoPage> createState() => _PickPhotoPageState();
}

class _PickPhotoPageState extends State<PickPhotoPage> {
  @override
  Widget build(BuildContext context) {
    //Controller
    final postController = new PostController();

    //initState
    postController.fetchMedia();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  if (PostController.pickedList.isEmpty) {
                    Fluttertoast.showToast(
                        msg: '沒選照片',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    print(PostController.pickedList);
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
                  child: postController.isPicked == true
                      ? postController.currPic[0]
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
                    itemCount: PostController.mediaList.length,
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
                                  child: PostController.mediaList[i],
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
                                      child: PostController.checkBox[i] == true
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
