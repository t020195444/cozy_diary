import 'dart:convert';
import 'dart:io' as io;
import 'package:cozydiary/Model/UserDataModel.dart';
import 'package:cozydiary/data/dataResourse.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/pages/Register/SelectLikePage.dart';
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
  RxString picorigin = "".obs;
  RxList f = [].obs;
  late Rx<io.File?> previewImage = UserHeaderImage.obs;
  final _imagePicker = ImagePicker();

  late bool choicesex = true;
  var userData = <User>[].obs;

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

  void adddata() async {
    firebaseauth.FirebaseAuth.instance
        .authStateChanges()
        .listen((firebaseauth.User? user) {
      if (user != null) {
        googleId = user.providerData[0].uid!;
        email = user.providerData[0].email!;
        name.value = user.providerData[0].displayName!;
        pic.value = user.providerData[0].photoURL!;
        print(googleId);
      }
    });
    userData.clear();
    var picsplit = pic.value.split("/").last;
    userData.add(User(
        googleId: googleId,
        name: name.value,
        sex: sex.value,
        introduction: introduction.value,
        birth: DateTime.parse(birth.value),
        email: email,
        pic: picsplit));
    print(googleId + email);
    print(userData[0].toJson());
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
      pic.value = pickedImage.path;
      picorigin.value = pickedImage.path;
    } else {
      return;
    }
  }

  void register() async {
    try {
      var dio = Dio();
      var postUserData = UserDataModel(user: userData[0]);
      var jsonData = jsonEncode(postUserData.toJson());
      var formData = FormData.fromMap({"jsondata": jsonData});
      formData.files
          .add(MapEntry("file", await MultipartFile.fromFile(picorigin.value)));
      print(formData);
      print(picorigin.value);
      var response = (await dio.post('http://140.131.114.166:80/userRegister',
          data: formData));
      if (response.statusCode == 200) {
        print("成功");
        Get.to(HomePageTabbar());
      } else {
        print("失敗");
      }
      print(response.statusCode);
    } catch (e) {
      print(e);
    }
  }
}
