import 'dart:io';
import 'package:cozydiary/pages/Home/homePageTabbar.dart';
import 'package:gallery_saver/files.dart';
import 'package:intl/intl.dart';
import 'package:cozydiary/pages/Personal/Self/controller/selfController.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Model/EditUserModel.dart';

class EditUserController extends GetxController {
  var oldname = "".obs;
  DateTime oldbirthDay = DateTime(0);
  var birthDayText = "".obs;
  var oldIntroduction = "".obs;
  List birthday = [];
  String oldImageUrl = "";
  dynamic defaultPreviewImage;
  dynamic changedPreviewImage;
  int oldSex = 0;
  List<String> gender = [];
  var currentSelect = "".obs;
  SelfPageController selfPageController = Get.find<SelfPageController>();
  late TextEditingController nameController;
  late TextEditingController introducionController;
  final imagePicker = ImagePicker();
  var isImageChange = false.obs;

  @override
  void onInit() {
    oldImageUrl = selfPageController.userData.value.pic;
    defaultPreviewImage = NetworkImage(oldImageUrl);
    nameController =
        TextEditingController(text: selfPageController.userData.value.name);
    introducionController = TextEditingController(
        text: selfPageController.userData.value.introduction);

    oldname.value = selfPageController.userData.value.name;
    birthday = selfPageController.userData.value.birth;
    String year = birthday[0].toString();
    String month =
        birthday[1] >= 10 ? birthday[1] : "0" + birthday[1].toString();
    String day = birthday[2] >= 10
        ? birthday[2].toString()
        : "0" + birthday[2].toString();
    birthDayText.value = "$year-$month-$day";
    oldIntroduction.value = selfPageController.userData.value.introduction;
    oldbirthDay = DateTime(birthday[0], birthday[1], birthday[2]);
    oldSex = selfPageController.userData.value.sex;
    gender = ["女", "男"];
    currentSelect.value = oldSex == 0 ? "女" : "男";
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> openImagePicker() async {
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        oldImageUrl = value.path;
        // changedPreviewImage = FileImage(File(oldImageUrl));
        // isImageChange.value = true;
        selfPageController.changeProfilePic(oldImageUrl).then((value) {
          print("value:$oldImageUrl");
          if (value == 200) {
            Get.back();
            Get.delete<EditUserController>();

            // throw "Unreachable";
          }
        }).catchError((error) => print("Error$error"));
      }
    });
  }

  //設置輸入姓名的初始值(namecontroller)
  void setTextEditController() {
    nameController = TextEditingController(text: oldname.value);
  }

  //更新自介
  void setIntroduction(String value) {
    oldIntroduction.value = value;
  }

  //DatePicker後的設定
  void setBirthDay(DateTime? newDate) {
    birthDayText.value = DateFormat("yyyy-MM-dd").format(newDate!);
    oldbirthDay = newDate;
  }

  EditUserModel setEditData() {
    String birth = oldbirthDay.year.toString() +
        "-" +
        oldbirthDay.month.toString() +
        "-" +
        oldbirthDay.day.toString();
    DateTime currentTime = DateTime.now();
    EditUserModel finalUserData = EditUserModel(
      googleId: selfPageController.uid,
      name: oldname.value,
      sex: oldSex.toString(),
      introduction: oldIntroduction.value,
      birth: oldbirthDay,
    );
    return finalUserData;
  }
}
