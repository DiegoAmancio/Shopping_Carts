import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNutshell extends StatelessWidget {
  final double total;

  const ListNutshell({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final totalFormated =
        NumberFormat.currency(locale: "pt_BR", symbol: "R\$").format(total);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: ListTile(
                leading: const Icon(
                  Icons.calculate,
                ),
                title: const Text(
                  'Total',
                ),
                subtitle: Text(totalFormated),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.5,
              child: ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: const Text('Total'),
                subtitle: Text(totalFormated),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
