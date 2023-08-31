import 'package:get/get.dart';

import 'controller/cart.controller.dart';

class StoreBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
  }
}
