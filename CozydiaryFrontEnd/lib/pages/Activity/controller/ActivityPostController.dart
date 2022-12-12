import 'dart:convert';
import 'package:cozydiary/Model/WriteActivityPostModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/api.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/postJsonService.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:photo_manager/photo_manager.dart';
import 'package:dio/dio.dart';

class ActivityPostController extends GetxController {
  var loginController = Get.put(LoginController());
  //variable
  RxString activityTitle = "".obs;
  RxString activityContent = "".obs;
  RxString activityTime = "".obs;
  RxString activityTimeview = "".obs;
  RxString activityDeadlineTime = "".obs;
  RxString activityDeadlineTimeview = "".obs;
  RxDouble activityLat = 0.0.obs;
  RxDouble activityLng = 0.0.obs;
  RxString activityLocation = "".obs;
  RxInt activityPeople = 2.obs;
  RxInt activityPayment = 0.obs;
  RxInt activitybudget = 0.obs;
  RxInt actId = 1.obs;
  int currentPage = 0;
  RxBool isPicked = false.obs;
  RxInt selectActType = 1.obs;
  RxInt selectActPayment = 1.obs;
  RxBool checkActivity = false.obs;
  RxBool checkActivitySetting = false.obs;

  checkData() {
    if (activityLng.value.toDouble() != 0.0 &&
        activityLat.value.toDouble() != 0.0 &&
        activityTitle.value.toString() != "" &&
        activityTime.value.toString() != "" &&
        activityDeadlineTime.value.toString() != "" &&
        activityContent.value.toString() != "" &&
        checkActivitySetting.value != false) {
      checkActivity.value = true;
    } else {
      checkActivity.value = false;
    }
  }

  selectActPaymentPuls(value) {
    if (selectActPayment.value != actPayment.length) {
      selectActPayment.value = selectActPayment.value + 1;
      value = selectActPayment.value;
    } else {
      selectActPayment.value = 1;
      value = selectActPayment.value;
    }
    update();
  }

  selectActPaymentSubtractions(value) {
    if (selectActPayment.value != 1) {
      selectActPayment.value = selectActPayment.value - 1;
      value = selectActPayment.value;
    } else {
      selectActPayment.value = actPayment.length;
      value = selectActPayment.value;
    }
    update();
  }

  selectActTypePuls(value) {
    if (selectActType.value != actType.length) {
      selectActType.value = selectActType.value + 1;
      value = selectActType.value;
    } else {
      selectActType.value = 1;
      value = selectActType.value;
    }
    update();
  }

  selectActTypeSubtractions(value) {
    if (selectActType.value != 1) {
      selectActType.value = selectActType.value - 1;
      value = selectActType.value;
    } else {
      selectActType.value = actType.length;
      value = selectActType.value;
    }
    update();
  }

  Map actType = {
    1: "旅遊",
    2: "收藏",
    3: "社交",
    4: "戶外",
    5: "運動",
    6: "創作",
    7: "娛樂",
    8: "服務",
  };
  Map actPayment = {
    1: "我來請客",
    2: "你來買單",
    3: "各付各的",
    4: "平均分攤",
  };

  updateActivityLocation(value) {
    activityLocation.value = value.formattedAddress!.toString();
    activityLat.value = value.geometry!.location!.lat;
    activityLng.value = value.geometry!.location!.lng;

    update();
  }

  late List<RxBool> checkBox =
      List.generate(mediaList.length, (_) => false.obs);

  //function
  List fileList = [].obs;
  RxList mediaList = [].obs;
  RxList showList = [].obs;
  RxBool isLoading = false.obs;
  int startNum = 0;
  int endNum = 15;

  fetchMedia(
      // int start, int end
      ) async {
    isLoading(true);
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList();
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

    checkBox = List.generate(mediaList.length, (_) => false.obs);
  }

  RxString currPic = ''.obs;
  changeCurrPic(int i) {
    //設置目前顯示照片
    currPic.value = fileList[i].path;
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

  //create post
  late Post postsContext;
  late Activity postsActivityContext;
  var activityFiles = <ActivityPostFile>[];
  List allPicName = [];

  RxBool isPosting = true.obs;
  goToDataBase() async {
    checkBox = [];
    checkBox = List.generate(mediaList.length, (_) => false.obs);

    var formdata = await writePost();

    await ActivityPostService.postPostData(await formdata);

    Get.offAll(HomePageTabbar());
    await checkActivity.value
        ? Get.showSnackbar(GetSnackBar(
            title: "通知",
            icon: Icon(
              Icons.check_circle,
              color: Colors.green[400],
            ),
            message: "成功發送貼文～",
            duration: const Duration(seconds: 3),
          ))
        : Get.showSnackbar(GetSnackBar(
            title: "通知",
            icon: Icon(
              Icons.error,
              color: Colors.red[400],
            ),
            message: "尚有資料未填寫完畢！",
            duration: const Duration(seconds: 3),
          ));
  }

  void setPost() {
    postsActivityContext = Activity(
      holder: Hive.box("UidAndState").get("uid"),
      placeLng: activityLng.value.toDouble(),
      placeLat: activityLat.value.toDouble(),
      likes: 0,
      activityName: activityTitle.value.toString(),
      cover: basename(pickedList[0]),
      activityTime: activityTime.value,
      auditTime: activityDeadlineTime.value,
      payment: selectActPayment.value.toInt(),
      budget: activitybudget.value.toInt(),
      content: activityContent.value.toString(),
      actId: selectActType.value.toInt(),
    );
  }

  Future<FormData> writePost() async {
    FormData formData = FormData();
    for (int i = 0; i < showList.length; i++) {
      allPicName.add(basename(showList[i]));
    }

    setPost();

    WriteActivityPostModel writePost =
        WriteActivityPostModel(activity: postsActivityContext);
    var jsonString = jsonEncode(writePost.toJson());

    formData = FormData.fromMap({"jsondata": jsonString});
    for (int i = 0; i < pickedList.length; i++) {
      formData.files.addAll(
          [MapEntry("file", await MultipartFile.fromFile(pickedList[i]))]);
    }
    return formData;
  }

  static Map categoryList = {}.obs;
  getList() async {
    var response = await PostService.dio.get(Api.ipUrl + Api.getCategoryList);
    categoryList = response.data;
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
    );
    showList[index] = croppedFile!.path;
  }
}
