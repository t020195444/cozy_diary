import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/pages/Personal/OtherPerson/Controller/otherPersonController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import '../../../screen_widget/viewPostController.dart';
import '../../../screen_widget/viewPostScreen.dart';
import '../../Personal/OtherPerson/Page/otherPersonPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildCardHome extends StatelessWidget {
  final String uid;
  final List<PostCoverData> postCovers;
  final int index;
  BuildCardHome(
      {Key? key,
      required this.postCovers,
      required this.index,
      required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        ViewPostController.currPostCover = postCovers[index];

        Get.to(
          () => ViewPostScreen(
            pid: postCovers[index].pid.toString(),
          ),
          transition: Transition.fadeIn,
        );
      },
      child: Hero(
        tag: index.toString(),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: postCovers[index].cover,
                fit: BoxFit.cover,
                errorWidget: ((context, url, error) =>
                    Image.asset("assets/images/yunhan.jpg", fit: BoxFit.cover)),
              ),
              // Image.network(
              //   PostCovers[index].cover,
              //   errorBuilder: (context, error, stackTrace) {
              //     return Image.asset("assets/images/yunhan.jpg",
              //         fit: BoxFit.cover);
              //   },
              //   fit: BoxFit.cover,
              // ),
              // FadeInImage(
              //   fadeInDuration: Duration(milliseconds: 100),
              //   image: NetworkImage(PostCovers[index].cover),
              //   placeholder: AssetImage("assets/images/yunhan.jpg"),
              //   imageErrorBuilder: (context, error, stackTrace) {
              //     return Image.asset('asset/images/logo/logoS.png',
              //         fit: BoxFit.fitWidth);
              //   },
              //   fit: BoxFit.fitWidth,
              // ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
                child: Text(postCovers[index].title,
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
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
                                  radius: 12,
                                  backgroundImage:
                                      NetworkImage(postCovers[index].pic),
                                ),
                                onTap: () {
                                  Get.to(() =>
                                      // OtherPersonalPage(
                                      //         key: UniqueKey(), uid: uid)
                                      GetBuilder<OtherPersonPageController>(
                                          init: OtherPersonPageController(
                                              otherUid: uid),
                                          builder: (otherPersonPageController) {
                                            return OtherPersonalPage(
                                                key: UniqueKey(), uid: uid);
                                          }));
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
                                    color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                      LikeButton(
                        likeCount: postCovers[index].likes,
                        isLiked: false,
                        size: 15,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
