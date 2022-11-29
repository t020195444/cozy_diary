import 'package:cozydiary/Model/ActivityPostCoverModel.dart';
import 'package:cozydiary/pages/Activity/Screen/ActivityViewPostScreen.dart';
import 'package:cozydiary/pages/Activity/service/ActivityPostService.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildCardActivity extends StatelessWidget {
  final List<Activity> PostCovers;
  final int index;
  const BuildCardActivity(
      {Key? key, required this.PostCovers, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await ActivityPostService.getActivityDetail(
            key.toString().replaceAll(RegExp(r"[^\s\w]"), ""));
        Get.to(
          ActivityViewPostScreen(
              id: key.toString().replaceAll(RegExp(r"[^\s\w]"), "")),
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
              Center(
                child: Image.network(
                  PostCovers[index].cover,
                  fit: BoxFit.cover,
                ),
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
                padding: EdgeInsets.fromLTRB(15, 15, 15, 8),
                child: Text(
                    PostCovers[index].activityTime[0].toString() +
                        "年" +
                        PostCovers[index].activityTime[1].toString() +
                        "月" +
                        PostCovers[index].activityTime[2].toString() +
                        "日" +
                        PostCovers[index].activityTime[3].toString() +
                        "時" +
                        PostCovers[index].activityTime[4].toString() +
                        "分",
                    softWrap: true,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.whatshot,
                            color: Color.fromARGB(255, 255, 128, 128),
                          ),
                          Text(PostCovers[index].likes.toString())
                        ],
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
