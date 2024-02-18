import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../model/product.dart';
import '../utils/db_util.dart';

class ProductProvider with ChangeNotifier {
  late Database db;

  final List<Product> _items = [];

  ProductProvider() {
    loadProducts();
  }

  List<Product> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadProducts() async {
    db = await DbUtil.instance.database;
    final List<Map<String, dynamic>> products = await db.query("products");
    _items.clear();
    products.forEach((product) {
      _items.add(Product(
        id: int.parse(product["id"].toString()),
        name: product["name"] as String,
        barCode: product["bar_code"] as String,
        price: double.parse(product["price"].toString()),
        costPrice: double.parse(product["cost_price"].toString()),
        unit: int.parse(product["unit"].toString()),
        urlImage: product["url_image"] as String?,
        categoryId: int.parse(product["category_id"].toString()),
        supplierId: int.parse(product["supplier_id"].toString()),
      ));
    });
    notifyListeners();
  }

  Future<void> createProduct({
    required String name,
    required String barCode,
    required double price,
    required double costPrice,
    required int unit,
    required String? urlImage,
    required int categoryId,
    required int supplierId,
  }) async {
    db = await DbUtil.instance.database;
    await db.insert(
      "products",
      {
        "name": name,
        "bar_code": barCode,
        "price": price.toStringAsFixed(2),
        "cost_price": costPrice.toStringAsFixed(2),
        "unit": unit,
        "url_image": urlImage,
        "category_id": categoryId,
        "supplier_id": supplierId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    loadProducts();
  }
}
