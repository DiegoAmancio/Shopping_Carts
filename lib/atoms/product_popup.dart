import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../class/currency.dart';
import '../class/product.dart';

class ProductPopup extends StatefulWidget {
  final Product initProduct;
  final void Function(Product) onSubmit;
  const ProductPopup(this.onSubmit, {super.key, required this.initProduct});

  @override
  State<ProductPopup> createState() => _ProductPopupState();
}

class _ProductPopupState extends State<ProductPopup> {
  DateTime _selectedExpirationTime = DateTime.now();

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _quantityFocus = FocusNode();
  final _unitPriceFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initProduct.name;
    _quantityController.text = widget.initProduct.quantity.toInt().toString();
    _unitPriceController.text = widget.initProduct.unitPrice.toString();
    _selectedExpirationTime = widget.initProduct.expirationTime;
  }

  _submitForm() {
    final name = _nameController.text;
    final double quantity = double.parse(_quantityController.text);
    final double unitPrice =
        CurrencyPtBrInputFormatter.maskRealToDouble(_unitPriceController.text);

    widget.onSubmit(Product(
        id: widget.initProduct.id,
        name: name,
        expirationTime: _selectedExpirationTime,
        quantity: quantity,
        unitPrice: unitPrice,
        trackListId: widget.initProduct.trackListId));
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedExpirationTime = pickedDate;
        });
      }
    });
  }

  validatorInputs(value) {
    if (value == null || value.isEmpty) {
      return 'Campo vazio';
    }
    return null;
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
                decoration:
                    const InputDecoration(label: Text('Nome do produto')),
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
                decoration: const InputDecoration(label: Text('Quantidade')),
                textInputAction: TextInputAction.next,
                controller: _quantityController,
                keyboardType: const TextInputType.numberWithOptions(),
                focusNode: _quantityFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_unitPriceFocus);
                },
                validator: (value) {
                  return validatorInputs(value);
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              TextFormField(
                decoration:
                    const InputDecoration(label: Text('Preço por unidade')),
                textInputAction: TextInputAction.next,
                controller: _unitPriceController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CurrencyPtBrInputFormatter()
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                focusNode: _unitPriceFocus,
                onFieldSubmitted: (_) {
                  _showDatePicker();
                },
                validator: (value) {
                  return validatorInputs(value);
                },
              ),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Data de Validade Selecionada'),
                        Text(DateFormat('dd/MM/y')
                            .format(_selectedExpirationTime)),
                      ],
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
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
                      'Criar',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge?.color,
                      ),
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
