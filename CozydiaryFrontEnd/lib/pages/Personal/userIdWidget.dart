import 'package:flutter/material.dart';

import '../../Data/dataResourse.dart';

class UserId extends StatelessWidget {
  const UserId({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "UID:" + PersonalValue_Map["UID"]!,
      style: TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }
}
