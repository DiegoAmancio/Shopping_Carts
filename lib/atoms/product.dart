import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopping_list/class/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final void Function(Product product) onEdit;
  final void Function(int id) onRemove;
  final void Function(Product product) onPutOrRemoveFromCart;

  const ProductCard(
      {Key? key,
      required this.product,
      required this.onEdit,
      required this.onRemove,
      required this.onPutOrRemoveFromCart})
      : super(key: key);

  _formatProductQuantity() {
    if (product.quantity < 10) {
      final quantityFormated = product.quantity.toString();
      return '0$quantityFormated';
    }

    return product.quantity;
  }

  String _formatMessage() {
    final total = _formatCurrency(product.unitPrice * product.quantity);
    final unitPrice = _formatCurrency(product.unitPrice);
    final productQuantity = _formatProductQuantity();

    return '  $productQuantity x $unitPrice Total: $total';
  }

  String _formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(amount);
  }

  getStyle(BuildContext context) => product.isInTheCart == 1
      ? TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough,
          decorationColor: Theme.of(context).textTheme.titleLarge?.color,
          decorationThickness: 2.0,
        )
      : const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onEdit(product),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: Container(
              width: 40,
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  product.isInTheCart == 1
                      ? Icons.remove_shopping_cart
                      : Icons.add_shopping_cart,
                  size: 30,
                ),
                onPressed: () {
                  var productUpdated = product;
                  productUpdated.isInTheCart =
                      productUpdated.isInTheCart == 1 ? 0 : 1;
                  onPutOrRemoveFromCart(productUpdated);
                },
              )),
          title: Text(
            product.name.toUpperCase(),
            style: getStyle(context),
          ),
          subtitle: Text(
            _formatMessage(),
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
