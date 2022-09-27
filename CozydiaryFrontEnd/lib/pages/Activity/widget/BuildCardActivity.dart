import 'dart:io';

import 'package:cozydiary/Model/ActivityPostCoverModel.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../screen_widget/viewPostScreen.dart';

class BuildCardActivity extends StatelessWidget {
  final List<Activity> PostCovers;
  final int index;
  const BuildCardActivity(
      {Key? key, required this.PostCovers, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          ViewPostScreen(),
          transition: Transition.fadeIn,
        );
      },
      child: Hero(
        tag: PostCovers[index].cover,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                PostCovers[index].cover,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
                child: Text(PostCovers[index].activityName,
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
                            child: CircleAvatar(
                              radius: 12,
                              backgroundImage:
                                  NetworkImage(PostCovers[index].pic),
                            ),
                          ),
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
