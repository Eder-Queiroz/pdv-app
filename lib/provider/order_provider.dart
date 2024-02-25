import 'package:flutter/material.dart';
import 'package:pdv_app/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

import '../model/order.dart';
import '../model/product.dart';
import '../model/sale.dart';

class OrderProvider with ChangeNotifier {
  late Database db;

  final List<Order> _items = [];

  OrderProvider() {
    loadOrders();
  }

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    db = await DbUtil.instance.database;

    await db.transaction((txn) async {
      final List<Map<String, dynamic>> orders = await txn.query('orders');

      _items.clear();

      orders.forEach((order) async {
        final List<Map<String, dynamic>> sales = await db.rawQuery(
            "SELECT s.*, p.bar_code, p.name, p.price, p.cost_price, p.unit, p.category_id, p.supplier_id FROM sales as s INNER JOIN products as p ON s.product_id = p.id WHERE s.order_id = ${order['id']}");

        final List<Sale> listSales = [];

        double total = 0.0;

        sales.forEach((sale) {
          listSales.add(Sale(
            id: int.parse(sale['id'].toString()),
            productId: int.parse(sale['product_id'].toString()),
            orderId: int.parse(sale['order_id'].toString()),
            quantity: sale['quantity'],
            product: Product(
              id: int.parse(sale['product_id'].toString()),
              name: sale['name'],
              barCode: sale['bar_code'],
              price: double.parse(sale['price'].toString()),
              costPrice: double.parse(sale['cost_price'].toString()),
              unit: int.parse(sale['unit'].toString()),
              categoryId: int.parse(sale['category_id'].toString()),
              supplierId: int.parse(sale['supplier_id'].toString()),
            ),
          ));

          total += sale['quantity'] * double.parse(sale['price'].toString());
        });

        _items.add(Order(
          id: int.parse(order['id'].toString()),
          paymentType: order['payment_method'],
          orderTime: DateTime.parse(order['order_time'] as String),
          shiftId: int.parse(order['shift_id'].toString()),
          takerId: int.tryParse(order['taker_id'].toString()),
          sales: listSales,
          total: total,
        ));
      });
    });

    notifyListeners();
  }
}
