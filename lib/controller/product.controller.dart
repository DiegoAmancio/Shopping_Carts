import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

import '../class/product.dart';
import '../db/database.dart';
import '../db/product.dart';

class ProductsController extends GetxController {
  final RxInt cartId = 0.obs;
  final RxDouble total = (0.0).obs;
  final RxList<Product> products = <Product>[].obs;
  final RxList<Product> productsToShow = <Product>[].obs;

  final ProductTableDB productTableDB = ProductTableDB();
  late Database database;

  Future<void> initializeDatabase() async {
    final db = await AppDatabase().getDB();
    database = db;
  }

  calculateTotal() {
    total.value = products.isNotEmpty
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
    calculateTotal();
  }

  Future<void> updateItem(Product product) async {
    await productTableDB.update(database, product);
    int index =
        productsToShow.indexWhere((element) => element.id == product.id);
    productsToShow[index] = product;

    int indexToShow =
        products.indexWhere((element) => element.id == product.id);
    products.removeAt(indexToShow);
    calculateTotal();
  }

  deleteItem(int id) async {
    await productTableDB.delete(database, id);
    int index = productsToShow.indexWhere((element) => element.id == id);
    productsToShow.removeAt(index);
    int indexToShow = products.indexWhere((element) => element.id == id);
    products.removeAt(indexToShow);
    calculateTotal();
  }

  setproducts(List<Product> newproducts) {
    products.clear();
    products.addAll(newproducts);
    calculateTotal();
  }

  setproductsToShow(List<Product> newproducts) {
    productsToShow.clear();
    productsToShow.addAll(newproducts);
  }

  initproducts(int listId) async {
    await initializeDatabase();

    final itens = await productTableDB.getAll(database, listId);
    setproducts(itens);
    setproductsToShow(itens);

    return itens;
  }
}
