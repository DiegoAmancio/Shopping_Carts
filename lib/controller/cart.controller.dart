import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

import '../class/list_tab_item.dart';
import '../db/database.dart';
import '../db/list.dart';

class CartController extends GetxController {
  final RxList<ListTabItem> lists = <ListTabItem>[].obs;
  final ListTableDB listTableDB = ListTableDB();
  late Database database;

  Future<void> initializeDatabase() async {
    final db = await AppDatabase().getDB();
    database = db;
  }

  Future<void> addItem(ListTabItem item) async {
    final itemId = await listTableDB.create(database, item);
    item.id = itemId;
    lists.add(item);
  }

  Future<void> updateItem(ListTabItem item) async {
    final itemId = await listTableDB.update(database, item);
    item.id = itemId;
    int index = lists.indexWhere((element) => element.id == item.id);
    lists[index] = item;
  }

  deleteItem(int id) async {
    await listTableDB.delete(database, id);
    int index = lists.indexWhere((element) => element.id == id);
    lists.removeAt(index);
  }

  setLists(List<ListTabItem> newLists) {
    lists.clear();
    lists.addAll(newLists);
  }

  initLists() async {
    await initializeDatabase();

    final itens = await listTableDB.getAll(database, null);
    setLists(itens);
    return itens;
  }
}
