import 'package:pdv_app/model/product.dart';

class Sale {
  final int? id;
  final int orderId;
  final int productId;
  late int _quantity;
  final Product? product;

  Sale({
    this.id,
    required this.orderId,
    required this.productId,
    required quantity,
    this.product,
  }) {
    setQuantity = quantity;
  }

  set setQuantity(int quantity) {
    _quantity = quantity;
  }

  get getQuantity => _quantity;

  void addQuantity() {
    _quantity++;
  }

  void subtractQuantity() {
    _quantity--;
  }
}
