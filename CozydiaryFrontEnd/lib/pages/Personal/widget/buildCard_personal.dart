import 'package:cozydiary/Model/PostCoverModel.dart';
import 'package:cozydiary/screen_widget/viewPostScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:page_transition/page_transition.dart';

class BuildCard extends StatelessWidget {
  final int index;
  final List<PostCoverData> userPostCover;
  const BuildCard({Key? key, required this.index, required this.userPostCover})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          ViewPostScreen(imageUrl: userPostCover[index].cover),
          transition: Transition.fadeIn,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: userPostCover[index].cover,
              child: Image.network(
                userPostCover[index].cover,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                userPostCover[index].title,
                softWrap: true,
                maxLines: 2,
              ),
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
                                NetworkImage(userPostCover[index].pic),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              userPostCover[index].username,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    LikeButton(
                      likeCount: userPostCover[index].likes,
                      isLiked: false,
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
