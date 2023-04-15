import 'package:fluttertest/databasemodel/headache.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class headache_database {
  static final headache_database instance = headache_database._init();

  static Database? _database;

  headache_database._init();

  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final stringType = 'STRING NOT NULL';

    await db.execute('''
      CREATE TABLE $userinfoFields (
        ${userinfoFields.id} $idType, 
        ${userinfoFields.username} $stringType,
        ${userinfoFields.password} $integerType,
        ${userinfoFields.gender} $boolType,
      )
    ''');
  }
}