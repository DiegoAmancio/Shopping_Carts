import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityUnitRow extends StatelessWidget {
  final TextEditingController quantityController;
  final FocusNode quantityFocus;
  final FocusNode unitPriceFocus;
  final List<String> unitOptions;
  final String initialUnitValue;

  final void Function(String? unitValue) onChangeUnitValue;

  const QuantityUnitRow(
      {super.key,
      required this.quantityController,
      required this.quantityFocus,
      required this.unitPriceFocus,
      required this.unitOptions,
      required this.onChangeUnitValue,
      required this.initialUnitValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.60,
          child: TextFormField(
            decoration: InputDecoration(labelText: 'quantity'.tr),
            textInputAction: TextInputAction.next,
            controller: quantityController,
            keyboardType: TextInputType.number,
            focusNode: quantityFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(unitPriceFocus);
            },
          ),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.30,
            child: DropdownButtonFormField<String>(
              value: initialUnitValue,
              onChanged: (String? newValue) {
                onChangeUnitValue(newValue);
              },
              items: unitOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.tr),
                );
              }).toList(),
            )),
      ],
    );
  }
}
