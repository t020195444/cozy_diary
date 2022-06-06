import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class SelectLike extends StatelessWidget {
  const SelectLike({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("選擇你感興趣的內容"),
          SelectLike(),
        ],
      ),
    );
  }
}
