import 'package:cozydiary/pages/Register/Widget/selectlike_GridView.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLikePage extends StatelessWidget {
  const SelectLikePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(234, 230, 228, 1),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: SafeArea(
              child: Text(
            "選擇主題",
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 147, 147, 147),
                fontWeight: FontWeight.bold),
          )),
          leading: SafeArea(
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                Get.back();
              },
              color: Color.fromARGB(255, 132, 132, 132),
            ),
          ),
          bottom: PreferredSize(
            child: Column(
              children: [
                Text(
                  "至少選擇一個平常會關注的主題吧！",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 163, 163, 163),
                  ),
                ),
              ],
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 30),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: SelectLikeGridView(),
          ),
        ));
  }
}
