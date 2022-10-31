import 'package:cozydiary/Model/postCoverModel.dart';
import 'package:cozydiary/screen_widget/viewPostScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

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
          ViewPostScreen(),
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
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Text(
                userPostCover[index].title,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 8),
              child: LikeButton(
                mainAxisAlignment: MainAxisAlignment.end,
                likeCount: userPostCover[index].likes,
                isLiked: false,
                size: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
