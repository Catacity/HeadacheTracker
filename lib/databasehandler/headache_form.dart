import 'package:flutter/material.dart';
import 'dart:io';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

_onConfigure(Database db) async {
  // Add support for foreign key constrain
  await db.execute("PRAGMA foreign_keys = ON");
}
Future<Database> db = openDatabase( _onConfigure(db as Database));

class symptom{

}
class medicine{

}
