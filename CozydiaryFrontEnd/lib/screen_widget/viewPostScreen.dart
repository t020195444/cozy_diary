import 'package:cozydiary/pages/Home/HomePageTabbar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';
import 'package:cozydiary/screen_widget/viewPostController.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewPostScreen extends StatelessWidget {
  ViewPostScreen({Key? key, required this.pid}) : super(key: key);
  final String pid;
  // final String isCollect;

  //controller
  final commentCtr = TextEditingController();
  final updateCommentCtr = TextEditingController();
  final updateTitleCtr = TextEditingController();
  final updateContentCtr = TextEditingController();
  // final viewPostController = Get.put(ViewPostController());
  var uid = Hive.box("UidAndState").get('uid');
  @override
  Widget build(BuildContext context) {
    // viewPostController.currViewPostID = pid;
    // viewPostController.getPostDetail();
    final viewPostController = Get.put(ViewPostController(pid: pid));

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      viewPostController.updateLikes(pid, uid);
      return !isLiked;
    }

    Future<bool> onCollectButtonTapped(bool isLiked) async {
      viewPostController.updateCollects(pid, uid);
      return !isLiked;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back();
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(ViewPostController.currPostCover.pic),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(ViewPostController.currPostCover.username),
                )
              ],
            ),
            actions: [
              Hive.box('UidAndState').get('uid') ==
                      ViewPostController.currPostCover.uid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Center(child: Text('請選擇動作')),
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      //initState
                                      updateTitleCtr.text = viewPostController
                                          .currViewPostDetial.value.title;
                                      updateContentCtr.text = viewPostController
                                          .currViewPostDetial.value.content;
                                      Navigator.pop(context, '編輯貼文');
                                      showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: const Text('修改貼文'),
                                                content: Container(
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                        controller:
                                                            updateTitleCtr,
                                                        maxLines: 1,
                                                        maxLength: 15,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: '修改標題...',
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller:
                                                            updateContentCtr,
                                                        maxLines: 1,
                                                        maxLength: 30,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText: '修改內文...',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      if (updateTitleCtr.text ==
                                                              '' ||
                                                          updateContentCtr
                                                                  .text ==
                                                              '') {
                                                        Fluttertoast.showToast(
                                                            msg: "標題或內文不可為空白",
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
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                      } else {
                                                        viewPostController
                                                            .updatePost(
                                                                pid,
                                                                updateTitleCtr
                                                                    .text,
                                                                updateContentCtr
                                                                    .text);
                                                        Navigator.pop(
                                                            context, '確認');
                                                      }
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
                                              ));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Center(child: Text('編輯貼文')),
                                    ),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.pop(context, '刪除貼文');
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Text('確定要刪除貼文嗎'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await viewPostController
                                                    .deletePost(pid);

                                                Navigator.pop(context, '確認');
                                                Get.back();
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
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6),
                                      child: Center(child: Text('刪除貼文')),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.more_horiz))
                  : Container()
            ]),
        body: Obx((() => viewPostController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.4,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => _viewPostPic());
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Image.network(
                          viewPostController
                              .currViewPostDetial.value.postFiles[0].postUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                        height: 50,
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Obx(
                              () => LikeButton(
                                  padding: EdgeInsets.all(8),
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  likeCount: viewPostController
                                      .currViewPostDetial.value.likes,
                                  isLiked:
                                      viewPostController.buttonIsLiked.value,
                                  size: 25,
                                  onTap: onLikeButtonTapped),
                            ),
                            LikeButton(
                              likeBuilder: (isLiked) {
                                return isLiked
                                    ? Icon(Icons.bookmark_outlined)
                                    : Icon(Icons.bookmark_border);
                              },
                              padding: EdgeInsets.all(8),
                              mainAxisAlignment: MainAxisAlignment.start,
                              likeCount: viewPostController
                                  .currViewPostDetial.value.collects,
                              isLiked:
                                  viewPostController.buttonIsCollected.value,
                              size: 25,
                            ),
                          ],
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 24.0, right: 8.0),
                    child: ExpandableNotifier(
                      child: ExpandableButton(
                        child: ExpandablePanel(
                          header: Text(
                            viewPostController.currViewPostDetial.value.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 22),
                          ),
                          theme: ExpandableThemeData(
                            useInkWell: false,
                            hasIcon: false,
                          ),
                          collapsed: Text(
                            viewPostController.currViewPostDetial.value.content,
                            style: TextTheme().titleMedium,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Text(
                              viewPostController
                                  .currViewPostDetial.value.content,
                              style: TextTheme().titleMedium),
                          builder: (_, collapsed, expanded) => Expandable(
                            collapsed: collapsed,
                            expanded: expanded,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Text(viewPostController.currViewPostDetial.value['content']),
                  Divider(
                    thickness: 2,
                  ),
                  if (viewPostController
                      .currViewPostDetial.value.comments.isEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, top: 10),
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
                                .currViewPostDetial.value.comments.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    //去使用者頁面
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          viewPostController.currViewPostDetial
                                              .value.comments[index].pic),
                                    ),
                                    title: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          viewPostController.currViewPostDetial
                                              .value.comments[index].username,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 12.0),
                                          child: Text(
                                            viewPostController
                                                .currViewPostDetial
                                                .value
                                                .comments[index]
                                                .text,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                // fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 218, 196, 183)),
                                          ),
                                        ),
                                      ],
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 45,
                                          child: TextButton(
                                              onPressed: () {
                                                viewPostController
                                                    .postAdditionComment(
                                                        '測試',
                                                        viewPostController
                                                            .currViewPostDetial
                                                            .value
                                                            .comments[index]
                                                            .commentId
                                                            .toString());
                                              },
                                              child: Text('回覆',
                                                  style:
                                                      TextStyle(fontSize: 12))),
                                        ),
                                        viewPostController
                                                        .currViewPostDetial
                                                        .value
                                                        .comments[index]
                                                        .uid ==
                                                    Hive.box("UidAndState")
                                                        .get('uid') ||
                                                viewPostController
                                                        .currViewPostDetial
                                                        .value
                                                        .uid ==
                                                    Hive.box("UidAndState")
                                                        .get('uid')
                                            ? SizedBox(
                                                height: 40,
                                                width: 45,
                                                child: TextButton(
                                                    onPressed: () {
                                                      var uid = Hive.box(
                                                              "UidAndState")
                                                          .get('uid');
                                                      if (uid ==
                                                          viewPostController
                                                              .currViewPostDetial
                                                              .value
                                                              .comments[index]
                                                              .uid) {
                                                        updateCommentCtr.text =
                                                            viewPostController
                                                                .currViewPostDetial
                                                                .value
                                                                .comments[index]
                                                                .text;
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              AlertDialog(
                                                            title: const Text(
                                                                '編輯留言'),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context,
                                                                      '編輯');
                                                                  showDialog<
                                                                      String>(
                                                                    context:
                                                                        context,
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          '修改留言'),
                                                                      content:
                                                                          TextField(
                                                                        controller:
                                                                            updateCommentCtr,
                                                                        maxLines:
                                                                            1,
                                                                        maxLength:
                                                                            30,
                                                                        decoration:
                                                                            InputDecoration(
                                                                          border:
                                                                              InputBorder.none,
                                                                          hintText:
                                                                              '修改留言...',
                                                                        ),
                                                                      ),
                                                                      actions: <
                                                                          Widget>[
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (updateCommentCtr.text !=
                                                                                '') {
                                                                              viewPostController.updateComment(viewPostController.currViewPostDetial.value.comments[index].commentId.toString(), updateCommentCtr.text);
                                                                              updateCommentCtr.clear();
                                                                            } else {
                                                                              viewPostController.deleteComment(viewPostController.currViewPostDetial.value.comments[index].commentId);
                                                                              Fluttertoast.showToast(msg: "已刪除留言", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.blue, textColor: Colors.white, fontSize: 16.0);
                                                                            }
                                                                            Navigator.pop(context,
                                                                                '確認');
                                                                          },
                                                                          child:
                                                                              const Text('確認'),
                                                                        ),
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context,
                                                                                '取消');
                                                                          },
                                                                          child:
                                                                              const Text('取消'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  );
                                                                },
                                                                child:
                                                                    const Text(
                                                                        '編輯'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  viewPostController.deleteComment(viewPostController
                                                                      .currViewPostDetial
                                                                      .value
                                                                      .comments[
                                                                          index]
                                                                      .commentId);
                                                                  Navigator.pop(
                                                                      context,
                                                                      '刪除');
                                                                },
                                                                child:
                                                                    const Text(
                                                                        '刪除'),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      } else if (viewPostController
                                                              .currViewPostDetial
                                                              .value
                                                              .uid ==
                                                          Hive.box(
                                                                  "UidAndState")
                                                              .get('uid')) {
                                                        showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                    title: const Text(
                                                                        '刪除留言'),
                                                                    actions: <
                                                                        Widget>[
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          viewPostController.deleteComment(viewPostController
                                                                              .currViewPostDetial
                                                                              .value
                                                                              .comments[index]
                                                                              .commentId);
                                                                          Navigator.pop(
                                                                              context,
                                                                              '刪除');
                                                                        },
                                                                        child: const Text(
                                                                            '刪除'),
                                                                      ),
                                                                    ]));
                                                      }
                                                    },
                                                    child: Text(
                                                      '編輯',
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    )),
                                              )
                                            : Container()
                                      ],
                                    ),
                                    // dense: true,
                                    trailing: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: LikeButton(
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    ),
                ],
              ))),
        bottomSheet: Container(
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
                      viewPostController.postComments(commentCtr.text);
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
                    viewPostController
                        .currViewPostDetial.value.postFiles[index].postUrl,
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
              viewPostController.currViewPostDetial.value.postFiles.length,
        ),
      ),
    );
  }
}
