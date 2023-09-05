import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListNutshell extends StatelessWidget {
  final String total;
  final String totalInTheCart;

  const ListNutshell({
    super.key,
    required this.total,
    required this.totalInTheCart,
  });

  static String formatCurrency(double value) {
    return NumberFormat.currency(locale: "pt_BR", symbol: "R\$").format(value);
  }

  factory ListNutshell.fromDoubles({
    Key? key,
    required double total,
    required double totalInTheCart,
  }) {
    return ListNutshell(
      key: key,
      total: formatCurrency(total),
      totalInTheCart: formatCurrency(totalInTheCart),
    );
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Theme.of(context).primaryColor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: ListTile(
                leading: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 40,
                ),
                title: const Text(
                  'No carrinho',
                  style: textStyle,
                ),
                subtitle: Text(
                  totalInTheCart,
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.2,
              child: ListTile(
                leading: const Icon(
                  color: Colors.white,
                  size: 40,
                  Icons.calculate,
                ),
                title: const Text(
                  'Total',
                  style: textStyle,
                ),
                subtitle: Text(
                  total,
                  style: textStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
