import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:cozydiary/main.dart';
import 'package:cozydiary/pages/Register/Page/SelectLikePage.dart';
import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Model/registerUserDataModel.dart';

class RegisterController extends GetxController {
  //value

  //goolgeid 用於傳給後端
  String googleId = "";
  //使用者名字
  RxString name = "".obs;
  //使用者性別 預設為男生
  RxString sex = "1".obs;
  //自我介紹
  RxString introduction = "".obs;
  //生日
  RxString birth = "2000-01-01".obs;
  //email 用於傳入後端
  String email = "";
  //使用者照片
  String pic = "";
  //google帳戶的照片
  String picOrigin = "";
  RxList f = [].obs;
  //預覽照片
  late Rx<io.File?> previewImage = File("").obs;
  final _imagePicker = ImagePicker();
  late bool choicesex = true;
  //使用者資料
  var userData = <RegisterUserData>[].obs;

  @override
  void onInit() {
    // firebaseauth.FirebaseAuth.instance
    //     .authStateChanges()
    //     .listen((firebaseauth.User? user) {
    //   googleId = user!.providerData[0].uid!;
    //   email = user.providerData[0].email!;
    //   name.value = user.providerData[0].displayName!;
    //   pic.value = user.providerData[0].photoURL!;
    //   print(googleId);
    // });

    super.onInit();
  }

  //註冊使用者
  void adddata(String googleId, String email) async {
    var picsplit = pic.split("/").last;
    this.googleId = googleId;
    userData.add(RegisterUserData(
        googleId: googleId,
        name: name.value,
        sex: sex.value,
        introduction: introduction.value,
        birth: DateTime.parse(birth.value),
        email: email,
        pic: picsplit));

    register();
  }

  void choicemen() {
    sex.value = "1";
  }

  void choicegril() {
    sex.value = "0";
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // ignore: unused_local_variable
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
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
              aspectRatioLockEnabled: true,
              rotateButtonsHidden: true,
              rotateClockwiseButtonHidden: true,
              aspectRatioPickerButtonHidden: true,
              resetAspectRatioEnabled: false)
        ],
        // ignore: body_might_complete_normally_nullable
      ).then((value) {
        if (value != null) {
          final image = io.File(value.path);
          previewImage.value = image;
          pic = value.path;
          picOrigin = value.path;
        }
      });
    } else {
      return;
    }
  }

  void register() async {
    if (picOrigin == "") {
      Get.showSnackbar(GetSnackBar(
        title: "通知",
        icon: Icon(
          Icons.error,
          color: Colors.red[400],
        ),
        message: "請選擇大頭照",
        duration: const Duration(seconds: 3),
      ));
    } else {
      Get.dialog(Center(child: CircularProgressIndicator()));
      var postUserData = RegisterUserDataModel(user: userData[0]);
      var jsonData = jsonEncode(postUserData.toJson());
      var formData = FormData.fromMap({"jsondata": jsonData});
      formData.files
          .add(MapEntry("file", await MultipartFile.fromFile(picOrigin)));
      await RegisterService.registerUser(formData).then((value) {
        if (value == 200) {
          Get.back();
          Hive.box("UidAndState").put("uid", googleId);
          Get.to(SelectLikePage(
            isRegiststate: false,
          ));
        } else {
          Get.back();
          Get.offAll(MyHomePage(title: ""));
        }
      });
    }
  }
}
