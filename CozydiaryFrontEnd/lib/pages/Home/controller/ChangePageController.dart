import 'package:cozydiary/pages/Activity/PostActivityPage.dart';
import 'package:cozydiary/pages/Home/widget/pickPhotoPage.dart';
import 'package:get/get.dart';

class ChangePageTabbarController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 0;
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
    update();
  }

  void oncircleItemsTapped() {
    Get.to(PickPhotoPage());
  }

  void oncircleItemsTappeduser() {
    Get.to(PostActivityPage());
  }
}
