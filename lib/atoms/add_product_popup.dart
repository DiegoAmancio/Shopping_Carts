import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../class/currency.dart';
import '../class/product.dart';

class AddProductPopup extends StatefulWidget {
  final void Function(Product) onSubmit;
  const AddProductPopup(this.onSubmit, {super.key});

  @override
  State<AddProductPopup> createState() => _AddProductPopupState();
}

class _AddProductPopupState extends State<AddProductPopup> {
  DateTime _selectedExpirationTime = DateTime.now();

  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _quantityFocus = FocusNode();
  final _unitPriceFocus = FocusNode();

  _submitForm() {
    final name = _nameController.text;
    final double quantity = double.parse(_quantityController.text);
    final double unitPrice =
        CurrencyPtBrInputFormatter.maskRealToDouble(_unitPriceController.text);

    widget.onSubmit(Product(
        id: Random().nextDouble().toString(),
        name: name,
        expirationTime: _selectedExpirationTime,
        quantity: quantity,
        unitPrice: unitPrice));
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
                    const InputDecoration(label: Text('Nome do carrinho')),
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                focusNode: _quantityFocus,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_unitPriceFocus);
                },
                validator: (value) {
                  return validatorInputs(value);
                },
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
                        Text(DateFormat('d/MM/y')
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
