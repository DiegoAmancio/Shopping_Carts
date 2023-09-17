import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  final _nameController = TextEditingController().obs;
  final _quantityController = TextEditingController().obs;
  final _unitController = TextEditingController().obs;
  final _unitPriceController = TextEditingController().obs;
  final _putInTheCart = false.obs;

  final _quantityFocus = FocusNode();
  final _unitPriceFocus = FocusNode();

  get quantityFocus => _quantityFocus;

  get unitPriceFocus => _unitPriceFocus;

  get nameController => _nameController;

  set nameController(value) => _nameController.value.text = value;

  get quantityController => _quantityController;

  set quantityController(value) => _quantityController.value.text = value;

  get unitController => _unitController;

  set unitController(value) => _unitController.value.text = value;

  get unitPriceController => _unitPriceController;

  set unitPriceController(value) => _unitPriceController.value.text = value;

  get putInTheCart => _putInTheCart;

  set putInTheCart(value) => _putInTheCart.value = value;
}
