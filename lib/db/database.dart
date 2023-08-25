// ignore_for_file: lines_longer_than_80_chars

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  Future<Database> getDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE ListTable (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, date DATETIME)');
      await db.execute(
          'CREATE TABLE Product (id INTEGER PRIMARY KEY, name TEXT, expirationTime DATETIME, quantity REAL, unitPrice REAL, trackListId INTEGER, FOREIGN KEY(trackListId) REFERENCES ListTable(id))');
    });

    return database;
  }
}
