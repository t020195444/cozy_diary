import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'UidAndState.g.dart';

@HiveType(typeId: 0)
class UidAndState {
  @HiveField(0)
  final String uid;

  @HiveField(1, defaultValue: false)
  final bool isLogin;

  UidAndState({required this.uid, required this.isLogin});
}
