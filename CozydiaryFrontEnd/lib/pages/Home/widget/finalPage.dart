import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cozydiary/pages/Home/widget/pick.dart';
import 'package:get/get.dart';
import 'dart:io';

class FinalPage extends StatefulWidget {
  const FinalPage({Key? key}) : super(key: key);

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  final titleCtr = TextEditingController();
  final contentCtr = TextEditingController();
  pickController pickControllers = Get.put(pickController());

  textFieldEmptyCheck() {
    String titleText, contentText;

    titleText = titleCtr.text;
    contentText = contentCtr.text;
    if (titleText == '' && contentText == '') {
      Fluttertoast.showToast(
        msg: '請輸入標題與內文',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 3,
        backgroundColor: Color.fromARGB(255, 65, 65, 66),
      );
    } else {
      if (titleText == '') {
        Fluttertoast.showToast(
          msg: '請輸入標題',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Color.fromARGB(255, 65, 65, 66),
        );
      } else {
        pickController.finalTitle = titleText;
      }
      if (contentText == '') {
        Fluttertoast.showToast(
          msg: '請輸入內文',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 3,
          backgroundColor: Color.fromARGB(255, 65, 65, 66),
        );
      } else {
        pickController.finalContent = contentText;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: pickController.themeColor,
          actions: [
            TextButton(
              onPressed: () {
                textFieldEmptyCheck(); //測試是否為空值，並且傳值
                pickControllers.goToDataBase();
              },
              child: Text(
                '下一頁',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                pickControllers.isMultiPick != true
                                    ? PicZoomIn()
                                    : PicZoomIn2(),
                          ))
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      height: 115,
                      width: 115,
                      child: Hero(
                        tag: 'pic',
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: pickControllers.isMultiPick != true
                                ? pickController.selectedPicPath
                                : pickController.selectedPicPathList[0]),
                      ),
                    ),
                  ),
                  
                  
                ],
              ),
            ),
            Container(
              height: 50,
              child: Padding(
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
            ),
            Container(
              height: 150,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
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
            Divider(
              color: pickController.themeColor,
              height: 0,
              indent: 50,
              endIndent: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: pickController.themeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(top: 20),
                    height: 70,
                    width: 145,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                            color: pickController.themeColor),
                        Text(
                          '新增地點',
                          style: TextStyle(color: pickController.themeColor),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: pickController.themeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 70,
                    width: 145,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                            color: pickController.themeColor),
                        Text(
                          '新增地點',
                          style: TextStyle(color: pickController.themeColor),
                        )
                      ],
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: pickController.themeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    height: 70,
                    width: 145,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                            color: pickController.themeColor),
                        Text(
                          '新增地點',
                          style: TextStyle(color: pickController.themeColor),
                        )
                      ],
                    )),
                Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: pickController.themeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 70,
                    width: 145,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_on,
                            color: pickController.themeColor),
                        Text(
                          '新增地點',
                          style: TextStyle(color: pickController.themeColor),
                        )
                      ],
                    )),
              ],
            ),
            Divider(
              color: pickController.themeColor,
              height: 0,
              indent: 20,
              endIndent: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class PicZoomIn extends StatelessWidget {
  const PicZoomIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {Navigator.pop(context)},
        child: Hero(
          tag: 'pic',
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 150, bottom: 150),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: pickController.selectedPicPath),
              );
            },
            itemCount: 1,
          ),
        ),
      ),
    );
  }
}

class PicZoomIn2 extends StatelessWidget {
  const PicZoomIn2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {Navigator.pop(context)},
        child: Hero(
          tag: 'pic',
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 150, bottom: 150),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: pickController.selectedPicPathList[index]),
              );
            },
            itemCount: pickController.selectedPicPathList.length,
          ),
        ),
      ),
    );
  }
}
