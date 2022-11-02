import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
part 'UidAndState.g.dart';

//Local
@HiveType(typeId: 0)
class UidAndState {
  //儲存使用者uid
  @HiveField(0)
  final String uid;
  //目前未用到，還在尋找刪除的方式
  @HiveField(1, defaultValue: false)
  final bool isLogin;

  UidAndState({required this.uid, required this.isLogin});
}
