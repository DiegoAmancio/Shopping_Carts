import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../class/currency.dart';
import '../class/product.dart';

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
  var putInTheCart = false;
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  final List<String> _unitOptions = ['unit', 'ml', 'kg', 'g', 'box', 'package'];
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

    _nameController.addListener(_updateButtonState);
    _quantityController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
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
        isInTheCart: putInTheCart ? 1 : 0,
        unit: _unitController.text));
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
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_quantityFocus);
                },
                autofocus: true,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'quantity'.tr),
                      textInputAction: TextInputAction.next,
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      focusNode: _quantityFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_unitPriceFocus);
                      },
                    ),
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: DropdownButtonFormField<String>(
                        value: _unitValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _unitValue = newValue!;
                            _unitController.text = newValue;
                          });
                        },
                        items: _unitOptions
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value.tr),
                          );
                        }).toList(),
                      )),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'price'.tr),
                      textInputAction: TextInputAction.next,
                      controller: _unitPriceController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CurrencyPtBrInputFormatter()
                      ],
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      focusNode: _unitPriceFocus,
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
