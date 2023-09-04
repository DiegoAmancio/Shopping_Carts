import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/class/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function(Product product) onEdit;
  final void Function(int id) onRemove;

  const ProductCard(
      {Key? key,
      required this.product,
      required this.onEdit,
      required this.onRemove})
      : super(key: key);

  String formatMessage() {
    final total = _formatCurrency(product.unitPrice * product.quantity);
    final productQuantity = product.quantity.toInt();

    return 'Quantidade: $productQuantity Total: $total';
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onEdit(product),
      child: Card(
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
          trailing: IconButton(
            onPressed: () => onRemove(product.id),
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
