class Product {
  int id;
  final String name;
  final DateTime expirationTime;
  final int quantity;
  final double unitPrice;
  final int trackListId;

  Product(
      {required this.id,
      required this.name,
      required this.expirationTime,
      required this.quantity,
      required this.unitPrice,
      required this.trackListId});
}
