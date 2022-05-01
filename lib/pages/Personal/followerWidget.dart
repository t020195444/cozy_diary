import 'package:flutter/material.dart';

import '../../Data/dataResourse.dart';

class follower_Widget extends StatefulWidget {
  const follower_Widget({Key? key}) : super(key: key);

  @override
  State<follower_Widget> createState() => _follower_WidgetState();
}

class _follower_WidgetState extends State<follower_Widget> {
  int followingCount = PersonalValue_List[0].value;
  int followerCount = PersonalValue_List[1].value;
  int postCount = PersonalValue_List[2].value;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      followingCount = PersonalValue_List[0].value;
      followerCount = PersonalValue_List[1].value;
      postCount = PersonalValue_List[2].value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      margin: EdgeInsets.fromLTRB(20, 5, 0, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: <Widget>[
            Text(
              '$followingCount',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const Text(
              '追隨中',
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$followerCount',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const Text(
              '粉絲',
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$postCount',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const Text(
              '筆記',
              style: TextStyle(fontSize: 13, color: Colors.white),
            ),
          ]),
        ],
      ),
    );
  }
}
