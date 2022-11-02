import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:cozydiary/main.dart';
import 'package:cozydiary/pages/Register/Page/selectLikePage.dart';
import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:hive/hive.dart';
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
      final image = io.File(pickedImage.path);
      previewImage.value = image;
      pic = pickedImage.path;
      picOrigin = pickedImage.path;
    } else {
      return;
    }
  }

  void register() async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()));
      var postUserData = RegisterUserDataModel(user: userData[0]);
      var jsonData = jsonEncode(postUserData.toJson());
      var formData = FormData.fromMap({"jsondata": jsonData});
      formData.files
          .add(MapEntry("file", await MultipartFile.fromFile(picOrigin)));
      print(formData);
      print(picOrigin);
      int responseStatus = await RegisterService.registerUser(formData);

      if (responseStatus == 200) {
        Get.back();
        print("成功");
        Hive.box("UidAndState").put("uid", googleId);
        Get.to(SelectLikePage(
          state: 0,
        ));
      } else {
        Get.back();
        Get.offAll(MyHomePage(title: ""));
        print("失敗");
      }
    } catch (e) {
      print(e);
    }
  }
}
