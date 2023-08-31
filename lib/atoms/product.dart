import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/class/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  String formatMessage() {
    final total = _formatCurrency(product.unitPrice * product.quantity);
    final productQuantity = product.quantity.toInt();
    final expirationTime = _formatDate(product.expirationTime);

    return 'Quantidade: $productQuantity\n'
        'Data de vencimento: $expirationTime\n'
        'Total: $total';
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(amount);
  }

  String _formatDate(DateTime dateTime) {
    return DateFormat('d/MM/y').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(
          product.name.toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          formatMessage(),
          style: const TextStyle(fontSize: 17),
        ),
        trailing: const SizedBox(
          height: double.infinity,
          child: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
