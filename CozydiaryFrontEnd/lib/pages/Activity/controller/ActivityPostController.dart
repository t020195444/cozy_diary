import 'dart:convert';
import 'dart:io';
import 'package:cozydiary/Model/WriteActivityPostModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:photo_manager/photo_manager.dart';
import 'package:dio/dio.dart';

class ActivityPostController extends GetxController {
  //variable
  RxString activityTime = "2000-01-01".obs;
  int currentPage = 0;
  RxBool isPicked = false.obs;

  static late List<RxBool> checkBox =
      List.generate(mediaList.length, (_) => false.obs);

  //function
  static List fileList = [].obs;
  static RxList mediaList = [].obs;
  fetchMedia() async {
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      List media =
          await albums[0].getAssetListPaged(size: 60, page: currentPage);

      mediaList.value = [];
      List<Widget> temp = [];
      for (var asset in media) {
        fileList.add(await asset.file);
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(ThumbnailSize(800, 800)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (asset.type == AssetType.video)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              return Container();
            },
          ),
        );
      }
      //設置顯示照片List
      mediaList.addAll(temp);
      //default Pic
      currPic.add(mediaList[0]);
    } else {}
  }

  RxList currPic = [].obs;
  changeCurrPic(int i) {
    //設置目前顯示照片
    currPic.value = [];
    currPic.add(mediaList[i]);

    setPicList(i);
  }

  static List pickedList = [];
  setPicList(int i) {
    File tempFile = fileList[i];
    if (pickedList.contains(tempFile)) {
      pickedList.remove(tempFile);
      checkBox[i].value = false;
    } else {
      pickedList.add(tempFile);
      checkBox[i].value = true;
    }
  }

  //create post
  late Post postsContext;
  late Activity postsActivityContext;
  // static String finalTitle = '';
  // static String finalContent = '';
  var postFiles = <ActivityPostFile>[];
  List allPicName = [];

  void goToDataBase() async {
    var formdata = writePost();
    print(await formdata.toString());
    await ActivityPostService.postPostData(await formdata);
  }

  void setPost() {
    postsActivityContext = Activity(
      holder: "116177189475554672826",
      placeLng: 121.5259613226078,
      placeLat: 25.042202549516645,
      likes: 1,
      activityName: "來去夏威夷",
      cover: basename(pickedList[0].path),
      activityTime: "2022-10-05T21:53:01.102021",
      auditTime: "2022-09-05T21:53:01.102021",
      payment: 1,
      budget: 20000,
      content: "測試",
      actId: 1,
      // postFiles: postFiles
    );
  }

  Future<FormData> writePost() async {
    print(pickedList);

    print("-------");

    FormData formData = FormData();
    // int index = 1;
    for (int i = 0; i < pickedList.length; i++) {
      allPicName.add(basename(pickedList[i].path));
    }
    print(allPicName);

    allPicName.asMap().forEach((key, value) async {
      postFiles.add(ActivityPostFile(postUrl: value));
    });

    setPost();
    WriteActivityPostModel writePost =
        WriteActivityPostModel(activity: postsActivityContext);
    var jsonString = jsonEncode(writePost.toJson());
    formData = FormData.fromMap({"jsondata": jsonString});
    print(formData);
    for (int i = 0; i < pickedList.length; i++) {
      formData.files.addAll(
          [MapEntry("file", await MultipartFile.fromFile(pickedList[i].path))]);
    }
    return formData;
  }
}
