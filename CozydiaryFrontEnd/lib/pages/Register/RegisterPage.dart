import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:cozydiary/login_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  Widget choiceGender() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Color.fromARGB(255, 179, 141, 113)),
              child: Icon(
                Icons.boy_outlined,
                size: 80,
                color: Color.fromARGB(255, 88, 67, 50),
              ),
            ),
            Text(
              "男",
              style: TextStyle(color: Colors.black87, fontSize: 22),
            )
          ],
        ),
        Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Color.fromARGB(255, 179, 141, 113)),
              child: Icon(
                Icons.girl_outlined,
                size: 80,
                color: Color.fromARGB(255, 88, 67, 50),
              ),
            ),
            Text(
              "女",
              style: TextStyle(color: Colors.black87, fontSize: 22),
            )
          ],
        )
      ],
    );
  }

  Widget nameTextField() {
    return TextFormField(
      maxLength: 20,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(hintText: "你的大名是?"),
      validator: (value) {
        if (value!.isEmpty) {
          return "請輸入姓名";
        }
        return null;
      },
    );
  }

  Widget userImage() {
    return Container(
      alignment: Alignment.center,
      height: 130,
      width: 130,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
      decoration: BoxDecoration(
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
    final LoginController logincontroller = Get.put(LoginController());
    final GlobalKey<FormState> _nameFormKey = GlobalKey<FormState>();
    String? birthText = DateFormat("yyyy-MM-dd").format(DateTime.now());
    late DateTime currentBirth = DateTime.now();
    Widget BirthDayTitle() {
      return ListTile(
          title: Text(
            birthText!,
            style: TextStyle(color: Color.fromARGB(130, 0, 0, 0)),
          ),
          dense: true,
          trailing: const Icon(
            Icons.keyboard_arrow_right_outlined,
            color: Colors.black,
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromARGB(105, 0, 0, 0), width: 1),
              borderRadius: BorderRadius.circular(30)),
          tileColor: Colors.white,
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: currentBirth,
                firstDate: DateTime(DateTime.now().year - 100),
                lastDate: DateTime.now());

            if (newDate == null) return;

            birthText = DateFormat("yyyy-MM-dd").format(newDate);
            currentBirth = newDate;
            // setState(
            //     () => birthDayText = DateFormat("yyyy-MM-dd").format(newDate));
            // OldbirthDay = newDate;
          });
    }

    Widget IntroductionTitle() {
      return Form(
        child: TextFormField(
          validator: (value) {
            if (value!.length > 301) {
              return "字數需低於300個字";
            }
            return null;
          },
          maxLines: 10,
          maxLength: 300,
          decoration: InputDecoration(
              hintText: "打點什麼介紹自己吧~",
              hintStyle: TextStyle(color: Colors.black38),
              floatingLabelBehavior: FloatingLabelBehavior.always),
          style: TextStyle(color: Colors.black, fontSize: 14),
          textInputAction: TextInputAction.done,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 175, 154),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "歡迎來到CozyDiary",
                  style: TextStyle(color: Colors.black87, fontSize: 35),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    "填寫您的個人資訊吧!",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Divider(
              height: 3,
              indent: 30,
              endIndent: 30,
              color: Color.fromARGB(255, 135, 110, 95),
            ),
          ),
          userImage(),
          Padding(
            child: nameTextField(),
            padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 0, 20),
              child: Text(
                "您的性別",
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
              child: choiceGender()),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
              child: Text(
                "您的生日",
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Divider(
              height: 3,
              indent: 30,
              endIndent: 30,
              color: Color.fromARGB(255, 135, 110, 95),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
            child: BirthDayTitle(),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 0, 10),
              child: Text(
                "自我介紹",
                style: TextStyle(color: Colors.black87, fontSize: 22),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Divider(
              height: 3,
              indent: 30,
              endIndent: 30,
              color: Color.fromARGB(255, 135, 110, 95),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 30, 0),
            child: IntroductionTitle(),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 135, 110, 95),
                textStyle: TextStyle(
                    color: Color.fromARGB(255, 135, 110, 95), fontSize: 16),
                minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text("完成"),
              onPressed: () {},
            ),
          )
        ]),
      ),
    );
  }
}
