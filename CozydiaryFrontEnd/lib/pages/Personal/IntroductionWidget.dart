import 'package:flutter/material.dart';

class IntroductionWidget extends StatelessWidget {
  const IntroductionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text(
        '簡介',
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 10),
    );
  }
}
