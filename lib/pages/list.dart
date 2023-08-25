import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_list/class/product.dart';

import '../atoms/list_nutshell.dart';
import '../atoms/product.dart';
import '../class/list_tab_item.dart';
import '../molecules/create_list_form.dart';

class _ListScreenState extends State<ListScreen> {
  Iterable<Product> _productsFiltered = [];
  final List<Product> _products = [
    Product(
      id: Random().nextDouble().toString(),
      name: 'nestle',
      expirationTime: DateTime.now(),
      quantity: 1,
      unitPrice: 5,
    )
  ];
  final _searchController = TextEditingController();
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

  @override
  void initState() {
    super.initState();
    _productsFiltered = _products;
  }

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

  listProducts() {
    final searchText = _searchController.value.text;
    final productsToShow = searchText.isEmpty
        ? _products
        : _products.where((product) =>
            product.name.toLowerCase().contains(searchText.toLowerCase()));

    setState(() {
      _productsFiltered = productsToShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;

    final propsItem = arguments['item'] as ListTabItem;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          propsItem.name,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ListNutshell(quantity: 4, total: 4),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Pesquise',
                ),
                controller: _searchController,
                onChanged: (_) {
                  listProducts();
                },
              ),
            ),
            ..._productsFiltered
                .map((Product product) => ProductCard(product: product))
                .toList()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}
