import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/controller/cart.controller.dart';
import 'package:shopping_list/db/database.dart';
import 'package:sqflite/sqflite.dart';

import '../class/list_tab_item.dart';
import '../atoms/create_list_form.dart';
import '../db/list.dart';
import '../molecules/list.dart';

class _HomeScreenState extends State<HomeScreen> {
  late final CartController _controller;
  late Database database;
  final listTableDB = ListTableDB();

  Future<void> initializeDatabase() async {
    final db = await AppDatabase().getDB();
    final itens = await listTableDB.getAll(db);
    database = db;
    _controller.initLists(itens);
  }

  @override
  void initState() {
    super.initState();
    _controller = Get.put(CartController());
    initializeDatabase();
  }

  _addItem(String name, DateTime date) async {
    var item = ListTabItem(
      id: 1,
      date: date,
      name: name,
    );
    final itemId = await listTableDB.create(database, item);
    item.id = itemId;

    _controller.addItem(item);

    setState(() {
      Navigator.of(context).pop();
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return CreateListForm(_addItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping list',
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Obx(() {
        return _controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Listas',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: availableHeight * 0.7,
                        child: ListItemTabs(
                          items: _controller.lists,
                        ))
                  ],
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
