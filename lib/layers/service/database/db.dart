import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB{

  DB._();

  static final DB instance = DB._();

  static Database? _database;

  get database async {
    if(_database != null){
      return _database;
    }else{
      return await _initDatabase();
    }
  }
  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'atlhetica.db'),
      version: 1,
      onCreate:  _onCreate,
    );
  }

  _onCreate(Database db, version) async {
    await db.execute(_responseAllRounds);
    await db.execute(_winner);
  }

  String get _responseAllRounds => '''
  CREATE TABLE round (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    response TEXT
  )
''';

String get _winner => '''
  CREATE TABLE team (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    winner TEXT,
    loser TEXT
  )
''';
}