import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickPageController extends GetxController {
  final _imageFilePath = "".obs;
  set imageFilePath(value) => this._imageFilePath.value = value;
  get imageFilePath => this._imageFilePath.value;

  @override
  void onInit() {
    super.onInit();
  }

  getImage(ImageSource source) async {
    final _picker = ImagePicker();
    XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      imageFilePath = pickedFile.path;
    }
  }
}
