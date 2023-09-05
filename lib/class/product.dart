class Product {
  int id;
  final String name;
  final int quantity;
  final double unitPrice;
  final int trackListId;
  int isInTheCart;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.trackListId,
    required this.isInTheCart,
  });
}
