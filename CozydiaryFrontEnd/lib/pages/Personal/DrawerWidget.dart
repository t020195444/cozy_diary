import 'package:cozydiary/pages/Personal/Self/Page/userManagementPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {Key? key,
      required this.userImageUrl,
      required this.userName,
      required this.uid})
      : super(key: key);
  final String userImageUrl;
  final String userName;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 215,
            child: UserAccountsDrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
              accountName: Text(
                userName,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              accountEmail: Text(
                "UID：$uid",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              currentAccountPictureSize: const Size.square(110),
              currentAccountPicture: Container(
                margin: EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(userImageUrl), fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                          // color: Colors.black,
                          offset: Offset(0, 2),
                          blurRadius: 5,
                          spreadRadius: 0)
                    ]),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.manage_accounts,
            ),
            title: Text(
              '管理帳戶',
              style: TextStyle(),
            ),
            onTap: () {
              Get.bottomSheet(
                UserManagemenetPage(),
              );
            },
          ),
          const ListTile(
            leading: Icon(
              Icons.group_outlined,
            ),
            title: Text(
              '查看聚會',
              style: TextStyle(),
            ),
          ),
        ],
      )),
    );
  }
}
