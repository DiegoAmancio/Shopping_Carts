import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNutshell extends StatelessWidget {
  final double total;

  const ListNutshell({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final totalFormated =
        NumberFormat.currency(locale: "pt_BR", symbol: "R\$").format(total);
    return SizedBox(
        height: 35,
        width: double.infinity,
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
        ));
  }
}
