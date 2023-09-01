import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  static numberToReal(double number) {
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    return "R\$ ${formatter.format(number)}";
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ ${formatter.format(value / 100)}";

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  static double maskRealToDouble(String value) {
    String cleanValue = value.replaceAll('R\$', '').replaceAll('.', '');

    cleanValue = cleanValue.replaceAll(',', '.');

    return double.parse(cleanValue);
  }
}
