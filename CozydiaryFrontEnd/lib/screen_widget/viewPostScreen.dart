import 'package:cozydiary/postJsonService.dart';
import 'package:cozydiary/pages/Home/homePageTabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:cozydiary/screen_widget/viewPostController.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'viewPostController.dart';

class ViewPostScreen extends StatelessWidget {
  //Controller
  final commentCtr = TextEditingController();
  final _viewPostController = viewPostController();

  @override
  Widget build(BuildContext context) {
    print(viewPostController.currViewPostDetial);
    print(viewPostController.currViewPostDetial['comments']);
    return SafeArea(
      child: Scaffold(
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
                            viewPostController.currViewPostDetial['url'][0],
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                )),
            Divider(
              thickness: 2,
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: Text(
                              viewPostController.currViewPostDetial['title']),
                        )),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Text(viewPostController
                              .currViewPostDetial['content'])),
                    )
                  ],
                ),
              ),
            ),
            viewPostController.currViewPostDetial['comments'].isEmpty
                ? Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Container(
                          child: Text('目前還沒有人留言'),
                        ),
                      ),
                    ))
                : Obx(
                    () => Expanded(
                        flex: 4,
                        child: ListView.builder(
                            itemCount: viewPostController
                                .currViewPostDetial['comments'].length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        'https://cdn.realsport101.com/images/ncavvykf/epicstream/89bba69c108a1c7a718b8e3cb8831e6fba8925da-1920x1080.jpg?rect=0,0,1919,1080&w=686&h=386&auto=format&dpr=2'),
                                  ),
                                  title: Text(viewPostController
                                          .currViewPostDetial['comments'][index]
                                      ['uid']),
                                  subtitle: Text(
                                    viewPostController
                                            .currViewPostDetial['comments']
                                        [index]['text'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: LikeButton(),
                                  ),
                                ),
                              );
                            }))),
                  ),
            Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: TextField(
                    controller: commentCtr,
                    maxLines: 1,
                    maxLength: 30,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          if (commentCtr.text != '') {
                            _viewPostController.postComments(commentCtr.text);
                            commentCtr.clear();
                          } else {
                            Fluttertoast.showToast(
                                msg: "留言不可為空白",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      ),
                      border: InputBorder.none,
                      hintText: '發表言論...',
                    ),
                  ),
                ),
              ),
            )
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
                        viewPostController.currViewPostDetial['url'][index])),
              );
            },
            itemCount: viewPostController.currViewPostDetial['url'].length,
          ),
        ),
      ),
    );
  }
}
