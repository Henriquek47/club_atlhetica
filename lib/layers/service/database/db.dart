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
      version: 2,
      onCreate:  _onCreate,
    );
  }

  _onCreate(Database db, version) async {
    await db.execute(_responseAllRounds);
    await db.execute(_winner);
  }
// ADICONAR NOME DA LIGA PARA NAO BAGUNÇAR NO DRAWER PAGE
  String get _responseAllRounds => '''
  CREATE TABLE round (
    idLeague INTEGER PRIMARY KEY,
    response TEXT,
    day INTEGER,
    month INTEGER
  )
''';

String get _winner => '''
  CREATE TABLE team (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    winner TEXT,
    fixture INTEGER
  )
''';
}