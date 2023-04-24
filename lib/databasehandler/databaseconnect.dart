import 'package:fluttertest/userdata/userfile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class databaseconnect {
  late Database db;

  static const String DB_Name = 'headache.db';
  static const String Table_Userinfo = 'userinfo';
  static const int Version = 1;

  static const String C_UserId = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_Email = 'email';
  static const String C_Password = 'password';
  static const String C_UserGender = 'user_gender';

  Future<Database> get async async {
    if (db != null) {
      return db;
    }
    db = await initDb();
    return db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_Userinfo("
        " $C_UserId TEXT, "
        " $C_UserName TEXT, "
        " $C_Email TEXT,"
        " $C_Password TEXT, "
        " $C_UserGender TEXT, "
        " PRIMARY KEY ($C_UserId)"
        ")");
  }

  Future<userfile> saveData(userfile user) async {
    var dbClient = await db;
    user.user_id = (await dbClient.insert(Table_Userinfo, user.toMap())) as String;
    return user;
  }

  Future<userfile?> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_Userinfo WHERE "
        "$C_UserId = '$userId' AND " "$C_Password = '$password'");

    if (res.length > 0) {
      return userfile.fromMap(res.first);
    }
    return null;
  }

  Future<int> updateUser(userfile user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_Userinfo, user.toMap(),
        where: '$C_UserId = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_Userinfo, where: '$C_UserId = ?', whereArgs: [user_id]);
    return res;
  }
}