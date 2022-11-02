import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';
import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityViewPostScreen extends StatelessWidget {
  //Controller
  final commentCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Get.to(HomePageTabbar());
        },
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: () {
                    Get.to(_viewPostPic());
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Hero(
                          tag: 'pic',
                          child: Image.network(
                            ActivityPostService.activityDetailList['url'][0],
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                )),
            Divider(
              thickness: 2,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                              ActivityPostService.activityDetailList['title']),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(ActivityPostService
                              .activityDetailList['content'])),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class _viewPostPic extends StatelessWidget {
  const _viewPostPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => {Get.to(ActivityViewPostScreen())},
        child: Hero(
          tag: 'pic',
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            key: UniqueKey(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.only(top: 150, bottom: 150),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
                    child: Image.network(
                        ActivityPostService.activityDetailList['url'][index])),
              );
            },
            itemCount: ActivityPostService.activityDetailList['url'].length,
          ),
        ),
      ),
    );
  }
}
