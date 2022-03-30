import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cozydiary/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebasePage extends StatefulWidget {
  const FirebasePage({Key? key, username}) : super(key: key);

  @override
  State<FirebasePage> createState() => _FirebasePageState();
}

class _FirebasePageState extends State<FirebasePage> {
  final DatabaseReference fireBaseDB = FirebaseDatabase.instance.ref();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  late final String username;

  void _set() {
    Map<String, String> data = {
      "userName": userName,
      "userSubject": userSubject
    };

    fireBaseDB.child("user").child(userId).set(data).whenComplete(() {
      print("finish set");
    }).catchError((error) {
      print(error);
    });
  }

  String userName = "us";
  String userSubject = "亞太系";
  String userId = "1122334455";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("CRUD DEMO"),
          backgroundColor: Colors.redAccent,
        ),
        body: new Container(
          padding: EdgeInsets.all(50),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new ElevatedButton(
                child: new Text("SET"),
                onPressed: () {
                  _set();
                },
                style: ElevatedButton.styleFrom(primary: Colors.orange),
              ),
              new ElevatedButton(
                child: new Text("PUSH"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.teal),
              ),
              new ElevatedButton(
                  child: new Text("UPDATE"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(primary: Colors.amber)),
              new ElevatedButton(
                child: new Text("DELETE"),
                onPressed: () {},
                style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
              ),
              new ElevatedButton(
                  child: new Text("Fetch"),
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(primary: Colors.indigoAccent)),
              new Text("userName: ${userName} userSubject: ${userSubject}",
                  style:
                      new TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
            ],
          ),
        ));
  }
}
