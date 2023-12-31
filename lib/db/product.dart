// ignore_for_file: lines_longer_than_80_chars

import 'package:shopping_list/db/crud_interface.dart';
import 'package:sqflite/sqflite.dart';

import '../class/product.dart';

class ProductTableDB implements CrudInterface {
  @override
  create(Database database, item) async {
    int itemId = await database.transaction((txn) async {
      return txn.rawInsert(
        'INSERT INTO Product(name, quantity, price, trackListId, isInTheCart, unit) VALUES(?, ?, ?, ?, ?, ?)',
        [
          item.name,
          item.quantity,
          item.price,
          item.trackListId,
          item.isInTheCart,
          item.unit
        ],
      );
    });

    return itemId;
  }

  @override
  delete(Database database, id) {
    return database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM Product WHERE id = ?', [id]);
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
        quantity: maps[index]['quantity'],
        price: maps[index]['price'],
        trackListId: maps[index]['trackListId'],
        isInTheCart: maps[index]['isInTheCart'],
        unit: maps[index]['unit'],
      );
    });
  }

  @override
  update(Database database, item) async {
    int itemId = await database.transaction((txn) async {
      return txn.rawUpdate(
        'UPDATE Product SET name = ?, quantity = ?, price = ?, trackListId = ?, isInTheCart = ?, unit =  ? WHERE id = ?',
        [
          item.name,
          item.quantity,
          item.price,
          item.trackListId,
          item.isInTheCart,
          item.id,
          item.unit
        ],
      );
    });

    return itemId;
  }

  @override
  getAll(Database database, int? id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      'Product',
      where: 'trackListId = ?',
      whereArgs: [id],
    );

    return List.generate(maps.length, (index) {
      return Product(
        id: maps[index]['id'],
        name: maps[index]['name'],
        quantity: maps[index]['quantity'],
        price: maps[index]['price'],
        trackListId: maps[index]['trackListId'],
        isInTheCart: maps[index]['isInTheCart'],
        unit: maps[index]['unit'],
      );
    });
  }
}
