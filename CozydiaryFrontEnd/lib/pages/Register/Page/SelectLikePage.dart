import 'package:cozydiary/pages/Home/homePageTabbar.dart';
import 'package:cozydiary/pages/Register/Controller/categoryController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widget/selectlike_ThemeCard.dart';

class SelectLikePage extends StatelessWidget {
  const SelectLikePage({Key? key, required this.isRegiststate})
      : super(key: key);
  final bool isRegiststate;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
        init: CategoryController(registState: isRegiststate),
        builder: (categoryController) {
          return Scaffold(
            // backgroundColor: Color.fromRGBO(234, 230, 228, 1),
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                "選擇主題",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              leading: SafeArea(
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              bottom: PreferredSize(
                child: Column(
                  children: [
                    Text(
                      "至少選擇一個平常會關注的主題吧！",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                preferredSize: Size(MediaQuery.of(context).size.width, 30),
              ),
            ),
            body: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: MediaQuery.of(context).size.width * 0.1),
                child: ScrollConfiguration(
                  behavior: customScrollBehavior(),
                  child: GridView.builder(
                    controller: ScrollController(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 15,
                        crossAxisSpacing: 8),
                    itemCount: categoryController.categoryList.length,
                    itemBuilder: (context, index) {
                      return SelectLike_ThemeCard(
                        registState: isRegiststate,
                        index: index,
                      );
                    },
                  ),
                )),
            floatingActionButton: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                child: Text("完成"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () async {
                  int status = await categoryController.addUserCategory();
                  
                  if (status == 200) {
                    if (categoryController.registState) {
                      Get.back();
                      Get.showSnackbar(GetSnackBar(
                        title: "通知",
                        icon: Icon(
                          Icons.done,
                          color: Colors.green[400],
                        ),
                        message: "修改類別成功",
                        duration: const Duration(seconds: 3),
                      ));
                    } else {
                      Get.offAll(HomePageTabbar());
                    }
                  }
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        });
  }
}

//這個是可以消除Scroll glow，只要放到ScrollConfiguration的behavior屬性就好
class customScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
