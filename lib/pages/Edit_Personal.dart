import 'package:flutter/material.dart';

class Edit_PerssonalPage extends StatelessWidget {
  final Widget Header;
  const Edit_PerssonalPage({Key? key, required this.Header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('編輯個人資料'),
      ),
      body: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, index) {
            return Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      child: Header,
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text(
                      "點擊更換頭貼",
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[Text("")],
                    ))
              ],
            );
          }),
    );
  }
}
