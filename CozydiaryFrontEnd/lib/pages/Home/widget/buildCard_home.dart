import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../../Data/dataResourse.dart';

class BuildCardHome extends StatelessWidget {
  final int index;
  const BuildCardHome({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(40, 255, 255, 255),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(
            HomePageImage_List[index],
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(PostText_List[index],
                softWrap: true,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white70,
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
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
