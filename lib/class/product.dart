class Product {
  int id;
  final String name;
  final int quantity;
  final double unitPrice;
  final int trackListId;

  Product(
      {required this.id,
      required this.name,
      required this.quantity,
      required this.unitPrice,
      required this.trackListId});
}
