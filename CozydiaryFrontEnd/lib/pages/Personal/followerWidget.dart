import 'package:flutter/material.dart';

import '../../Data/dataResourse.dart';

class follower_Widget extends StatefulWidget {
  const follower_Widget({Key? key}) : super(key: key);

  @override
  State<follower_Widget> createState() => _follower_WidgetState();
}

class _follower_WidgetState extends State<follower_Widget> {
  String followingCount = PersonalValue_Map["followeingCount"]!;
  String followerCount = PersonalValue_Map["followerCount"]!;
  String postCount = PersonalValue_Map["postCount"]!;
  String launchCount = PersonalValue_Map["launchCount"]!;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      followingCount = PersonalValue_Map["followeingCount"]!;
      followerCount = PersonalValue_Map["followerCount"]!;
      postCount = PersonalValue_Map["postCount"]!;
      launchCount = PersonalValue_Map["launchCount"]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(children: <Widget>[
            Text(
              '$followingCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '追隨中',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$followerCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '粉絲',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$postCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '筆記',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
          Column(children: <Widget>[
            Text(
              '$launchCount',
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const Text(
              '聚集數',
              style:
                  TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ]),
        ],
      ),
    );
  }
}
