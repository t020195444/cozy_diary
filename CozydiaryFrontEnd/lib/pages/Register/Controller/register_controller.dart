import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'package:cozydiary/Model/UserDataModel.dart';
import 'package:cozydiary/Model/categoryList.dart';
import 'package:cozydiary/pages/Register/Page/selectLikePage.dart';
import 'package:cozydiary/pages/Register/Service/registerService.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData, Response;
import 'package:image_picker/image_picker.dart';

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
  var userData = <User>[].obs;
  //使用者類別清單
  var categoryList = <Category>[].obs;
  //類別照片路徑清單
  var categoryAssetsList = [];
  //最終清單
  var finalCategoryList = <int>[];

  //state
  //類別選取List

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
    categoryAssetsList = [
      "assets/category/basketball_S.jpg",
      "assets/category/dressStyle_S.jpg",
      "assets/category/invest_S.jpg",
      "assets/category/anime_S.jpg",
      "assets/category/beauty_S.jpg"
    ];

    super.onInit();
  }

  //註冊使用者
  void adddata(String googleId, String email) async {
    var picsplit = pic.split("/").last;

    userData.add(User(
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
      var dio = Dio();
      var postUserData = UserDataModel(user: userData[0]);
      var jsonData = jsonEncode(postUserData.toJson());
      var formData = FormData.fromMap({"jsondata": jsonData});
      formData.files
          .add(MapEntry("file", await MultipartFile.fromFile(picOrigin)));
      print(formData);
      print(picOrigin);
      int responseStatus = await RegisterService.registerUser(formData);

      if (responseStatus == 200) {
        print("成功");
        fetchCategoryList();
        Get.to(SelectLikePage());
      } else {
        print("失敗");
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchCategoryList() async {
    CategoryListModel response = await RegisterService.fetchCategoryList();
    try {
      if (response.status == 200) {
        if (response.data != null) {
          print(categoryList);
          categoryList.value = response.data;
        }
      }
    } catch (e) {
      print(e);
    } finally {}
  }

  void tabCategory(int index) {
    var choiceId = categoryList.value[index].cid;
    if (finalCategoryList.contains(choiceId)) {
      finalCategoryList.remove(choiceId);
    } else {
      finalCategoryList.add(choiceId);
    }
    print(finalCategoryList);
  }

  void addCategory() async {
    for (var id in finalCategoryList) {
      Map<String, dynamic> postJsonData = {"uid": googleId, "cid": id};
      int response =
          await RegisterService.addCategory(jsonEncode(postJsonData));
      if (response == 200) {
      } else {
        print("can't post");
        break;
      }
    }
  }
}
