import 'package:cozydiary/login_controller.dart';
import 'package:cozydiary/register_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  final registerController = Get.put(RegisterController());
  final logincontroller = Get.put(LoginController());
  final ScrollController scrollController = ScrollController();
  final controller = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  void scrollTotop() {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }

//選擇性別
  Widget choiceGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  registerController.choicemen();
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: registerController.sex.value == "0"
                        ? const Color.fromARGB(255, 179, 141, 113)
                        : const Color.fromARGB(255, 255, 255, 255)),
                child: const Icon(
                  Icons.boy_outlined,
                  size: 50,
                  color: Color.fromARGB(255, 88, 67, 50),
                ),
              ),
            ),
            const Text(
              "男",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            )
          ],
        ),
        Column(
          children: <Widget>[
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  registerController.choicegril();
                },
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    primary: registerController.sex.value == "0"
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 179, 141, 113)),
                child: const Icon(
                  Icons.girl_outlined,
                  size: 50,
                  color: Color.fromARGB(255, 88, 67, 50),
                ),
              ),
            ),
            const Text(
              "女",
              style: TextStyle(color: Colors.black87, fontSize: 18),
            )
          ],
        )
      ],
    );
  }

//姓名
  Widget nameTextField() {
    return SizedBox(
      height: 70.0,
      width: 230,
      child: TextFormField(
        maxLength: 20,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: const TextStyle(color: Colors.black),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        ),
        initialValue: registerController.name.value,
        validator: (value) {
          if (value!.isEmpty) {
            return "請輸入姓名";
          }
          return null;
        },
        onSaved: (String? name) {
          registerController.name.value = name!;
        },
      ),
    );
  }

//使用者頭貼
  Widget userImage() {
    return Stack(
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            height: 80,
            width: 80,
            margin: const EdgeInsets.fromLTRB(2, 20, 5, 15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: registerController.previewImage.value == null
                        ? NetworkImage(logincontroller.googlepic)
                        : FileImage(registerController.previewImage.value!)
                            as ImageProvider,
                    fit: BoxFit.cover),
                border: Border.all(color: Colors.white, width: 2.5),
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 6),
                      blurRadius: 5,
                      spreadRadius: 0)
                ]),
          ),
        ),
        Positioned(
          top: 75,
          right: 0,
          child: SizedBox(
            width: 32,
            height: 32,
            child: TextButton(
                child: const Icon(
                  Icons.camera_alt,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 19,
                ),
                onPressed: () {
                  registerController.openImagePicker();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  primary: Color.fromARGB(255, 127, 236, 215),
                )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    late DateTime currentBirth = DateTime.now();
    Widget BirthDayTitle() {
      return SizedBox(
        height: 35,
        width: 230,
        child: ListTile(
            title: Padding(
              padding: EdgeInsets.fromLTRB(55, 0, 0, 15),
              child: Obx(
                () => registerController.birth.value == "2000-01-01"
                    ? Text(
                        "選擇你的生日",
                        style: TextStyle(
                          color: Color.fromARGB(150, 0, 0, 0),
                          fontSize: 14,
                        ),
                      )
                    : Text(
                        registerController.birth.value,
                        style: TextStyle(
                          color: Color.fromARGB(150, 0, 0, 0),
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
            dense: true,
            trailing: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: const Icon(
                Icons.keyboard_arrow_right_outlined,
                color: Colors.black,
              ),
            ),
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: Color.fromARGB(105, 0, 0, 0), width: 1),
                borderRadius: BorderRadius.circular(30)),
            tileColor: Colors.white,
            onTap: () async {
              DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: currentBirth,
                  firstDate: DateTime(DateTime.now().year - 100),
                  lastDate: DateTime.now());

              if (newDate == null) return;
              registerController.birth.value =
                  DateFormat("yyyy-MM-dd").format(newDate);
            }),
      );
    }

//自我介紹
    Widget introductionTitle() {
      return TextFormField(
        validator: (value) {
          if (value!.length > 301) {
            return "字數需低於300個字";
          }
          return null;
        },
        onSaved: (String? introduction) {
          registerController.introduction.value = introduction!;
        },
        maxLines: 1,
        maxLength: 300,
        decoration: const InputDecoration(
            hintText: "簡單介紹自己吧~",
            hintStyle: TextStyle(color: Colors.black38),
            floatingLabelBehavior: FloatingLabelBehavior.always),
        style: const TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: TextInputAction.done,
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 175, 154),
      body: Form(
        key: registerFormKey,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  SizedBox(
                    height: 80,
                    width: 100,
                  ),
                  Text(
                    "歡迎來到CozyDiary~",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      "填寫您的個人資訊吧!",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 0),
            ),
            userImage(),
            Padding(
              child: nameTextField(),
              padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 20),
                child: Text(
                  "您的性別",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                child: choiceGender()),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                // child: Text(
                //   "您的生日",
                //   style: TextStyle(color: Colors.black87, fontSize: 18),
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
              child: BirthDayTitle(),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 10),
                child: Text(
                  "簡介",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
              child: introductionTitle(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 135, 110, 95),
                  textStyle: const TextStyle(
                      color: Color.fromARGB(255, 135, 110, 95), fontSize: 16),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("完成"),
                onPressed: () {
                  registerFormKey.currentState?.save();
                  if (registerController.name != "") {
                    registerController.adddata();
                    registerController.register();
                  } else {
                    scrollTotop();
                  }
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
