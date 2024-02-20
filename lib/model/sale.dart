class Sale {
  final int? id;
  final int orderId;
  final int productId;
  final int quantity;

  Sale({
    this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });
}
