import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/class/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  formatMessage() {
    final total = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$')
        .format((product.unitPrice * product.quantity));
    final productQuantity = product.quantity.toInt();
    final expirationTime = DateFormat('d/MM/y').format(product.expirationTime);

    return 'Quantidade: $productQuantity\nData de vencimento $expirationTime\nTotal:  $total';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(product.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        subtitle: Text(
          formatMessage(),
          style: const TextStyle(fontSize: 17),
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
