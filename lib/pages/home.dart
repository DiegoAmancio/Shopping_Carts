import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/controller/cart.controller.dart';

import '../class/list_tab_item.dart';
import '../atoms/list_form_popup.dart';
import '../molecules/list_tab.dart';

class HomeScreen extends StatelessWidget {
  final _controller = Get.find<CartController>();

  HomeScreen({super.key});

  _addItem(BuildContext context, ListTabItem item) async {
    _controller.addItem(item).then((value) => Navigator.of(context).pop());
  }

  Future<void> _editItem(BuildContext context, ListTabItem item) async {
    _controller.updateItem(item).then((value) => Navigator.of(context).pop());
  }

  _removeItem(int id) async {
    _controller.deleteItem(id);
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
          initItem: _controller.lists
              .where((element) => element.id == id)
              .toList()[0],
        );
      },
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
          future: _controller.initLists(),
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
                            itemCount: _controller.lists.length,
                            itemBuilder: (ctx, index) {
                              final item = _controller.lists[index];
                              return ListTab(
                                item: item,
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
