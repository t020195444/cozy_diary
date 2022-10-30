import 'dart:io';
import 'package:cozydiary/pages/Home/controller/HomePostController.dart';
import 'package:cozydiary/Model/EditUserModel.dart';
import 'package:cozydiary/pages/Home/HomePage.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:cozydiary/pages/Personal/Self/Page/personal_page.dart';
import 'package:cozydiary/pages/Personal/Self/controller/selfController.dart';
import 'package:cozydiary/pages/Personal/Self/controller/editController.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../../userHeaderWidget.dart';

class Edit_PersonalPage extends StatelessWidget {
  Edit_PersonalPage({
    Key? key,
  }) : super(key: key);
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _introductionFormKey = GlobalKey<FormState>();
  final EditUserController editUserController = Get.put(EditUserController());
  final selfPageController = Get.find<SelfPageController>();

  Widget nameTextField() {
    return TextFormField(
      autofocus: true,
      maxLength: 20,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onSaved: (String? value) => editUserController.oldname.value = value!,
      controller: editUserController.nameController,
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.isEmpty) {
          return "請輸入姓名";
        }
        return null;
      },
    );
  }

  Widget nameTitle() {
    return ListTile(
        title: Text(
          editUserController.oldname.value,
          style: TextStyle(color: Color.fromARGB(130, 0, 0, 0)),
        ),
        dense: true,
        trailing: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        leading: Text(
          "姓名",
          style: TextStyle(color: Colors.black),
        ),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
            borderRadius: BorderRadius.circular(15)),
        tileColor: Colors.white,
        onTap: () {
          editUserController.setTextEditController();
          //buttonSheet
          Get.bottomSheet(
              BottomSheet(onClosing: () {}, builder: _buildNameBottomSheet));
          // showModalBottomSheet(
          //     context: context, builder: _buildNameBottomSheet);
        });
  }

  Widget _buildNameBottomSheet(
    BuildContext context,
  ) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "取消",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton(
                onPressed: () {
                  final isValid = _nameFormKey.currentState!.validate();
                  if (isValid) {
                    _nameFormKey.currentState!.save();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  "確認",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Form(key: _nameFormKey, child: nameTextField()),
        ),
      ],
    );
  }

  Widget IntroductionTitle() {
    return Form(
      key: _introductionFormKey,
      child: TextFormField(
        validator: (value) {
          if (value!.length > 301) {
            return "字數需低於300個字";
          }
          return null;
        },
        onSaved: (String? value) {
          editUserController.setIntroduction(value!);
        },
        maxLines: 10,
        controller: editUserController.introducionController,
        maxLength: 300,
        decoration: InputDecoration(
            hintText: "打點什麼介紹自己吧~",
            hintStyle: TextStyle(color: Colors.black38),
            label: Text("簡介"),
            labelStyle: TextStyle(color: Colors.black, fontSize: 16),
            floatingLabelBehavior: FloatingLabelBehavior.always),
        style: TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget SexTitle() {
    return ListTile(
      title: DropdownButton<String>(
        items: editUserController.gender.map((value) {
          return DropdownMenuItem(
            child: Text(
              value,
              style: TextStyle(color: Color.fromARGB(130, 0, 0, 0)),
            ),
            value: value,
          );
        }).toList(),
        elevation: 2,
        value: editUserController.currentSelect.value,
        isExpanded: true,
        underline: Container(
          height: 0,
        ),
        icon: Icon(
          Icons.keyboard_arrow_right_outlined,
          color: Colors.black,
        ),
        onChanged: (String? value) {
          editUserController.currentSelect.value = value!;
          editUserController.oldSex = value == "女" ? 0 : 1;
        },
      ),
      dense: true,
      // trailing: Icon(
      //   Icons.keyboard_arrow_right_outlined,
      //   color: Colors.black,
      // ),
      leading: Text(
        "性別",
        style: TextStyle(color: Colors.black),
      ),
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
          borderRadius: BorderRadius.circular(15)),
      tileColor: Colors.white,
    );
  }

  Widget UserHeader() {
    return Container(
      height: 130,
      width: 130,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: editUserController.isImageChange.value
                  ? editUserController.changedPreviewImage
                  : editUserController.defaultPreviewImage,
              fit: BoxFit.cover),
          border: Border.all(color: Colors.white, width: 2.5),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: Colors.black,
                offset: Offset(0, 3),
                blurRadius: 7,
                spreadRadius: 0)
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget BirthDayTitle() {
      return ListTile(
          title: Text(
            editUserController.birthDayText.value,
            style: TextStyle(color: Color.fromARGB(130, 0, 0, 0)),
          ),
          dense: true,
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.black,
          ),
          leading: const Text(
            "生日",
            style: TextStyle(color: Colors.black),
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
              borderRadius: BorderRadius.circular(15)),
          tileColor: Colors.white,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: editUserController.oldbirthDay,
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now());

            if (newDate == null) return;
            editUserController.setBirthDay(newDate);
          });
    }

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () async {
                final isValid = _introductionFormKey.currentState!.validate();
                if (isValid) {
                  _introductionFormKey.currentState!.save();
                  EditUserModel finalUserData =
                      editUserController.setEditData();

                  selfPageController
                      .updateUser(finalUserData)
                      .then((String value) {
                    Get.offAll(() => HomePageTabbar(), arguments: "hi");
                  });
                }
              },
              child: Text(
                "確認",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
          title: const Text(
            '編輯個人資料',
            style: TextStyle(color: Colors.black54),
          ),
        ),
        body: Obx(
          () {
            return ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    UserHeader(),
                    TextButton(
                        onPressed: () {
                          editUserController.openImagePicker();
                        },
                        child: Text(
                          "點擊更換頭貼",
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ))
                  ],
                ),
                // Divider(
                //   color: Color.fromARGB(132, 0, 0, 0),
                //   indent: MediaQuery.of(context).size.width * 0.05,
                //   endIndent: MediaQuery.of(context).size.width * 0.05,
                // ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: nameTitle()),

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: BirthDayTitle(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: SexTitle(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: IntroductionTitle(),
                ),
              ],
            );
          },
        ));
  }
}
