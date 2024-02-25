import 'package:flutter/material.dart';
import 'package:pdv_app/model/product.dart';
import 'package:pdv_app/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sale.dart';
import '../model/taker.dart';

class CashierProvider with ChangeNotifier {
  late Database db;

  String _paymentType = 'cash';

  Taker? _takerSelected = null;

  final List<Sale> _items = [];

  List<Sale> get items => [..._items];

  int get itemsCount => _items.length;

  double get total {
    double total = 0;
    for (var i = 0; i < itemsCount; i++) {
      total += items[i].product!.price * items[i].getQuantity;
    }
    return total;
  }

  String get paymentType => _paymentType;
  set paymentType(String value) {
    _paymentType = value;
    notifyListeners();
  }

  Taker? get getTakerSelected => _takerSelected;

  set setTakerSelected(Taker value) {
    _takerSelected = value;
    notifyListeners();
  }

  Future<void> addProduct(String barCode) async {
    db = await DbUtil.instance.database;

    final product = await db.query(
      'products',
      where: 'bar_code = ?',
      whereArgs: [barCode],
    );

    if (product.isNotEmpty) {
      final productSerialized = Product(
        id: int.parse(product[0]['id'].toString()),
        name: product[0]['name'] as String,
        barCode: product[0]['bar_code'] as String,
        price: double.parse(product[0]['price'].toString()),
        costPrice: double.parse(product[0]['cost_price'].toString()),
        unit: int.parse(product[0]['unit'].toString()),
        categoryId: int.parse(product[0]['category_id'].toString()),
        supplierId: int.parse(product[0]['supplier_id'].toString()),
      );

      final index = _items
          .indexWhere((element) => element.productId == productSerialized.id);

      if (index >= 0) {
        _items[index].addQuantity();
      } else {
        _items.add(
          Sale(
            orderId: 1,
            productId: productSerialized.id!,
            quantity: 1,
            product: productSerialized,
          ),
        );
      }

      notifyListeners();
    }
  }

  void removeProduct(int productId) {
    final index =
        _items.indexWhere((element) => element.productId == productId);
    if (index >= 0) {
      _items[index].subtractQuantity();
      if (_items[index].getQuantity == 0) {
        _items.removeAt(index);
      }
      notifyListeners();
    }
  }

  Future<void> sell(List<Sale> sales, int shiftId) async {
    db = await DbUtil.instance.database;

    await db.transaction((txn) async {
      final orderId = await txn.insert(
        'orders',
        {
          'shift_id': shiftId,
          'taker_id': _takerSelected?.id,
          'payment_method': _paymentType,
          'order_time': DateTime.now().toIso8601String(),
        },
      );

      for (var i = 0; i < sales.length; i++) {
        final productId = await txn.insert(
          'sales',
          {
            'order_id': orderId,
            'product_id': sales[i].productId,
            'quantity': sales[i].getQuantity,
          },
        );

        if (productId > 0) {
          await txn.update(
            'products',
            {
              'unit': sales[i].product!.unit - sales[i].getQuantity,
            },
            where: 'id = ?',
            whereArgs: [sales[i].productId],
          );
        }
      }
    });

    _items.clear();
    paymentType = 'cash';
    _takerSelected = null;
    notifyListeners();
  }
}