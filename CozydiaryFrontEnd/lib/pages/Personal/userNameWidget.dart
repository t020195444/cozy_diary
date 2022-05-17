import 'package:flutter/material.dart';

import '../../Data/dataResourse.dart';

String name = PersonalValue_Map["UserName"]!;

class UserName extends StatelessWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
          fontSize: 30,
          color: Color.fromARGB(255, 0, 0, 0),
          fontWeight: FontWeight.bold),
    );
  }
}
