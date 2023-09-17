import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/controller/cart.controller.dart';
import 'package:shopping_list/controller/product.controller.dart';

import '../class/list_tab_item.dart';
import '../components/atoms/list_form_popup.dart';
import '../components/molecules/list_tab.dart';

class HomeScreen extends StatelessWidget {
  final _cartController = Get.find<CartController>();
  final _productController = Get.find<ProductsController>();

  HomeScreen({super.key});

  _addItem(BuildContext context, ListTabItem item) async {
    _cartController.addItem(item).then((value) => Navigator.of(context).pop());
  }

  Future<void> _editItem(BuildContext context, ListTabItem item) async {
    _cartController
        .updateItem(item)
        .then((value) => Navigator.of(context).pop());
  }

  _removeItem(int id) async {
    _cartController.deleteItem(id);
  }

  _openCreateFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListFormPopup(
          (ListTabItem item) => _addItem(context, item),
          initItem: ListTabItem(id: 0, name: '', date: DateTime.now()),
        );
      },
    );
  }

  _openEditFormModal(
    BuildContext context,
    int id,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ListFormPopup(
          (ListTabItem item) => _editItem(context, item),
          initItem: _cartController.lists
              .where((element) => element.id == id)
              .toList()[0],
        );
      },
    );
  }

  openCartList(BuildContext context, ListTabItem item) {
    _productController.setCartId(item.id);

    Navigator.pushNamed(
      context,
      '/list',
      arguments: {'item': item},
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'lists'.tr,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
          future: _cartController.initLists(),
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
              return Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: availableHeight * 0.7,
                      child: Obx(() => ListView.builder(
                            itemCount: _cartController.lists.length,
                            itemBuilder: (ctx, index) {
                              final item = _cartController.lists[index];
                              return ListTab(
                                item: item,
                                openCartList: () {
                                  openCartList(context, item);
                                },
                                onEdit: (int id) =>
                                    _openEditFormModal(context, id),
                                onRemove: _removeItem,
                              );
                            },
                          ))),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openCreateFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
