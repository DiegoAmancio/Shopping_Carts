import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/class/product.dart';

import '../components/atoms/list_nutshell.dart';
import '../components/atoms/product.dart';
import '../components/molecules/product_popup.dart';
import '../class/list_tab_item.dart';
import '../controller/product.controller.dart';

class CartScreen extends StatelessWidget {
  final _controller = Get.find<ProductsController>();

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
              price: 0,
              trackListId: _controller.cartId,
              isInTheCart: 0,
              unit: 'unit'),
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

  onPutOrRemoveFromCart(Product product) async {
    await _controller.updateItem(product);
  }

  getInCartProducts() => _controller.productsToShow
      .where((product) => product.isInTheCart == 1)
      .toList();

  getOutCartProducts() => _controller.productsToShow
      .where((product) => product.isInTheCart == 0)
      .toList();

  createListOfProducts(BuildContext context, List<Product> list) =>
      ListView.builder(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (ctx, index) {
            final product = list[index];

            return ProductCard(
              product: product,
              onEdit: (Product item) => _openEditFormModal(context, item),
              onRemove: _removeItem,
              onPutOrRemoveFromCart: onPutOrRemoveFromCart,
            );
          });
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final listPropsItem = arguments['item'] as ListTabItem;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          listPropsItem.name,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<void>(
            future: _controller.initproducts(listPropsItem.id),
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
                  children: [
                    Obx(
                      () => Column(
                        children: [
                          ExpansionTile(
                            initiallyExpanded: true,
                            title: Text(
                              'out_of_cart'.tr,
                              style: const TextStyle(
                                  fontSize: 18, fontFamily: 'bold'),
                            ),
                            trailing: Obx(() => Icon(
                                  _controller.expandOutCartItens
                                      ? Icons.arrow_downward
                                      : Icons.arrow_upward,
                                )),
                            onExpansionChanged:
                                _controller.setExpandOutCartItens,
                            children: [
                              createListOfProducts(
                                  context, getOutCartProducts())
                            ],
                          ),
                        ],
                      ),
                    ),
                    Obx(() => Column(
                          children: [
                            ExpansionTile(
                              initiallyExpanded: true,
                              title: Text(
                                'in_the_cart'.tr,
                                style: const TextStyle(
                                    fontSize: 18, fontFamily: 'bold'),
                              ),
                              trailing: Obx(() => Icon(
                                    _controller.expandInCartItens
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                  )),
                              onExpansionChanged:
                                  _controller.setExpandInCartItens,
                              children: [
                                createListOfProducts(
                                    context, getInCartProducts())
                              ],
                            ),
                          ],
                        ))
                  ],
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openCreateFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: Obx(() => ListNutshell.fromDoubles(
          total: _controller.calculateTotal(),
          totalInTheCart: _controller.calculateTotalInTheCart())),
    );
  }
}
