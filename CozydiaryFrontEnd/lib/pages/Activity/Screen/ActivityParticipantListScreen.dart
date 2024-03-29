import 'package:cozydiary/pages/Activity/controller/ActivityGetPostController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ActivityParticipantListScreen extends StatelessWidget {
  //Controller
  final commentCtr = TextEditingController();

  ActivityGetPostController getPostController =
      Get.put(ActivityGetPostController());

  @override
  Widget build(BuildContext context) {
    getPostController.getActivityParticipantList();
    //主畫面
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text("審核列表")),
      body: ListView.builder(
          itemCount: getPostController.checkActivityParticipant.length,
          itemBuilder: ((context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    //去使用者頁面
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(getPostController
                          .checkActivityParticipant[index]['pic']),
                    ),
                    title: Text(
                      getPostController.checkActivityParticipant[index]['name'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      getPostController.checkActivityParticipant[index]
                          ['reason'],
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Obx(
                          () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 135, 110, 95),
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    40),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: getPostController
                                              .checkActivityParticipant[index]
                                          ['qualified'] ==
                                      0
                                  ? () async {
                                      await getPostController.checkParticipant(
                                          getPostController
                                              .checkActivityParticipant[index]
                                                  ['participant']
                                              .toString());

                                      await getPostController
                                          .getActivityParticipantList();
                                    }
                                  : null,
                              child: Obx(
                                () => getPostController
                                                .checkActivityParticipant[index]
                                            ['qualified'] ==
                                        0
                                    ? const Text("確認通過",
                                        style: TextStyle(color: Colors.white))
                                    : const Text(
                                        "已通過",
                                        style: TextStyle(color: Colors.white),
                                      ),
                              )),
                        )),
                  ),
                ));
          })),
    );
  }
}
