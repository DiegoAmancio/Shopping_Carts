class Product {
  int id;
  final String name;
  final int quantity;
  final double unitPrice;
  final int trackListId;
  final int isInTheCard;

  Product({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.trackListId,
    required this.isInTheCard,
  });
}
