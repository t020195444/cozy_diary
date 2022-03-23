import 'package:cozydiary/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CheckAuth(),
                    ));
                //_nextPage(-1);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Center(
          child: Stack(
            children: <Widget>[
              const Center(
                  child: Align(
                alignment: Alignment(0.0, -0.5),
                child: Text(
                  "CozyDiary",
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                  ),
                ),
              )),
              Center(
                  child: Align(
                alignment: const Alignment(0.0, -0.30),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 70.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: "請輸入電話",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)))),
                  ),
                ),
              )),
              const Center(
                child: Align(
                    alignment: Alignment(0.0, -0.05),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 70.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFFFFFFF),
                          hintText: "請輸入密碼",
                          prefixIcon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100))),
                        ),
                      ),
                    )),
              ),
              const Center(
                // ignore: deprecated_member_use
                child: Align(
                    alignment: Alignment(0.0, 0.2),
                    // ignore: deprecated_member_use
                    child: SizedBox(
                        width: 260,
                        height: 40,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          onPressed: btnClickEvent,
                          child: Text(
                            "登入",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          color: Color.fromARGB(255, 108, 254, 230),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ))),
              ),
              Center(
                  child: Align(
                      alignment: const Alignment(0.1, 0.33),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        child: const Text(
                          "建立帳號",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "registerpage");
                        },
                      ))),
              Center(
                  child: Align(
                      alignment: const Alignment(0.57, 0.33),
                      // ignore: deprecated_member_use
                      child: TextButton(
                        child: const Text(
                          "忘記密碼?",
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "googleLogin");
                        },
                      ))),
            ],
          ),
        ));
  }
}

void btnClickEvent() {}
