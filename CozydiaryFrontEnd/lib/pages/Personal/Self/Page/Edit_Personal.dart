import 'package:cozydiary/Model/catchPersonalModel.dart';
import 'package:cozydiary/Model/editUserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controller/editController.dart';

class Edit_PersonalPage extends StatelessWidget {
  Edit_PersonalPage({
    Key? key,
    required this.userData,
  }) : super(key: key);
  final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _introductionFormKey = GlobalKey<FormState>();
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    final EditUserController editUserController = Get.put(EditUserController());

    editUserController.initData(userData);
    Widget nameTextField() {
      return TextFormField(
        autofocus: true,
        maxLength: 20,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onSaved: (String? value) => editUserController.oldname.value = value!,
        controller: editUserController.nameController,
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
          ),
          dense: true,
          trailing: Icon(
            Icons.keyboard_arrow_right_outlined,
          ),
          leading: Text(
            "姓名",
          ),
          onTap: () {
            editUserController.setTextEditController();
            //buttonSheet
            Get.bottomSheet(BottomSheet(
                onClosing: () {},
                builder: ((context) => Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "取消",
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  final isValid =
                                      _nameFormKey.currentState!.validate();
                                  if (isValid) {
                                    _nameFormKey.currentState!.save();
                                    Get.back();
                                  }
                                },
                                child: Text(
                                  "確認",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child:
                              Form(key: _nameFormKey, child: nameTextField()),
                        ),
                      ],
                    ))));
          });
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
          maxLength: 200,
          decoration: InputDecoration(
              hintText: "打點什麼介紹自己吧~",
              label: Text("簡介"),
              floatingLabelBehavior: FloatingLabelBehavior.always),
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
            // color: Colors.black,
          ),
          onChanged: (String? value) {
            editUserController.currentSelect.value = value!;
            editUserController.oldSex = value == "女" ? 0 : 1;
          },
        ),
        dense: true,
        leading: Text(
          "性別",
        ),
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
              BoxShadow(offset: Offset(0, 3), blurRadius: 7, spreadRadius: 0)
            ]),
      );
    }

    Widget BirthDayTitle() {
      return ListTile(
          title: Text(
            editUserController.birthDayText.value,
          ),
          dense: true,
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
          ),
          leading: const Text(
            "生日",
          ),
          // shape: RoundedRectangleBorder(
          //     side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
          //     borderRadius: BorderRadius.circular(15)),
          // tileColor: Colors.white,
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
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: () async {
                final isValid = _introductionFormKey.currentState!.validate();
                if (isValid) {
                  _introductionFormKey.currentState!.save();
                  Get.dialog(SpinKitFadingCircle(
                      size: 50, color: Theme.of(context).colorScheme.primary));
                  EditUserModel finalUserData =
                      editUserController.setEditData();

                  await editUserController
                      .updateUser(finalUserData)
                      .then((String value) {
                    Get.back();
                    Get.back(result: value);
                  });
                }
              },
              child: Text(
                "確認",
              ),
            ),
          ],
          title: const Text(
            '編輯個人資料',
          ),
        ),
        body: Obx(
          () {
            return ListView(
              shrinkWrap: true,
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
