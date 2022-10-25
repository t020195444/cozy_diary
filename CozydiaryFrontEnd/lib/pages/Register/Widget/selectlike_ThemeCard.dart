import 'dart:ui';

import 'package:cozydiary/pages/Register/Controller/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/categoryController_Button.dart';

class SelectLike_ThemeCard extends StatelessWidget {
  const SelectLike_ThemeCard({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<RegisterController>();
    String assetsUrl = registerController.categoryAssetsList[index];
    String categoryName = registerController.categoryList.value[index].category;
    return GetBuilder<CategoryButtonController>(
        init: CategoryButtonController(),
        builder: (controller) {
          return InkWell(
            child: Container(
              child: Stack(
                children: [
                  ImageFiltered(
                    imageFilter: ImageFilter.blur(
                        sigmaX: 0.5, sigmaY: 0.5, tileMode: TileMode.decal),
                    child: Image.asset(
                      assetsUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(148, 45, 45, 45),
                            Color.fromARGB(28, 77, 75, 75)
                          ]),
                      border: Border.all(width: 0.2, color: Colors.white),
                    ),
                  ),
                  Center(
                    child: Text(
                      categoryName,
                      style: TextStyle(
                          color: Color.fromARGB(190, 231, 231, 231),
                          fontSize: 24),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: controller.isChoice[index]
                          ? Icon(
                              Icons.check_circle,
                              color: Color.fromARGB(186, 0, 0, 0),
                            )
                          : Icon(
                              Icons.circle_rounded,
                              color: Color.fromARGB(114, 0, 0, 0),
                            ))
                ],
              ),
            ),
            onTap: () {
              registerController.tabCategory(index);
              controller.tabCategory(index);
            },
          );
        });
  }
}
