import 'package:flutter/material.dart';
import 'package:pdv_app/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

import '../model/order.dart';

class OrderProvider with ChangeNotifier {
  late Database db;

  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    db = await DbUtil.instance.database;

    final List<Map<String, Object?>> orders = await db.query('orders');

    _items.clear();
    orders.forEach((order) {
      _items.add(Order(
        id: int.parse(order['id'].toString()),
        shiftId: int.parse(order['shift_id'].toString()),
        takerId: order['taker_id'] != null
            ? int.parse(order['taker_id'].toString())
            : null,
        paymentType: order['payment_type'] as String,
        orderTime: DateTime.parse(order['order_time'] as String),
      ));
    });

    notifyListeners();
  }
}
