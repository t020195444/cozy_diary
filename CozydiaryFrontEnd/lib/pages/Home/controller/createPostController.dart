import 'dart:convert';
import 'dart:io';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/api.dart';
import 'package:cozydiary/postJsonService.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:photo_manager/photo_manager.dart';
import 'package:dio/dio.dart';

class CreatePostController extends GetxController {
  //variable

  int currentPage = 0;
  RxBool isPicked = false.obs;

  static late List<RxBool> checkBox =
      List.generate(mediaList.length, (_) => false.obs);

  //function

  static List fileList = [].obs;
  static RxList mediaList = [].obs;
  RxBool isLoading = false.obs;
  fetchMedia() async {
    isLoading(true);
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);

      List media =
          await albums[0].getAssetListPaged(size: 30, page: currentPage);

      mediaList.value = [];
      List<Widget> temp = [];
      pickedList = [];

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
    isLoading.value = false;
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

  String postTitle = '';
  String postContent = '';
  setContent(String title, String content) {
    postTitle = title;
    postContent = content;
  }

  //create post
  late Post postsContext;
  // static String finalTitle = '';
  // static String finalContent = '';
  var postFiles = <PostFile>[];
  static List allPicName = [];

  goToDataBase() async {
    // reset Data
    checkBox = [];
    checkBox =
        List.generate(CreatePostController.mediaList.length, (_) => false.obs);

    // Post
    var formdata = writePost();
    await PostService.postPostData(await formdata);
  }

  void setPost() {
    postsContext = Post(
        uid: Hive.box("UidAndState").get("uid"),
        title: postTitle,
        content: postContent,
        likes: 0,
        collects: 0,
        cover: basename(pickedList[0].path),
        cid: 1,
        postFiles: postFiles);
  }

  Future<FormData> writePost() async {
    FormData formData = FormData();
    // int index = 1;
    for (int i = 0; i < pickedList.length; i++) {
      allPicName.add(basename(pickedList[i].path));
    }
    allPicName.asMap().forEach((key, value) async {
      postFiles.add(PostFile(postUrl: value));
    });
    setPost();
    WritePostModule writePost = WritePostModule(post: postsContext);
    var jsonString = jsonEncode(writePost.toJson());
    formData = FormData.fromMap({"jsondata": jsonString});
    print(formData.fields.toString());
    for (int i = 0; i < pickedList.length; i++) {
      formData.files.addAll(
          [MapEntry("file", await MultipartFile.fromFile(pickedList[i].path))]);
    }
    return formData;
  }

  static Map categoryList = {}.obs;
  getList() async {
    var response = await PostService.dio.get(Api.ipUrl + Api.getCategoryList);
    categoryList = response.data;
    print(categoryList);
  }
}
