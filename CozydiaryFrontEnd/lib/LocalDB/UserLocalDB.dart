import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final String id;
  final String isLogin;
  final int isCompleted;
  User({required this.id, required this.isLogin, required this.isCompleted});
}

class UserDB {
  static Database? database;

  static Future<Database> getDBConnect() async {
    if (database == null) {
      return await initDatabase();
    }
    return database!;
  }

  static Future<Database> initDatabase() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE todos(id TEXT PRIMARY KEY, name TEXT, isCompleted INTEGER)",
        );
      },
      version: 1,
    );
    return database!;
  }
}
