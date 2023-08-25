import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shopping_list/class/product.dart';

import '../atoms/add_product_popup.dart';
import '../atoms/list_nutshell.dart';
import '../atoms/product.dart';
import '../class/list_tab_item.dart';

class _CartScreenState extends State<CartScreen> {
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

  @override
  void initState() {
    super.initState();
    _productsFiltered = _products;
  }

  _addItem(Product product) {
    setState(() {
      _products.add(product);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return AddProductPopup(_addItem);
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

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            propsItem.name,
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  .reversed
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}
