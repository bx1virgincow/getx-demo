import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqlLocalDatabase {
  //singleton of database
  static final SqlLocalDatabase instance =
      SqlLocalDatabase._privateConstructor();
  SqlLocalDatabase._privateConstructor();

  static const String _databaseName = 'trial_db';
  static const int _databaseVersion = 1;

  static const String _itemTable = 'items';
  String get itemTable => _itemTable;

  //static Database
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  //initializing database
  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  _onCreate(Database db, int version) async {
    await db.execute(
      '''
    CREATE TABLE $_itemTable(
      localId INTEGER PRIMARY KEY AUTOINCREMENT,
      id INTEGER,
      userId INTEGER,
      title TEXT,
      body TEXT
      )
    ''',
    );
  }
}
