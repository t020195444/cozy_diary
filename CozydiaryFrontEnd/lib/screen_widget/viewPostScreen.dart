import 'package:cozydiary/LocalDB/UidAndState.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';
import 'package:cozydiary/screen_widget/viewPostController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewPostScreen extends StatelessWidget {
  ViewPostScreen({Key? key, required this.pid}) : super(key: key);
  final String pid;

  //controller
  final commentCtr = TextEditingController();
  final updateCommentCtr = TextEditingController();
  final updateTitleCtr = TextEditingController();
  final updateContentCtr = TextEditingController();
  final viewPostController = Get.put(ViewPostController());

  @override
  Widget build(BuildContext context) {
    viewPostController.currViewPostID = pid;
    viewPostController.getPostDetail();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        )),
        body: Obx((() => viewPostController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => _viewPostPic());
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Hero(
                              tag: 'pic',
                              child: Image.network(
                                viewPostController.currViewPostDetial
                                    .value['postFiles'][0]['postUrl'],
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              )),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                              ViewPostController.currPostCover.pic),
                        ),
                        title: Text(viewPostController
                            .currViewPostDetial.value['title']),
                        subtitle: Text(viewPostController
                            .currViewPostDetial.value['content']),
                        trailing: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.1,
                          child: Hive.box('UidAndState').get('uid') ==
                                  viewPostController.currViewPostDetial['uid']
                              ? IconButton(
                                  onPressed: () {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('修改貼文'),
                                        content: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: updateTitleCtr,
                                                maxLines: 1,
                                                maxLength: 15,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '修改標題...',
                                                ),
                                              ),
                                              TextField(
                                                controller: updateContentCtr,
                                                maxLines: 1,
                                                maxLength: 30,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: '修改內文...',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              if (updateTitleCtr.text != '' &&
                                                  updateContentCtr.text != '') {
                                                viewPostController.updatePost(
                                                    pid,
                                                    updateTitleCtr.text,
                                                    updateContentCtr.text);

                                                Navigator.pop(context, '確認');
                                              } else if (updateTitleCtr.text !=
                                                  '') {
                                                viewPostController.updatePost(
                                                    pid,
                                                    updateTitleCtr.text,
                                                    viewPostController
                                                            .currViewPostDetial[
                                                        'content']);
                                                Navigator.pop(context, '確認');
                                              } else if (updateContentCtr
                                                      .text !=
                                                  '') {
                                                viewPostController.updatePost(
                                                    pid,
                                                    viewPostController
                                                            .currViewPostDetial[
                                                        'title'],
                                                    updateContentCtr.text);
                                                Navigator.pop(context, '確認');
                                              } else if (updateTitleCtr.text ==
                                                      '' &&
                                                  updateContentCtr.text == '') {
                                                Navigator.pop(context, '確認');
                                              }
                                              updateTitleCtr.clear();
                                              updateContentCtr.clear();
                                            },
                                            child: const Text('確認'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context, '取消');
                                            },
                                            child: const Text('取消'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.edit)) //編輯貼文
                              : null,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  if (viewPostController
                      .currViewPostDetial.value['comments'].isEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Container(
                          child: Text('目前還沒有人留言'),
                        ),
                      ),
                    )
                  else
                    Obx(
                      () => Expanded(
                        child: ListView.builder(
                            itemCount: viewPostController
                                .currViewPostDetial.value['comments'].length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    //去使用者頁面
                                  },
                                  onLongPress: () {
                                    var uid =
                                        Hive.box("UidAndState").get('uid');
                                    if (uid ==
                                        viewPostController
                                                .currViewPostDetial['comments']
                                            [index]['uid']) {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('編輯留言'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, '編輯');
                                                showDialog<String>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: const Text('修改留言'),
                                                    content: TextField(
                                                      controller:
                                                          updateCommentCtr,
                                                      maxLines: 1,
                                                      maxLength: 30,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText: '修改留言...',
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          if (updateCommentCtr
                                                                  .text !=
                                                              '') {
                                                            viewPostController.updateComment(
                                                                viewPostController
                                                                    .currViewPostDetial[
                                                                        'comments']
                                                                        [index][
                                                                        'commentId']
                                                                    .toString(),
                                                                updateCommentCtr
                                                                    .text);
                                                            updateCommentCtr
                                                                .clear();
                                                          } else {
                                                            viewPostController.deleteComment(
                                                                viewPostController
                                                                            .currViewPostDetial[
                                                                        'comments'][index]
                                                                    [
                                                                    'commentId']);
                                                            Fluttertoast.showToast(
                                                                msg: "已刪除留言",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .CENTER,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors.blue,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          }
                                                          Navigator.pop(
                                                              context, '確認');
                                                        },
                                                        child: const Text('確認'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, '取消');
                                                        },
                                                        child: const Text('取消'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: const Text('編輯'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                viewPostController.deleteComment(
                                                    viewPostController
                                                                .currViewPostDetial[
                                                            'comments'][index]
                                                        ['commentId']);
                                                Navigator.pop(context, '刪除');
                                              },
                                              child: const Text('刪除'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          viewPostController.currViewPostDetial
                                              .value['comments'][index]['pic']),
                                    ),
                                    title: Text(
                                      viewPostController.currViewPostDetial
                                          .value['comments'][index]['username'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      viewPostController.currViewPostDetial
                                          .value['comments'][index]['text'],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    trailing: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: LikeButton(),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
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
                                  viewPostController
                                      .postComments(commentCtr.text);
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
                  ),
                ],
              ))),
      ),
    );
  }
}

class _viewPostPic extends StatelessWidget {
  const _viewPostPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewPostController viewPostController = Get.find<ViewPostController>();
    return Material(
      child: InkWell(
        onTap: () => {Get.back()},
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
                      viewPostController.currViewPostDetial.value['postFiles']
                          [index]['postUrl'],
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )),
              );
            },
            itemCount:
                viewPostController.currViewPostDetial.value['postFiles'].length,
          ),
        ),
      ),
    );
  }
}
