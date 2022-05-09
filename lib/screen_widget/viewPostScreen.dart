import 'package:cozydiary/Data/dataResourse.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import 'package:flutter/rendering.dart';

class ViewPostScreen extends StatefulWidget {
  final String imageUrl;
  const ViewPostScreen({Key? key, required this.imageUrl}) : super(key: key);
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
            image: DecorationImage(
                fit: BoxFit.fill, image: NetworkImage(Image_List[3])),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                offset: Offset(0, 2),
                blurRadius: 6.0,
              ),
            ],
          ),
        ),
        title: Text(
          'test123',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text('test456'),
        trailing: Container(
          child: LikeButton(),
          width: 35,
          height: 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 40.0),
              width: double.infinity,
              height: 600.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 49, 46, 46),
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
                                },
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.87,
                                child: ListTile(
                                  leading: Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 10, 4),
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image:
                                                  NetworkImage(Image_List[3]))),
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          print('this is user avatar');
                                        },
                                        elevation: 2.0,
                                        fillColor:
                                            Color.fromARGB(0, 255, 255, 255),
                                        shape: CircleBorder(),
                                      )),
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
                          child: Hero(
                              tag: widget.imageUrl,
                              child: Image.network(widget.imageUrl)
                              // Container(
                              //   margin: EdgeInsets.all(10.0),
                              //   width: double.infinity,
                              //   height: 350.0,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(25.0),
                              //     image: DecorationImage(
                              //       image: NetworkImage(widget.imageUrl),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
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
                                      LikeButton(
                                        likeCount: 2515,
                                        isLiked: false,
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
                color: Color.fromARGB(255, 49, 46, 46),
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
                // topLeft: Radius.circular(30.0),
                // topRight: Radius.circular(30.0),
                ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -2),
                blurRadius: 6.0,
              ),
            ],
            color: Color.fromARGB(255, 49, 46, 46),
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
                    image: DecorationImage(
                        image: NetworkImage(Image_List[3]), fit: BoxFit.fill),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 4.0),
                  width: 70.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
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
