import 'dart:convert';
import 'dart:io';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/api.dart';
import 'package:cozydiary/postJsonService.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:photo_manager/photo_manager.dart';
import 'package:dio/dio.dart';

import '../HomePageTabbar.dart';

class CreatePostController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchMedia();
    getList();
  }

  //variable

  int currentPage = 0;
  RxBool isPicked = false.obs;

  late List<RxBool> checkBox =
      List.generate(mediaList.length, (_) => false.obs);

  //function

  List fileList = [].obs;
  RxList showList = [].obs;
  RxList mediaList = [].obs;
  RxBool isLoading = false.obs;

  int startNum = 0;
  int endNum = 15;

  fetchMedia() async {
    isLoading.value = true;

    final PermissionState _ps = await PhotoManager.requestPermissionExtend();

    if (_ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
      // var _folder;
      // if (Platform.isAndroid) {
      //   for (var folder in albums) {
      //     if (folder.name == 'Download') {
      //       _folder = folder;
      //     }
      //   }
      // } else if (Platform.isIOS) {
      //   for (var folder in albums) {
      //     if (folder.name == '豆漿') {
      //       _folder = folder;
      //     }
      //   }
      // }
      // albums = [];
      // albums.add(_folder);
      // print(albums);
      // List<AssetEntity> media =
      //     await albums[0].getAssetListPaged(size: 15, page: currentPage);
      List media =
          await albums[0].getAssetListRange(start: startNum, end: endNum);

      mediaList.value = [];
      fileList = [];
      List<Widget> _temp = [];
      showList.value = [];

      int wrongPicTypeCount = 0;

      for (var asset in media) {
        if (asset.type == AssetType.image) {
          fileList.add(await asset.file);
          _temp.add(
            FutureBuilder(
              future: asset.thumbnailDataWithSize(ThumbnailSize(800, 800)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Positioned.fill(
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  );
                return Container();
              },
            ),
          );
        } else {
          wrongPicTypeCount++;
        }
      }

      if (wrongPicTypeCount != 0) {
        while (_temp.length != 15) {
          startNum = endNum;
          endNum += 1;
          media =
              await albums[0].getAssetListRange(start: startNum, end: endNum);
          if (media[0].type == AssetType.image) {
            fileList.add(await media[0].file);

            _temp.add(
              FutureBuilder(
                future: media[0].thumbnailDataWithSize(ThumbnailSize(800, 800)),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done)
                    return Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    );
                  return Container();
                },
              ),
            );
          }
        }
      }

      //設置顯示照片List
      mediaList.addAll(_temp);
      // print(mediaList);
      //default Pic
      currPic.value = fileList[0].path;
      checkBox = List.generate(mediaList.length, (_) => false.obs);
    } else {}
    isLoading.value = false;
  }

  loadMorePic() async {
    startNum = endNum;
    endNum += 15;
    List<AssetPathEntity> albums =
        await PhotoManager.getAssetPathList(onlyAll: true);

    // List<AssetEntity> media =
    //     await albums[0].getAssetListPaged(size: 15, page: currentPage);
    List media =
        await albums[0].getAssetListRange(start: startNum, end: endNum);

    List<Widget> _temp = [];

    int wrongPicTypeCount = 0;

    for (var asset in media) {
      if (asset.type == AssetType.image) {
        fileList.add(await asset.file);
        _temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(ThumbnailSize(800, 800)),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.connectionState == ConnectionState.done)
                return Positioned.fill(
                  child: Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                );
              return Container();
            },
          ),
        );
      } else {
        wrongPicTypeCount++;
      }
    }

    if (wrongPicTypeCount != 0) {
      while (_temp.length % 15 != 0) {
        startNum = endNum;
        endNum += 1;
        media = await albums[0].getAssetListRange(start: startNum, end: endNum);
        if (media[0].type == AssetType.image) {
          fileList.add(await media[0].file);

          _temp.add(
            FutureBuilder(
              future: media[0].thumbnailDataWithSize(ThumbnailSize(800, 800)),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done)
                  return Positioned.fill(
                    child: Image.memory(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    ),
                  );
                return Container();
              },
            ),
          );
        }
      }
    }

    //設置顯示照片List
    mediaList.addAll(_temp);
    // print(mediaList);

    checkBox = List.generate(mediaList.length, (_) => false.obs);
  }

  RxString currPic = ''.obs;
  changeCurrPic(int i) {
    //設置目前顯示照片

    currPic.value = fileList[i].path;
    // print(currPic.value);
    setPicList(i);
  }

  List pickedList = [];
  setPicList(int i) {
    String tempFile = fileList[i].path;

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

  RxBool isPosting = true.obs;
  goToDataBase() async {
    // reset Data
    checkBox = [];
    checkBox = List.generate(mediaList.length, (_) => false.obs);

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
        cover: basename(showList[0]),
        cid: selectedMap['cid'],
        postFiles: postFiles);
  }

  Future<FormData> writePost() async {
    FormData formData = FormData();
    // int index = 1;
    for (int i = 0; i < showList.length; i++) {
      allPicName.add(basename(showList[i]));
    }
    allPicName.asMap().forEach((key, value) async {
      postFiles.add(PostFile(postUrl: value));
    });
    setPost();
    WritePostModule writePost = WritePostModule(post: postsContext);
    var jsonString = jsonEncode(writePost.toJson());
    formData = FormData.fromMap({"jsondata": jsonString});
    // print(formData.fields.toString());
    for (int i = 0; i < showList.length; i++) {
      formData.files.addAll(
          [MapEntry("file", await MultipartFile.fromFile(showList[i]))]);
    }
    return formData;
  }

  static Map categoryList = {}.obs;
  getList() async {
    var response = await PostService.dio.get(Api.ipUrl + Api.getCategoryList);
    categoryList = response.data;
    // print(categoryList);
  }

  RxMap selectedMap = {}.obs;
  selectCategory(int index) {
    selectedMap.value = categoryList['data'][index];
  }

  Future<void> changePicSize(String path, int index) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 3.05),
      maxHeight: 600,

      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ThemeData.light().appBarTheme.backgroundColor,
            toolbarWidgetColor: ThemeData.light().appBarTheme.foregroundColor,
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockDimensionSwapEnabled: true,
          aspectRatioLockEnabled: true,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetAspectRatioEnabled: false,
        )
      ],

      // )
      // .then((value) {
      //   if (value != null) {
      //     path = value.path;
      //     Get.dialog(Center(
      //       child: CircularProgressIndicator(),
      //     ));
      //   }
      // }
    );
    showList[index] = croppedFile!.path;
  }
}
