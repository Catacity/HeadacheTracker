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
  final int TS_DATE;      // Date for equality comparisons
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

  HeadacheFormInput({this.headacheEntryid, this.userid, required this.TS, required this.TS_DATE, required this.dateInSecondsSinceEpoch, required this.TODMinSinceMidnight, required this.intensityLevel, required this.medicineName, required this.Partial, required this.Full, required this.medicineDateMS, required this.TODMEDMinSinceMidnight});

  factory HeadacheFormInput.fromMap(Map<String, dynamic> json) => HeadacheFormInput(
    headacheEntryid: json['headacheEntryid'],
    userid: json['userid'],
    TS: json['TS'],
    TS_DATE: json['TS_DATE'],
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
      'TS_DATE':TS_DATE,
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

  static Database? _HeadacheDB;
  // Init DB if _DailyFormDB is null
  Future<Database> get database async => _HeadacheDB ??= await _initDatabase();

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
        CREATE TABLE IF NOT EXISTS HeadacheForm(
          headacheEntryid INTEGER PRIMARY KEY AUTOINCREMENT,
          userid TEXT NOT NULL,     
          TS INT NOT NULL, 
          TS_DATE INT NOT NULL, 
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
    final result = await db.query(
      'HeadacheForm',
      orderBy: 'TS DESC'
    );

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

  Future<Map<String, dynamic>?> fetchLatestHeadacheFormByUserIdAndDate(String userId, DateTime date) async {
    // Given userid and date selected, return entry with the latest filled in TS
    final Database db = await instance.database;
    var date_ts = date.millisecondsSinceEpoch;
    int DATE = (date_ts / 1000).round();

    var result = await db.rawQuery(
      '''
      SELECT * FROM HeadacheForm
      WHERE userid = ?
      AND dateInSecondsSinceEpoch = ?
      ORDER BY TS DESC
      LIMIT 1
      ''',
      [userId, DATE],
    );

    if (result.isNotEmpty) {
      // print(result.first);
      return result.first;
    }

    return null;
  }

  Future<List<Map<String, dynamic>>> fetchValidEntriesForUser(String userId) async {
    final db = await database;
    final results = await db.rawQuery(
      '''
        SELECT * FROM HeadacheForm
        WHERE userid = ?
        AND TS IN (
          SELECT MAX(TS)
          FROM HeadacheForm
          WHERE userid = ?
          GROUP BY dateInSecondsSinceEpoch
        )
        ORDER BY TS DESC
      ''',
      [userId, userId]);
    // print(results);
    return results;
  }

  Future<int> add(HeadacheFormInput headacheFormInput) async{
    Database db = await instance.database;

    return await db.insert('HeadacheForm',headacheFormInput.toMap());
  }

}
///////////////////////////////////////////////////////////////////////////////////////////////

// MV ATTRIBUTE:
class HeadacheFormSymptom {
// Primary key:
  final int headacheEntryid; // Foreign key
  final int TS;               // Foreign key
  final String symptom;

  HeadacheFormSymptom({required this.headacheEntryid, required this.TS, required this.symptom});

  factory HeadacheFormSymptom.fromMap(Map<String, dynamic> json) => HeadacheFormSymptom(
    headacheEntryid: json['headacheEntryid'],
    TS: json['TS'],
    symptom: json['symptom'],
  );

  Map<String,dynamic> toMap(){
    return{
      'headacheEntryid': headacheEntryid,
      'TS':TS,
      'symptom':symptom,
    };
  }
}

class SymptomDBHelper{
  SymptomDBHelper._privateConstructor();
  static final SymptomDBHelper instance = SymptomDBHelper._privateConstructor();

  static Database? _SymptomDB;
  // Init DB if _DailyFormDB is null
  Future<Database> get database async => _SymptomDB ??= await _initDatabase();

  Future<Database> _initDatabase() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,'HeadacheFormSymptoms.db');

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
        CREATE TABLE HeadacheFormSymptoms(
          headacheEntryid INTEGER NOT NULL,
          TS INT NOT NULL,
          symptom TEXT,
          PRIMARY KEY (headacheEntryid, TS, symptom),
          FOREIGN KEY (headacheEntryid) REFERENCES HeadacheForm(headacheEntryid),
          FOREIGN KEY (TS) REFERENCES HeadacheForm(TS)
        )
      '''
    );

    // FOREIGN KEY (userid) REFERENCES User(id)
  }


  Future dropTable(Database db, int version) async {
    await db.execute(
        '''
      Drop TABLE HeadacheFormSymptoms
      '''
    );
  }

  fetchTableData() async{
    Database db = await instance.database;
    final result = await db.query('HeadacheFormSymptoms',
        orderBy: 'headacheEntryid DESC',
        );

    // print(result);
    return result;
  }

  Future<List<Map<String, dynamic>>> getEntries(int headacheEntryid) async {
    Database db = await instance.database;
    var result = await db.query(
      'HeadacheFormSymptoms',
      where: 'headacheEntryid = ?',
      whereArgs: [headacheEntryid],
    );

    // print(result);
    return result;
  }

  Future<int> add(HeadacheFormSymptom headacheFormSymptom) async{
    Database db = await instance.database;

    return await db.insert('HeadacheFormSymptoms',headacheFormSymptom.toMap());
  }

}