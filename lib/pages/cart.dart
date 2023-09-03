import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/class/product.dart';

import '../atoms/list_nutshell.dart';
import '../atoms/product.dart';
import '../atoms/product_popup.dart';
import '../class/list_tab_item.dart';
import '../controller/product.controller.dart';

class CartScreen extends StatelessWidget {
  final _controller = Get.find<ProductsController>();
  final _searchController = TextEditingController();

  CartScreen({super.key});

  _addItem(BuildContext context, Product item) async {
    _controller.addItem(item).then((value) => Navigator.of(context).pop());
  }

  Future<void> _editItem(BuildContext context, Product item) async {
    _controller.updateItem(item).then((value) => Navigator.of(context).pop());
  }

  _removeItem(int id) async {
    _controller.deleteItem(id);
  }

  _openCreateFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ProductPopup(
          initProduct: Product(
              id: 0,
              name: '',
              quantity: 1,
              unitPrice: 0,
              trackListId: _controller.cartId.value),
          onSubmit: (Product product) => _addItem(context, product),
        );
      },
    );
  }

  _openEditFormModal(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ProductPopup(
          initProduct: product,
          onSubmit: (Product item) => _editItem(context, item),
        );
      },
    );
  }

  Iterable<Product> _filterProducts(String searchText) => searchText.isEmpty
      ? _controller.products
      : _controller.products.where((product) =>
          product.name.toLowerCase().contains(searchText.toLowerCase()));

  _listProducts() {
    final searchText = _searchController.value.text;
    final productsToShow = _filterProducts(searchText).toList();

    _controller.setproductsToShow(productsToShow);
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final propsItem = arguments['item'] as ListTabItem;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          propsItem.name,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<void>(
          future: _controller.initproducts(_controller.cartId.value),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error loading data'),
              );
            } else {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  children: [
                    Obx(() =>
                        ListNutshell(total: _controller.calculateTotal())),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Filtro',
                        ),
                        controller: _searchController,
                        onChanged: (_) {
                          _listProducts();
                        },
                      ),
                    ),
                    Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          itemCount: _controller.productsToShow.length,
                          itemBuilder: (ctx, index) {
                            final product = _controller.productsToShow[index];

                            return ProductCard(
                              product: product,
                              onEdit: (Product item) =>
                                  _openEditFormModal(context, item),
                              onRemove: _removeItem,
                            );
                          }),
                    )
                  ],
                ),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openCreateFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
