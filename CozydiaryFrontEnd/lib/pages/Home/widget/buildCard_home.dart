import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/pages/Personal/OtherPerson/Controller/OtherPersonController.dart';
import 'package:cozydiary/postJsonService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import '../../../screen_widget/viewPostScreen.dart';
import '../../Personal/OtherPerson/Page/otherPersonPage.dart';
import 'package:cached_network_image/cached_network_image.dart';

class BuildCardHome extends StatelessWidget {
  final List<PostCoverData> PostCovers;
  final int index;
  const BuildCardHome({Key? key, required this.PostCovers, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await PostService.getPostDetail(
            key.toString().split(",")[1].replaceAll(RegExp(r"[^\s\w]"), ""));
        Get.to(
          ViewPostScreen(),
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
                imageUrl: PostCovers[index].cover,
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
                child: Text(PostCovers[index].title,
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
                                      NetworkImage(PostCovers[index].pic),
                                ),
                                onTap: () {
                                  OtherPersonPageController
                                      otherPersonPageController =
                                      Get.put(OtherPersonPageController());
                                  otherPersonPageController.otherUid = key
                                      .toString()
                                      .split(",")[0]
                                      .replaceAll(RegExp(r"[^\s\w]"), "");

                                  otherPersonPageController.getOtherUserData();
                                  otherPersonPageController.getUserPostCover();
                                  Get.to(() => OtherPersonalPage());
                                },
                              )),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                PostCovers[index].username,
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
                        likeCount: PostCovers[index].likes,
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
