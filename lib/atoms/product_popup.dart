import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../class/currency.dart';
import '../class/product.dart';
import '../utils/validations.dart';

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
  final _unitPriceController = TextEditingController();
  var putInTheCart = false;
  final _formKey = GlobalKey<FormState>();

  final _quantityFocus = FocusNode();
  final _unitPriceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initProduct.name;
    _quantityController.text = widget.initProduct.quantity.toInt().toString();
    _unitPriceController.text =
        CurrencyPtBrInputFormatter.numberToReal(widget.initProduct.unitPrice);
  }

  _submitForm() {
    final name = _nameController.text;
    final int quantity = int.parse(_quantityController.text);
    final double unitPrice =
        CurrencyPtBrInputFormatter.maskRealToDouble(_unitPriceController.text);
    final isInTheCart = putInTheCart ? 1 : 0;

    widget.onSubmit(Product(
      id: widget.initProduct.id,
      name: name,
      quantity: quantity,
      unitPrice: unitPrice,
      trackListId: widget.initProduct.trackListId,
      isInTheCart: isInTheCart,
    ));
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
        width: double.infinity,
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
                validator: (value) {
                  return validatorInputs(value);
                },
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_quantityFocus);
                },
                autofocus: true,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'quantity'.tr),
                textInputAction: TextInputAction.next,
                controller: _quantityController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                focusNode: _quantityFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_unitPriceFocus);
                },
                validator: (value) {
                  return validatorInputs(value);
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: 'price_per_unity'.tr),
                      textInputAction: TextInputAction.next,
                      controller: _unitPriceController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyPtBrInputFormatter()
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      focusNode: _unitPriceFocus,
                      validator: (value) {
                        return validatorInputs(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('insert_to_cart'.tr),
                        Row(
                          children: [
                            const Icon(Icons.shopping_cart),
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Colors.green,
                              value: putInTheCart,
                              onChanged: (bool? value) {
                                setState(() {
                                  putInTheCart = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      }
                    },
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
