import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../Data/dataResourse.dart';

class BuildCard extends StatelessWidget {
  final int index;
  const BuildCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            Image_List[index],
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              PostText_List[index],
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
                          backgroundImage: NetworkImage(Image_List[3]),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '許悅',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                  LikeButton(
                    likeCount: 0,
                    isLiked: false,
                    size: 15,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
