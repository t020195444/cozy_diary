import 'package:cozydiary/postJsonService.dart';
import 'package:cozydiary/pages/Home/homePageTabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPostScreen extends StatelessWidget {
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
      body: Column(
        children: [
          // Expanded(
          //   flex: 5,
          //   child: Container(),
          // ),
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
                          PostService.postDetailList['url'][0],
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
                        child: Text(PostService.postDetailList['title']),
                      )),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(PostService.postDetailList['content'])),
                  )
                ],
              )),
          PostService.postDetailList['comment'] == null
              ? Expanded(
                  flex: 2,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Container(
                        child: Text('目前還沒有人留言'),
                      ),
                    ),
                  ))
              : Container(
                  //留言
                  ),
          Expanded(
            flex: 2,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: TextField(
                  controller: commentCtr,
                  maxLines: 1,
                  maxLength: 30,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '發表言論...',
                  ),
                ),
              ),
            ),
          )
        ],
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
        onTap: () => {Get.to(ViewPostScreen())},
        child: Hero(
          tag: 'pic',
          child: ListView.builder(
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
                        PostService.postDetailList['url'][index])),
              );
            },
            itemCount: PostService.postDetailList['url'].length,
          ),
        ),
      ),
    );
  }
}
