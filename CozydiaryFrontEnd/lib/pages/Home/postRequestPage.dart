import 'package:cozydiary/pages/Home/widget/pickPhotoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PostRequestPage extends StatelessWidget {
  const PostRequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("發文")),
        body: ListTile(
          onTap: () => Get.to(PickPhotoPage()),
          title: Text("發文"),
        ));
  }
}
