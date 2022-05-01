import 'package:cozydiary/pages/Personal/userHeaderWidget.dart';
import 'package:flutter/material.dart';
import 'Edit_Personal.dart';
import 'widget/PageTranslationAnimation.dart';

class EditPersoalImformationButton extends StatelessWidget {
  const EditPersoalImformationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).push(CustomerPageRoute(
          child: Edit_PerssonalPage(
        Header: UserHeader(0, 0, 20, 5),
      ))),
      child: const Text(
        '編輯個人資料',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(82, 206, 205, 205)),
    );
  }
}
