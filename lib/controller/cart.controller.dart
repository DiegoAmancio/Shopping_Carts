import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../class/list_tab_item.dart';
import '../db/database.dart';
import '../db/list.dart';

class CartController extends GetxController {
  final RxList<ListTabItem> _lists = <ListTabItem>[].obs;
  final ListTableDB _listTableDB = ListTableDB();
  late Database _database;

  List<ListTabItem> get lists {
    return _lists;
  }

  Future<void> initializeDatabase() async {
    final db = await AppDatabase().getDB();
    _database = db;
  }

  Future<void> addItem(ListTabItem item) async {
    final itemId = await _listTableDB.create(_database, item);
    item.id = itemId;
    _lists.add(item);
  }

  Future<void> updateItem(ListTabItem item) async {
    final itemId = await _listTableDB.update(_database, item);
    item.id = itemId;
    int index = _lists.indexWhere((element) => element.id == item.id);
    _lists[index] = item;
  }

  deleteItem(int id) async {
    await _listTableDB.delete(_database, id);
    int index = _lists.indexWhere((element) => element.id == id);
    _lists.removeAt(index);
  }

  setLists(List<ListTabItem> newLists) {
    _lists.clear();
    _lists.addAll(newLists);
  }

  initLists() async {
    await initializeDatabase();

    final itens = await _listTableDB.getAll(_database, null);
    setLists(itens);
    return itens;
  }
}
