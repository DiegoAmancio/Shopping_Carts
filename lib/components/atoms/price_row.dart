import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../class/currency.dart';

class PriceRow extends StatelessWidget {
  final TextEditingController unitPriceController;
  final FocusNode unitPriceFocus;

  final bool putInTheCart;
  final void Function(bool? value) onChangePutInTheCart;

  const PriceRow(
      {super.key,
      required this.unitPriceController,
      required this.unitPriceFocus,
      required this.onChangePutInTheCart,
      required this.putInTheCart});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'price'.tr),
            textInputAction: TextInputAction.next,
            controller: unitPriceController,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CurrencyPtBrInputFormatter()
            ],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            focusNode: unitPriceFocus,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
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
                      onChanged: onChangePutInTheCart,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
