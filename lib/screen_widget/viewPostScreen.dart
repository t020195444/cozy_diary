import 'package:flutter/material.dart';

class ViewPostScreen extends StatefulWidget {
  @override
  _ViewPostScreenState createState() => _ViewPostScreenState();
}

class _ViewPostScreenState extends State<ViewPostScreen> {
  Widget _buildComment(int index) {
    // debugPaintSizeEnabled = true;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: CircleAvatar(
            child: ClipOval(
              child: Image(
                height: 50.0,
                width: 50.0,
                image: AssetImage('assets/images/user1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        title: Text(
          'test123',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('test456'),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite_border,
          ),
          color: Colors.grey,
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDF0F6),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40.0),
              width: double.infinity,
              height: 600.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: Column(
                      children: <Widget>[
                        Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.arrow_back),
                                iconSize: 30.0,
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.pop(context);
                                }, //=> Navigator.pop(context),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.87,
                                child: ListTile(
                                  leading: Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 10, 4),
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  'assets/images/user1.jpg'))),
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          print('this is user avatar');
                                        },
                                        elevation: 2.0,
                                        fillColor:
                                            Color.fromARGB(0, 255, 255, 255),
                                        shape: CircleBorder(),
                                      )),
                                  // Container(
                                  //   width: 50.0,
                                  //   height: 50.0,
                                  //   decoration: BoxDecoration(
                                  //     shape: BoxShape.circle,
                                  //     boxShadow: [
                                  //       BoxShadow(
                                  //         color: Colors.black45,
                                  //         offset: Offset(0, 2),
                                  //         blurRadius: 6.0,
                                  //       ),
                                  //     ],
                                  //   ),
                                  //   child: CircleAvatar(
                                  //     child: ClipOval(
                                  //       child: Image(
                                  //         height: 50.0,
                                  //         width: 50.0,
                                  //         image: AssetImage(
                                  //             'assets/images/pic1.jpg'),
                                  //         fit: BoxFit.cover,

                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  title: Text(
                                    'test789',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text('test234'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    color: Colors.black,
                                    onPressed: () => print('More'),
                                  ),
                                ),
                              ),
                            ]),
                        InkWell(
                          onDoubleTap: () => print('Like post'),
                          child: Container(
                            margin: EdgeInsets.all(10.0),
                            width: double.infinity,
                            height: 350.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black45,
                              //     offset: Offset(0, 5),
                              //     blurRadius: 8.0,
                              //   ),
                              // ],
                              image: DecorationImage(
                                image: AssetImage('assets/images/pic1.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.favorite_border),
                                        iconSize: 30.0,
                                        onPressed: () => print('Like post'),
                                      ),
                                      Text(
                                        '2,515',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20.0),
                                  Row(
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.chat),
                                        iconSize: 30.0,
                                        onPressed: () {
                                          print('Chat');
                                        },
                                      ),
                                      Text(
                                        '350',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: Icon(Icons.bookmark_border),
                                iconSize: 30.0,
                                onPressed: () => print('Save post'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              height: 600.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  _buildComment(0),
                  _buildComment(1),
                  _buildComment(2),
                  _buildComment(3),
                  _buildComment(4),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 6.0,
              ),
            ],
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                contentPadding: EdgeInsets.all(20.0),
                hintText: 'Add a comment',
                prefixIcon: Container(
                  margin: EdgeInsets.all(4.0),
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image(
                        height: 48.0,
                        width: 48.0,
                        image: AssetImage('assets/images/user1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 4.0),
                  width: 70.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(0xFF23B66F),
                    onPressed: () => print('Post comment'),
                    child: Icon(
                      Icons.send,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
