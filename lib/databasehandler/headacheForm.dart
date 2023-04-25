// For Directory
import 'dart:io';
import 'package:fluttertest/databasehandler/databaseconnect.dart';
import 'package:sqflite/sqflite.dart';

// For join()
import 'package:path/path.dart';
// For getApplicationDocumentsDirectory()
import 'package:path_provider/path_provider.dart';

class HeadacheFormInput {
// Primary key:
  final int? headacheEntryid;
  final String? userid; //userid;  Foreign key
  final int TS;             // Seconds since epoch of DateTime.now();

  // Other fields:
  final int dateInSecondsSinceEpoch;
  final int TODMinSinceMidnight;
  final int intensityLevel;

  final String? medicineName;

  // If both Partial & Full == 0 it means that part of the form is not filled in
  final int Partial;
  final int Full;

  final int medicineDateMS;
  final int TODMEDMinSinceMidnight;

  HeadacheFormInput({this.headacheEntryid, this.userid, required this.TS, required this.dateInSecondsSinceEpoch, required this.TODMinSinceMidnight, required this.intensityLevel, required this.medicineName, required this.Partial, required this.Full, required this.medicineDateMS, required this.TODMEDMinSinceMidnight});

  factory HeadacheFormInput.fromMap(Map<String, dynamic> json) => HeadacheFormInput(
    headacheEntryid: json['headacheEntryid'],
    userid: json['userid'],
    TS: json['TS'],

    dateInSecondsSinceEpoch: json['dateInSecondsSinceEpoch'],
    TODMinSinceMidnight: json['TODMinSinceMidnight'],
    intensityLevel: json['intensityLevel'],
    medicineName: json['medicineName'],
    Partial: json['Partial'],
    Full: json['Full'],
    medicineDateMS: json['medicineDateMS'],
    TODMEDMinSinceMidnight: json['TODMEDMinSinceMidnight'],
  );

  Map<String,dynamic> toMap(){
    return{
      'headacheEntryid': headacheEntryid,
      'userid':userid,
      'TS':TS,
      'dateInSecondsSinceEpoch':dateInSecondsSinceEpoch,
      'TODMinSinceMidnight':TODMinSinceMidnight,
      'intensityLevel':intensityLevel,
      'medicineName':medicineName,
      'Partial':Partial,
      'Full':Full,
      'medicineDateMS':medicineDateMS,
      'TODMEDMinSinceMidnight': TODMEDMinSinceMidnight,
    };
  }
}

class HeadacheFormDBHelper{
  HeadacheFormDBHelper._privateConstructor();
  static final HeadacheFormDBHelper instance = HeadacheFormDBHelper._privateConstructor();

  static Database? _DailyFormDB;
  // Init DB if _DailyFormDB is null
  Future<Database> get database async => _DailyFormDB ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'headacheForm.db');

    return await openDatabase(
      path,
      version:1,
      onCreate: _onCreate,
    );
  }
  // Create Table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''
        CREATE TABLE HeadacheForm(
          headacheEntryid INTEGER PRIMARY KEY AUTOINCREMENT,
          userid TEXT NOT NULL,     
          TS INT NOT NULL,  
          dateInSecondsSinceEpoch INT,
          TODMinSinceMidnight INT,
          intensityLevel INT,
          medicineName TEXT,
          Partial INTEGER,
          Full INTEGER,
          medicineDateMS INT,
          TODMEDMinSinceMidnight INT,
          UNIQUE(userid, TS)
        )
      '''
    );

    // FOREIGN KEY (userid) REFERENCES User(id)
  }


  Future dropTable(Database db, int version) async {
    await db.execute(
        '''
      Drop TABLE HeadacheForm
      '''
    );
  }

  fetchTableData() async{
    Database db = await instance.database;
    final result = await db.query('HeadacheForm');

    // print(result);
    return result;
  }

  Future<List<Map<String, dynamic>>> getAllUserEntries(String userId) async {
    Database db = await instance.database;
    var result = await db.query(
      'HeadacheForm',
      where: 'userid = ?',
      whereArgs: [userId],
    );

    // print(result);
    return result;
  }


  Future<Map<String, dynamic>?> fetchLatestHeadacheFormByUserId(String userId) async {
    final Database db = await instance.database;
    var result =  await db.query(
      'HeadacheForm',
      where: 'userid = ?',
      whereArgs: [userId],
      orderBy: 'TS DESC',
      limit: 1,
    );

    if (result.isNotEmpty) {
      // print(result.first);
      return result.first;
    }

    return null;
  }

  Future<int> add(HeadacheFormInput headacheFormInput) async{
    Database db = await instance.database;

    return await db.insert('HeadacheForm',headacheFormInput.toMap());
  }

}