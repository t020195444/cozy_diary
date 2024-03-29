import 'package:cozydiary/Model/catchPersonalModel.dart';
import 'package:cozydiary/pages/Personal/Self/controller/selfController.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;
import 'package:image_picker/image_picker.dart';

import '../../../../Model/editUserModel.dart';
import '../../Service/personalService.dart';

class EditUserController extends GetxController {
  var uid = Hive.box("UidAndState").get("uid");
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

  late TextEditingController nameController;
  late TextEditingController introducionController;
  final imagePicker = ImagePicker();
  var isImageChange = false.obs;
  late UserData userData;

  @override
  void onInit() {
    super.onInit();
  }

  void initData(UserData userData) {
    oldImageUrl = userData.pic;
    defaultPreviewImage = NetworkImage(oldImageUrl);
    nameController = TextEditingController(text: userData.name);
    introducionController = TextEditingController(text: userData.introduction);

    oldname.value = userData.name;
    birthday = userData.birth;
    String year = birthday[0].toString();
    var month = birthday[1] >= 10 ? birthday[1] : "0" + birthday[1].toString();
    String day = birthday[2] >= 10
        ? birthday[2].toString()
        : "0" + birthday[2].toString();
    birthDayText.value = "$year-$month-$day";
    oldIntroduction.value = userData.introduction;
    oldbirthDay = DateTime(birthday[0], birthday[1], birthday[2]);
    oldSex = userData.sex;
    gender = ["女", "男"];
    currentSelect.value = oldSex == 0 ? "女" : "男";
  }

  Future<int> changeProfilePic(String picUrl) async {
    FormData fileFormData = FormData();
    String picName = picUrl.split("/").last;
    fileFormData.files.add(MapEntry(
        "file", await MultipartFile.fromFile(picUrl, filename: picName)));
    var response =
        await PersonalService.changeProfilePic(fileFormData, uid, picName);

    return response.status;
  }

  Future<void> openImagePicker() async {
    // ignore: unused_local_variable
    final XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        oldImageUrl = value.path;
      }
      return null;
    });

    // ignore: unused_local_variable
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: oldImageUrl,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      maxHeight: 600,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: ThemeData.light().appBarTheme.backgroundColor,
            toolbarWidgetColor: ThemeData.light().appBarTheme.foregroundColor,
            hideBottomControls: true,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioLockEnabled: false,
          rotateButtonsHidden: true,
          rotateClockwiseButtonHidden: true,
          aspectRatioPickerButtonHidden: true,
          resetAspectRatioEnabled: false,
        )
      ],
      // ignore: body_might_complete_normally_nullable
    ).then((value) {
      if (value != null) {
        oldImageUrl = value.path;
        Get.dialog(Center(
          child: CircularProgressIndicator(),
        ));
        changeProfilePic(oldImageUrl).then((value) {
          if (value == 200) {
            Get.back();
            Get.back();
            Get.find<SelfPageController>().getUserData();
          }
          // ignore: invalid_return_type_for_catch_error
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
    EditUserModel finalUserData = EditUserModel(
      googleId: uid,
      name: oldname.value,
      sex: oldSex.toString(),
      introduction: oldIntroduction.value,
      birth: oldbirthDay,
    );
    return finalUserData;
  }

  Future<String> updateUser(EditUserModel editUserModel) async {
    String updateUserJsonData = editUserModelToJson(editUserModel);
    var response = await PersonalService.updateUser(updateUserJsonData);

    return response.message;
  }
}
