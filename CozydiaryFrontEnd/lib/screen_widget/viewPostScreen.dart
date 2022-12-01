import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';
import 'package:cozydiary/screen_widget/viewPostController.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class ViewPostScreen extends StatelessWidget {
  ViewPostScreen(
      {Key? key,
      required this.pid,
      required this.ownerPicUrl,
      required this.username,
      required this.ownerUid})
      : super(key: key);
  final String pid;
  final String ownerPicUrl;
  final String username;
  final String ownerUid;
  // final String isCollect;

  //controller
  final commentCtr = TextEditingController();
  final updateCommentCtr = TextEditingController();
  final additionCommentCtr = TextEditingController();
  final updateAdditionCommentCtr = TextEditingController();
  final updateTitleCtr = TextEditingController();
  final updateContentCtr = TextEditingController();
  // final viewPostController = Get.put(ViewPostController());
  var uid = Hive.box("UidAndState").get('uid');

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final viewPostController = Get.put(ViewPostController(pid: pid));

    Future<bool> onLikeButtonTapped(bool isLiked) async {
      viewPostController.updateLikes(pid, uid);

      return !isLiked;
    }

    return SafeArea(
        child: GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        viewPostController.commentType.value = true;
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () async {
                Get.back(result: viewPostController.needRefresh);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(ownerPicUrl),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(username),
                )
              ],
            ),
            actions: [
              viewPostController.uid == ownerUid
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
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
                                                backgroundColor: Theme.of(
                                                        context)
                                                    .scaffoldBackgroundColor,
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

                                                Get.back();
                                                Get.back(
                                                    result: viewPostController
                                                        .needRefresh);
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
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[350]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[100],
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
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
                          alignment: WrapAlignment.center,
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
                                    ? Icon(
                                        Icons.bookmark_outlined,
                                        color:
                                            ThemeData.dark().primaryColorLight,
                                      )
                                    : Icon(Icons.bookmark_border_rounded);
                              },
                              padding: EdgeInsets.all(8),
                              mainAxisAlignment: MainAxisAlignment.start,
                              isLiked:
                                  viewPostController.buttonIsCollected.value,
                              size: 25,
                              onTap: (isLiked) => viewPostController
                                  .onCollectButtonTapped(isLiked),
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
                          collapsed: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              viewPostController
                                  .currViewPostDetial.value.content,
                              style: TextTheme().titleMedium,
                              maxLines: 3,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
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
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                viewPostController
                                                    .currViewPostDetial
                                                    .value
                                                    .comments[index]
                                                    .pic),
                                          ),
                                          title: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                viewPostController
                                                    .currViewPostDetial
                                                    .value
                                                    .comments[index]
                                                    .username,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0),
                                                child: Text(
                                                  viewPostController
                                                      .currViewPostDetial
                                                      .value
                                                      .comments[index]
                                                      .text,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // style: TextStyle(
                                                  //     // fontSize: 15,
                                                  //     color: Color.fromARGB(
                                                  //         255, 218, 196, 183)),
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
                                                          .commentType
                                                          .value = false;
                                                      viewPostController
                                                              .tempCid =
                                                          viewPostController
                                                              .currViewPostDetial
                                                              .value
                                                              .comments[index]
                                                              .commentId
                                                              .toString();
                                                      focusNode.requestFocus();
                                                    },
                                                    child: Text('回覆',
                                                        style: TextStyle(
                                                            fontSize: 12))),
                                              ),
                                              viewPostController
                                                              .currViewPostDetial
                                                              .value
                                                              .comments[index]
                                                              .uid ==
                                                          Hive.box(
                                                                  "UidAndState")
                                                              .get('uid') ||
                                                      viewPostController
                                                              .currViewPostDetial
                                                              .value
                                                              .uid ==
                                                          Hive.box(
                                                                  "UidAndState")
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
                                                                    .comments[
                                                                        index]
                                                                    .uid) {
                                                              updateCommentCtr
                                                                      .text =
                                                                  viewPostController
                                                                      .currViewPostDetial
                                                                      .value
                                                                      .comments[
                                                                          index]
                                                                      .text;
                                                              showDialog<
                                                                  String>(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    AlertDialog(
                                                                  title:
                                                                      const Text(
                                                                          '編輯留言'),
                                                                  actions: <
                                                                      Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            '編輯');
                                                                        showDialog<
                                                                            String>(
                                                                          context:
                                                                              context,
                                                                          builder: (BuildContext context) =>
                                                                              AlertDialog(
                                                                            title:
                                                                                const Text('修改留言'),
                                                                            content:
                                                                                TextField(
                                                                              controller: updateCommentCtr,
                                                                              maxLines: 1,
                                                                              maxLength: 30,
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                hintText: '修改留言...',
                                                                              ),
                                                                            ),
                                                                            actions: <Widget>[
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  if (updateCommentCtr.text != '') {
                                                                                    viewPostController.updateComment(viewPostController.currViewPostDetial.value.comments[index].commentId.toString(), updateCommentCtr.text);
                                                                                    updateCommentCtr.clear();
                                                                                  } else {
                                                                                    viewPostController.deleteComment(viewPostController.currViewPostDetial.value.comments[index].commentId);
                                                                                    Fluttertoast.showToast(msg: "已刪除留言", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.blue, textColor: Colors.white, fontSize: 16.0);
                                                                                  }
                                                                                  Navigator.pop(context, '確認');
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
                                                                      child: const Text(
                                                                          '編輯'),
                                                                    ),
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
                                                                  ],
                                                                ),
                                                              );
                                                            } else if (viewPostController
                                                                    .currViewPostDetial
                                                                    .value
                                                                    .uid ==
                                                                Hive.box(
                                                                        "UidAndState")
                                                                    .get(
                                                                        'uid')) {
                                                              showDialog<
                                                                      String>(
                                                                  context:
                                                                      context,
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      AlertDialog(
                                                                          title: const Text(
                                                                              '刪除留言'),
                                                                          actions: <
                                                                              Widget>[
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                viewPostController.deleteComment(viewPostController.currViewPostDetial.value.comments[index].commentId);
                                                                                Navigator.pop(context, '刪除');
                                                                              },
                                                                              child: const Text('刪除'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context, '取消');
                                                                              },
                                                                              child: const Text('取消'),
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
                                        ),
                                        viewPostController
                                                    .currViewPostDetial
                                                    .value
                                                    .comments[index]
                                                    .repliesComments !=
                                                []
                                            ? ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                itemCount: viewPostController
                                                    .currViewPostDetial
                                                    .value
                                                    .comments[index]
                                                    .repliesComments
                                                    .length,
                                                itemBuilder: ((context, i) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25.0),
                                                    child: ListTile(
                                                      leading: CircleAvatar(
                                                        backgroundImage: NetworkImage(
                                                            viewPostController
                                                                .currViewPostDetial
                                                                .value
                                                                .comments[index]
                                                                .repliesComments[
                                                                    i]
                                                                .pic),
                                                      ),
                                                      title: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            viewPostController
                                                                .currViewPostDetial
                                                                .value
                                                                .comments[index]
                                                                .repliesComments[
                                                                    i]
                                                                .username,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0),
                                                            child: Text(
                                                              viewPostController
                                                                  .currViewPostDetial
                                                                  .value
                                                                  .comments[
                                                                      index]
                                                                  .repliesComments[
                                                                      i]
                                                                  .text,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              // style: TextStyle(
                                                              //     // fontSize: 15,
                                                              //     color: Color
                                                              //         .fromARGB(
                                                              //             255,
                                                              //             218,
                                                              //             196,
                                                              //             183)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      subtitle: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: viewPostController
                                                                        .currViewPostDetial
                                                                        .value
                                                                        .comments[
                                                                            index]
                                                                        .uid ==
                                                                    Hive.box(
                                                                            "UidAndState")
                                                                        .get(
                                                                            'uid') ||
                                                                viewPostController
                                                                        .currViewPostDetial
                                                                        .value
                                                                        .uid ==
                                                                    Hive.box(
                                                                            "UidAndState")
                                                                        .get(
                                                                            'uid')
                                                            ? SizedBox(
                                                                height: 40,
                                                                width: 45,
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          var uid =
                                                                              Hive.box("UidAndState").get('uid');
                                                                          if (uid ==
                                                                              viewPostController.currViewPostDetial.value.comments[index].uid) {
                                                                            updateAdditionCommentCtr.text =
                                                                                viewPostController.currViewPostDetial.value.comments[index].repliesComments[i].text;
                                                                            showDialog<String>(
                                                                              context: context,
                                                                              builder: (BuildContext context) => AlertDialog(
                                                                                title: const Text('編輯留言'),
                                                                                actions: <Widget>[
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context, '編輯');
                                                                                      showDialog<String>(
                                                                                        context: context,
                                                                                        builder: (BuildContext context) => AlertDialog(
                                                                                          title: const Text('修改留言'),
                                                                                          content: TextField(
                                                                                            controller: updateAdditionCommentCtr,
                                                                                            maxLines: 1,
                                                                                            maxLength: 30,
                                                                                            decoration: InputDecoration(
                                                                                              border: InputBorder.none,
                                                                                              hintText: '修改留言...',
                                                                                            ),
                                                                                          ),
                                                                                          actions: <Widget>[
                                                                                            TextButton(
                                                                                              onPressed: () {
                                                                                                if (updateAdditionCommentCtr.text != '') {
                                                                                                  viewPostController.updateAdditionComment(viewPostController.currViewPostDetial.value.comments[index].repliesComments[i].rid.toString(), updateAdditionCommentCtr.text);
                                                                                                  updateAdditionCommentCtr.clear();
                                                                                                } else {
                                                                                                  Fluttertoast.showToast(msg: "已刪除留言", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.blue, textColor: Colors.white, fontSize: 16.0);
                                                                                                }
                                                                                                Navigator.pop(context, '確認');
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
                                                                                    child: const Text('編輯'),
                                                                                  ),
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      viewPostController.deleteAdditionComment(viewPostController.currViewPostDetial.value.comments[index].repliesComments[i].rid);
                                                                                      Navigator.pop(context, '刪除');
                                                                                    },
                                                                                    child: const Text('刪除'),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          } else if (viewPostController.currViewPostDetial.value.uid ==
                                                                              Hive.box("UidAndState").get('uid')) {
                                                                            showDialog<String>(
                                                                                context: context,
                                                                                builder: (BuildContext context) => AlertDialog(title: const Text('刪除留言'), actions: <Widget>[
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context, '刪除');
                                                                                        },
                                                                                        child: const Text('刪除'),
                                                                                      ),
                                                                                      TextButton(
                                                                                        onPressed: () {
                                                                                          Navigator.pop(context, '取消');
                                                                                        },
                                                                                        child: const Text('取消'),
                                                                                      ),
                                                                                    ]));
                                                                          }
                                                                        },
                                                                        child:
                                                                            Text(
                                                                          '編輯',
                                                                          style:
                                                                              TextStyle(fontSize: 12),
                                                                        )),
                                                              )
                                                            : Container(),
                                                      ),
                                                    ),
                                                  );
                                                }))
                                            : Container()
                                      ],
                                    )),
                              );
                            })),
                      ),
                    ),
                ],
              ))),
        bottomSheet: Obx(
          () => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextField(
                controller: viewPostController.commentType.value == true
                    ? commentCtr
                    : additionCommentCtr,
                maxLines: 1,
                maxLength: 30,
                focusNode: focusNode,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      if (viewPostController.commentType.value == true) {
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
                      } else {
                        if (additionCommentCtr.text != '') {
                          viewPostController.postAdditionComment(
                              additionCommentCtr.text,
                              viewPostController.tempCid);
                          additionCommentCtr.clear();
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
                      }
                    },
                  ),
                  border: InputBorder.none,
                  hintText: viewPostController.commentType.value == true
                      ? '發表言論...'
                      : '正在回覆...',
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

class _viewPostPic extends StatelessWidget {
  const _viewPostPic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewPostController viewPostController = Get.find<ViewPostController>();
    return SafeArea(
      child: Material(
          child: InkWell(
              onTap: () => {Get.back()},
              child: PageView.builder(
                  itemCount: viewPostController
                      .currViewPostDetial.value.postFiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          viewPostController.currViewPostDetial.value
                              .postFiles[index].postUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[100],
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }))),
    );
  }
}
