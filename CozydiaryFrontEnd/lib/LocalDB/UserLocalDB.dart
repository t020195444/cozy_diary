import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  final String uid;
  final bool isLogin;
  final int isCompleted;
  User({required this.uid, required this.isLogin, required this.isCompleted});
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'isLogin': isLogin,
      'isCompleted': isCompleted,
    };
  }
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
      join(await getDatabasesPath(), 'user.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, isCompleted INTEGER)",
        );
      },
      version: 1,
    );
    return database!;
  }

  static Future<List<User>> getUser() async {
    final Database db = await getDBConnect();
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        uid: maps[i]['uid'],
        isLogin: maps[i]['isLogin'],
        isCompleted: maps[i]['isCompleted'],
      );
    });
  }

  static Future<void> addTodo(User user) async {
    final Database db = await getDBConnect();
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
