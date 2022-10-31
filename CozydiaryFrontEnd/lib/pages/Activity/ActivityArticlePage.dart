import 'package:cozydiary/pages/Activity/controller/ActivityPostController.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ActivityArticlePage extends StatelessWidget {
  const ActivityArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Controller
    final postController = new ActivityPostController();

    final titleCtr = TextEditingController();
    final contentCtr = TextEditingController();

    Widget BirthDayTitle() {
      return SizedBox(
        height: 35,
        width: 300,
        child: ListTile(
          title: Padding(
            padding: EdgeInsets.fromLTRB(55, 0, 0, 15),
            child: Obx(
              () => postController.activityTime.value == "2000-01-01"
                  ? Text(
                      "選擇活動時間",
                      style: TextStyle(
                        color: Color.fromARGB(150, 0, 0, 0),
                        fontSize: 14,
                      ),
                    )
                  : Text(
                      postController.activityTime.value,
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
            DateTime? newDateTime = await DatePicker.showDateTimePicker(context,
                showTitleActions: true,
                minTime: DateTime.now(),
                maxTime: DateTime(2023, 12, 31, 00, 00), onChanged: (date) {
              print('change $date');
            }, onConfirm: (date) {
              print('confirm $date');
            }, currentTime: DateTime.now(), locale: LocaleType.en);
            if (newDateTime == null) return;
            postController.activityTime.value = newDateTime.toString();
            print(newDateTime.hour);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                postController.goToDataBase();
                Get.to(HomePageTabbar());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '發布',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: titleCtr,
                maxLines: 1,
                maxLength: 15,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '請輸入活動名稱...',
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextField(
                controller: contentCtr,
                cursorColor: Colors.red,
                maxLines: 7,
                maxLength: 150,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '請輸入活動內容...',
                ),
              ),
            ),
          ),
          Container(
            child: BirthDayTitle(),
          )
        ],
      ),
    );
  }
}
