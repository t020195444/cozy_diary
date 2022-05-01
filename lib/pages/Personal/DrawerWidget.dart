import 'package:flutter/material.dart';

import '../../Data/dataResourse.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        Container(
          height: 100,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black26,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(Image_List[3]),
                  ),
                ),
                Text(
                  '許悅',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                )
              ],
            ),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.manage_accounts,
            color: Colors.white,
          ),
          title: Text(
            '管理帳戶',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        const ListTile(
          leading: Icon(
            Icons.group_outlined,
            color: Colors.white,
          ),
          title: Text(
            '查看聚會',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    ));
  }
}
