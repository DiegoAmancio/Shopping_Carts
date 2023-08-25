import 'package:sqflite/sqflite.dart';

abstract class CrudInterface {
  create(Database database, item) async {}
  get(Database database, item) async {}
  getAll(Database database) async {}
  update(Database database, item) async {}
  delete(Database database, item) async {}
}
