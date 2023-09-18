import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_list/components/atoms/price_row.dart';
import 'package:shopping_list/components/atoms/quantity_unit_row.dart';

import '../../class/currency.dart';
import '../../class/product.dart';

class ProductPopup extends StatefulWidget {
  final Product initProduct;

  final void Function(Product) onSubmit;
  const ProductPopup({
    Key? key,
    required this.onSubmit,
    required this.initProduct,
  }) : super(key: key);

  @override
  State<ProductPopup> createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _unitPriceController = TextEditingController();
  bool _putInTheCart = false;
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  final List<String> _unitOptions = [
    'unit',
    'l',
    'ml',
    'kg',
    'g',
    'box',
    'package'
  ];
  String _unitValue = 'unit';

  final _quantityFocus = FocusNode();
  final _unitPriceFocus = FocusNode();

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nameController.text.isNotEmpty &&
          _quantityController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initProduct.name;
    _quantityController.text = widget.initProduct.quantity.toInt().toString();
    _unitPriceController.text =
        CurrencyPtBrInputFormatter.numberToReal(widget.initProduct.price);
    _unitController.text = widget.initProduct.unit;
    _putInTheCart = widget.initProduct.isInTheCart == 1;
    _nameController.addListener(_updateButtonState);
    _quantityController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  _submitForm() {
    final int quantity =
        int.parse(_quantityController.text.replaceAll(',', '.'));
    final double price =
        CurrencyPtBrInputFormatter.maskRealToDouble(_unitPriceController.text);

    widget.onSubmit(Product(
        id: widget.initProduct.id,
        name: _nameController.text,
        quantity: quantity,
        price: price,
        trackListId: widget.initProduct.trackListId,
        isInTheCart: _putInTheCart ? 1 : 0,
        unit: _unitController.text));
  }

  onChangeUnitValue(String? value) {
    setState(() {
      _unitValue = value!;
      _unitController.text = value;
    });
  }

  onChangePutInTheCart(bool? value) {
    setState(() {
      _putInTheCart = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 10,
        right: 10,
        bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: 300,
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'product_name'.tr),
                textInputAction: TextInputAction.next,
                controller: _nameController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_quantityFocus);
                },
              ),
              QuantityUnitRow(
                initialUnitValue: _unitValue,
                quantityController: _quantityController,
                quantityFocus: _quantityFocus,
                unitOptions: _unitOptions,
                unitPriceFocus: _unitPriceFocus,
                onChangeUnitValue: onChangeUnitValue,
              ),
              PriceRow(
                putInTheCart: _putInTheCart,
                onChangePutInTheCart: onChangePutInTheCart,
                unitPriceController: _unitPriceController,
                unitPriceFocus: _unitPriceFocus,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _isButtonEnabled ? _submitForm : null,
                    child: Text(
                      'save'.tr,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
