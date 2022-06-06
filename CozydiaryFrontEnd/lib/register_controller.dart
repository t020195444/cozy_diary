import 'dart:io' as io;
import 'package:cozydiary/Model/UserDataModel.dart';
import 'package:cozydiary/data/dataResourse.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseauth;
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {
  String googleId = "";
  RxString name = "".obs;
  RxString sex = "1".obs;
  RxString introduction = "".obs;
  RxString birth = "2000-01-01".obs;
  String email = "";
  RxString pic = "".obs;
  RxList f = [].obs;
  late Rx<io.File?> previewImage = UserHeaderImage.obs;
  final _imagePicker = ImagePicker();

  late bool choicesex = true;
  var userData = <User>[].obs;

  @override
  void onInit() {
    firebaseauth.FirebaseAuth.instance
        .authStateChanges()
        .listen((firebaseauth.User? user) {
      googleId = user!.providerData[0].uid!;
      email = user.providerData[0].email!;
      name.value = user.providerData[0].displayName!;
      print(googleId);
    });
    super.onInit();
  }

  void adddata() async {
    // userData.clear();

    // userData.add(User(
    //     googleId: googleId,
    //     name: name.value,
    //     sex: sex.value,
    //     introduction: introduction.value,
    //     birth: DateTime.parse(birth.value),
    //     email: email,
    //     pic: pic.value));
    // print(googleId + email);
    // print(userData[0].toJson());
    await Get.to(HomePageTabbar());
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
      pic.value = pickedImage.path;
    } else {
      return;
    }
  }

  void register() async {
    try {
      Response response;
      String title = "title";
      var dio = Dio();
      String jsonString = """
            { "user":{
    "googleId": "$googleId",
    "name": "${name.toString()}",
    "sex":"${sex.value}",
    "introduction":"${introduction.value}",
    "birth":"${birth.value}",
    "email":"${email.toString()}",
    "pic":"${pic.value}"
}
}
                  """;
      print("below is json :" + jsonString);
      var formData = FormData.fromMap(userData[0].toJson());

      // p.rename(newPath)
      formData.files
          .add(MapEntry("file", await MultipartFile.fromFile(pic.value)));
      print(formData);
      //   response = (await dio.post('http://172.20.10.10:8080/userRegister',
      //       data: formData));
      //   dio.post;
      //   if (response.statusCode == 200) {
      //     print("成功");
      //   }
      //   print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
