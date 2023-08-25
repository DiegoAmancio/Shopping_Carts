// ignore_for_file: lines_longer_than_80_chars

import 'package:shopping_list/db/crud_interface.dart';
import 'package:sqflite/sqflite.dart';

import '../class/product.dart';

class ProductDB implements CrudInterface {
  @override
  create(Database database, item) async {
    int itemId = await database.transaction((txn) async {
      return txn.rawInsert(
        'INSERT INTO item(name, expirationTime, quantity, unitPrice, trackListId) VALUES(?, ?, ?, ?, ?)',
        [
          item.name,
          item.expirationTime.toIso8601String(),
          item.quantity,
          item.unitPrice,
          item.listId
        ],
      );
    });

    return itemId;
  }

  @override
  delete(Database database, item) {
    return database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM item WHERE id = ?', [item.id]);
    });
  }

  @override
  get(Database database, item) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'Product',
      where: 'trackListId = ?',
      whereArgs: [item],
    );

    return List.generate(maps.length, (index) {
      return Product(
        id: maps[index]['id'],
        name: maps[index]['name'],
        expirationTime: DateTime.parse(maps[index]['expirationTime']),
        quantity: maps[index]['quantity'],
        unitPrice: maps[index]['unitPrice'],
      );
    });
  }

  @override
  update(Database database, item) async {
    int itemId = await database.transaction((txn) async {
      return txn.rawUpdate(
        'UPDATE item SET name = ?, expirationTime = ?, quantity = ?, unitPrice = ? WHERE id = ?',
        [
          item.name,
          item.expirationTime.toIso8601String(),
          item.quantity,
          item.unitPrice,
        ],
      );
    });

    return itemId;
  }

  @override
  getAll(Database database) {
    // TODO: implement getAll
    throw UnimplementedError();
  }
}
