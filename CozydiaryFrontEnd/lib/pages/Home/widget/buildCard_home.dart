import 'dart:io';

import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/Model/WritePostModel.dart';
import 'package:cozydiary/pages/Personal/Page/personal_page.dart';
import 'package:cozydiary/pages/Personal/controller/OtherPersonController.dart';
import 'package:cozydiary/pages/Personal/controller/PersonalController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';

import '../../../Data/dataResourse.dart';
import '../../../screen_widget/viewPostScreen.dart';
import '../../Personal/Page/otherPersonPage.dart';

class BuildCardHome extends StatelessWidget {
  final List<PostCoverData> PostCovers;
  final int index;
  const BuildCardHome({Key? key, required this.PostCovers, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtherPersonPageController otherPersonPageController =
        Get.put(OtherPersonPageController());
    return InkWell(
      onTap: () {
        Get.to(
          ViewPostScreen(imageUrl: PostCovers[index].cover),
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
              FadeInImage(
                image: NetworkImage(PostCovers[index].cover),
                placeholder: AssetImage("assets/images/yunhan.jpg"),
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset('asset/images/logo/logoS.png',
                      fit: BoxFit.fitWidth);
                },
                fit: BoxFit.fitWidth,
              ),
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
                                  otherPersonPageController.otherUid =
                                      "116177189475554672826";

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
