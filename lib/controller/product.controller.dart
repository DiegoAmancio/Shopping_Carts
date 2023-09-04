import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

import '../class/product.dart';
import '../db/database.dart';
import '../db/product.dart';

class ProductsController extends GetxController {
  final RxInt cartId = 0.obs;
  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> productsToShow = <Product>[].obs;

  final ProductTableDB productTableDB = ProductTableDB();
  late Database database;

  Future<void> initializeDatabase() async {
    final db = await AppDatabase().getDB();
    database = db;
  }

  calculateTotal() {
    return products.isNotEmpty
        ? products
            .map((product) => product.quantity * product.unitPrice)
            .reduce((sum, value) => sum + value)
        : 0.0;
  }

  calculateTotalInTheCart() {
    final Iterable<Product> isInTheCartList = products.isNotEmpty
        ? products.where((product) => product.isInTheCard == 1)
        : [];

    return isInTheCartList.isNotEmpty
        ? products
            .map((product) => product.quantity * product.unitPrice)
            .reduce((sum, value) => sum + value)
        : 0.0;
  }

  Future<void> addItem(Product product) async {
    final itemId = await productTableDB.create(database, product);
    product.id = itemId;
    products.add(product);
    productsToShow.add(product);
  }

  Future<void> updateItem(Product product) async {
    await productTableDB.update(database, product);
    int index = products.indexWhere((element) => element.id == product.id);
    products[index] = product;

    int indexToShow =
        productsToShow.indexWhere((element) => element.id == product.id);
    productsToShow[indexToShow] = product;
    update();
  }

  deleteItem(int id) async {
    await productTableDB.delete(database, id);
    int indexToShow = productsToShow.indexWhere((element) => element.id == id);
    productsToShow.removeAt(indexToShow);
    int index = products.indexWhere((element) => element.id == id);
    products.removeAt(index);
  }

  setproducts(List<Product> newproducts) {
    products.clear();
    products.addAll(newproducts);
  }

  setproductsToShow(List<Product> newproducts) {
    productsToShow.clear();
    productsToShow.addAll(newproducts);
  }

  initproducts(int listId) async {
    await initializeDatabase();
    cartId.value = listId;
    final itens = await productTableDB.getAll(database, listId);
    setproducts(itens);
    setproductsToShow(itens);

    return itens;
  }
}
