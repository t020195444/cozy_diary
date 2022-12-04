import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/pages/Home/controller/changePageController.dart';
import 'package:cozydiary/pages/Home/controller/categoryPostController.dart';
import 'package:cozydiary/pages/Personal/OtherPerson/Controller/otherPersonController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';
import 'package:shimmer/shimmer.dart';
import '../../../screen_widget/viewPostScreen.dart';
import '../../Personal/OtherPerson/Page/otherPersonPage.dart';

class BuildCardHome extends StatelessWidget {
  final String uid;
  final List<PostCoverData> postCovers;
  final int index;
  final String pid;
  final String category;
  final String cid;
  BuildCardHome(
      {Key? key,
      required this.postCovers,
      required this.index,
      required this.uid,
      required this.pid,
      required this.category,
      required this.cid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool result = await Get.to(
            () => ViewPostScreen(
                  ownerPicUrl: postCovers[index].pic,
                  ownerUid: postCovers[index].uid,
                  username: postCovers[index].username,
                  pid: postCovers[index].pid.toString(),
                ),
            transition: Transition.cupertino);
        if (result) {
          Get.find<CategoryPostController>(tag: category).getPostCover(cid);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              // constraints: BoxConstraints(maxHeight: 300),
              // height: 100,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(postCovers[index].cover))),
              child: Center(
                child: Image.network(
                  postCovers[index].cover,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[100],
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
              child: Text(postCovers[index].title,
                  softWrap: true,
                  maxLines: 2,
                  style: TextStyle(
                      // color: Colors.black,
                      )),
            ),
            Padding(
                padding: EdgeInsets.all(12).copyWith(top: 0, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: InkWell(
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    NetworkImage(postCovers[index].pic),
                              ),
                              onTap: () {
                                var userUid =
                                    Hive.box("UidAndState").get("uid");
                                print("uid" + uid);
                                print("userUid" + userUid);
                                print(uid != userUid);
                                if (uid != userUid) {
                                  Get.put(
                                      OtherPersonPageController(otherUid: uid));
                                  Get.to(
                                      () => OtherPersonalPage(
                                          key: UniqueKey(), uid: uid),
                                      transition: Transition.fadeIn);
                                } else {
                                  Get.find<ChangePageTabbarController>()
                                      .selectedIndex
                                      .value = 2;
                                }
                                ;
                                // GetBuilder<OtherPersonPageController>(
                                //     init: OtherPersonPageController(
                                //         otherUid: uid),
                                //     builder: (otherPersonPageController) {
                                //       return OtherPersonalPage(
                                //           key: UniqueKey(), uid: uid);
                                //     }));
                              },
                            )),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              postCovers[index].username,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                // color: Colors.black
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    LikeButton(
                      likeCount: postCovers[index].likes,
                      isLiked: true,
                      size: 15,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
