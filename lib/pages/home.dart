import 'dart:math';

import 'package:flutter/material.dart';

import '../class/list_tab_item.dart';
import '../atoms/create_list_form.dart';
import '../molecules/list.dart';

class _HomeScreenState extends State<HomeScreen> {
  final List<ListTabItem> _lists = [
    ListTabItem(
      id: '123',
      name: 'Geladeira',
      date: DateTime.now(),
    ),
    ListTabItem(
      id: '123',
      name: 'Frigobar',
      date: DateTime.now(),
    )
  ];
  _addItem(String name, DateTime selectedDate) {
    final newLists = ListTabItem(
      id: Random().nextDouble().toString(),
      date: selectedDate,
      name: name,
    );

    setState(() {
      _lists.add(newLists);
    });

    Navigator.of(context).pop();
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10, // <-- SEE HERE
            ),
            const Text('Listas',
                style: TextStyle(
                  fontSize: 18,
                )),
            const SizedBox(
              height: 10, // <-- SEE HERE
            ),
            SizedBox(
                height: availableHeight * 0.7,
                child: ListItemTabs(
                  items: _lists,
                ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
