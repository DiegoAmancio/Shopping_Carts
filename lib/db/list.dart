import 'package:shopping_list/class/list_tab_item.dart';
import 'package:sqflite/sqflite.dart';

import 'crud_interface.dart';

class ListTableDB implements CrudInterface {
  @override
  create(Database database, item) async {
    int listId = await database.transaction((txn) async {
      return txn.rawInsert(
        'INSERT INTO ListTable(name, date) VALUES(?, ?)',
        [item.name, item.date.toIso8601String()],
      );
    });

    return listId;
  }

  @override
  delete(Database database, id) async {
    return database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM ListTable WHERE id = ?', [id]);
      await txn.rawDelete('DELETE FROM Product WHERE trackListId = ?', [id]);
    });
  }

  @override
  get(Database database, item) async {
    throw UnimplementedError();
  }

  @override
  update(Database database, item) async {
    int listId = await database.transaction((txn) async {
      return txn.rawUpdate(
        'UPDATE ListTable SET name = ?, date = ? WHERE id = ?',
        [item.name, item.date.toIso8601String(), item.id],
      );
    });

    return listId;
  }

  @override
  getAll(Database database, int? _) async {
    final List<Map<String, dynamic>> maps = await database.query('ListTable');

    return List.generate(maps.length, (index) {
      return ListTabItem(
        id: maps[index]['id'],
        name: maps[index]['name'],
        date: DateTime.parse(maps[index]['date']),
      );
    });
  }
}
