class Product {
  final int? id;
  final String barCode;
  final String name;
  final double price;
  final double costPrice;
  final int unit;
  final String? urlImage;
  final int categoryId;
  final String? categoryName;
  final int supplierId;
  final String? supplierName;

  Product({
    this.id,
    required this.barCode,
    required this.name,
    required this.price,
    required this.costPrice,
    required this.unit,
    this.urlImage,
    required this.categoryId,
    this.categoryName,
    required this.supplierId,
    this.supplierName,
  });
}
