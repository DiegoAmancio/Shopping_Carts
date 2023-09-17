class Product {
  int id;
  final String name;
  final int quantity;
  final double price;
  final int trackListId;
  final String unit;
  int isInTheCart;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.trackListId,
    required this.isInTheCart,
    required this.unit,
  });
}
