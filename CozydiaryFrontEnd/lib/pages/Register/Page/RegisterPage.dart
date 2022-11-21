import 'package:cozydiary/login_controller.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/register_controller.dart';

class RegisterPage extends StatelessWidget {
  final registerController = Get.put(RegisterController());
  final logincontroller = Get.find<LoginController>();
  final ScrollController scrollController = ScrollController();
  final controller = TextEditingController();

  final registerFormKey = GlobalKey<FormState>();

  void scrollTotop() {
    scrollController.jumpTo(scrollController.position.minScrollExtent);
  }

//選擇性別
  Widget choiceGender(BuildContext context) {
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
                    backgroundColor: registerController.sex.value == "0"
                        ? Theme.of(context).selectedRowColor
                        : Theme.of(context).primaryColorLight),
                child: const Icon(
                  Icons.boy_outlined,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              "男",
              style: TextStyle(fontSize: 18),
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
                    backgroundColor: registerController.sex.value == "0"
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).selectedRowColor),
                child: const Icon(
                  Icons.girl_outlined,
                  size: 50,
                  color: Colors.black,
                ),
              ),
            ),
            const Text(
              "女",
              style: TextStyle(fontSize: 18),
            )
          ],
        )
      ],
    );
  }

//姓名
  Widget nameTextField(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        maxLength: 20,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        // style: const TextStyle(color: Colors.black),
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          label: Text("姓名"),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: true,
          hintText: "您的大名是？",
          contentPadding: EdgeInsets.fromLTRB(10, 30, 10, 0),
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
  Widget userImage(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => Container(
            alignment: Alignment.center,
            height: 150,
            width: 150,
            margin: const EdgeInsets.fromLTRB(2, 20, 5, 15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: registerController.previewImage.value?.path == ""
                        ? AssetImage("assets/images/yunhan.jpg")
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
          top: 130,
          right: 0,
          child: SizedBox(
            width: 50,
            height: 50,
            child: TextButton(
                child: const Icon(
                  Icons.camera_alt,
                  size: 40,
                ),
                onPressed: () {
                  registerController.openImagePicker();
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                )),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //現在日期
    late DateTime currentBirth = DateTime.now();
    //選擇生日欄位
    Widget BirthDayTitle() {
      return ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Obx(
              () => registerController.birth.value == "2000-01-01"
                  ? Text("選擇你的生日",
                      style: Theme.of(context).textTheme.titleMedium)
                  : Text(registerController.birth.value,
                      style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
          dense: true,
          trailing: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
            child: const Icon(
              Icons.keyboard_arrow_right_outlined,
            ),
          ),
          // shape: RoundedRectangleBorder(
          //     side: const BorderSide(
          //         color: Color.fromARGB(105, 0, 0, 0), width: 1),
          //     borderRadius: BorderRadius.circular(30)),
          // tileColor: Colors.white,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: currentBirth,
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now());

            if (newDate == null) return;
            registerController.birth.value =
                DateFormat("yyyy-MM-dd").format(newDate);
          });
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
        maxLines: 5,
        maxLength: 300,
        decoration: const InputDecoration(
            hintText: "簡單介紹自己吧~",
            label: Text("簡介"),
            floatingLabelBehavior: FloatingLabelBehavior.always),
        // style: const TextStyle(color: Colors.black, fontSize: 14),
        textInputAction: TextInputAction.done,
      );
    }

    //主頁面架構
    return Scaffold(
      // backgroundColor: Color(0xFFF5E8DE),
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
                  //標題
                  Text(
                    "歡迎來到CozyDiary~",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Text(
                      "填寫您的個人資訊吧!",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            //間隔
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 0),
            ),
            //使用者照片
            userImage(context),
            //輸入名字欄位
            Padding(
              child: nameTextField(context),
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            ),
            //編輯生日欄位
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 10),
                child: Text(
                  "生日",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            BirthDayTitle(),
            Divider(
              indent: 50,
              endIndent: 40,
            ),

            //選擇性別按鈕
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 0, 20),
                child: Text(
                  "您的性別",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            Padding(
                padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
                child: choiceGender(context)),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                // child: Text(
                //   "您的生日",
                //   style: TextStyle(color: Colors.black87, fontSize: 18),
                // ),
              ),
            ),

            //自我介紹欄位
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: introductionTitle(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // backgroundColor: const Color.fromARGB(255, 135, 110, 95),
                  // textStyle: const TextStyle(fontSize: 16),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.8, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: const Text("完成"),
                onPressed: () {
                  registerFormKey.currentState?.save();
                  if (registerController.name != "") {
                    registerController.adddata(
                        logincontroller.id, logincontroller.email);
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
