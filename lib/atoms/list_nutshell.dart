import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNutshell extends StatelessWidget {
  final double total;
  final double quantity;

  const ListNutshell({super.key, required this.total, required this.quantity});

  @override
  Widget build(BuildContext context) {
    final totalFormated =
        NumberFormat.currency(locale: "pt_BR", symbol: "R\$").format(total);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 35,
          width: 100,
          child: ListTile(
            title: const Text(
              'Total',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              totalFormated,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
