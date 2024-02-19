class Taker {
  final int? id;
  final String name;
  final double total_price;
  final String phone;

  Taker({
    this.id,
    required this.name,
    this.total_price = 0.0,
    required this.phone,
  });
}
