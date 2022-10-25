import 'package:get/get.dart';

class CategoryButtonController extends GetxController {
  var isChoice = <bool>[];
  @override
  void onInit() {
    isChoice = [false, false, false, false, false];
    super.onInit();
  }

  void tabCategory(int index) {
    if (isChoice[index]) {
      isChoice[index] = false;
    } else
      isChoice[index] = true;
    print(isChoice);
    update();
  }
}
