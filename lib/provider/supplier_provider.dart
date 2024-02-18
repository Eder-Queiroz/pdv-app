import 'package:flutter/material.dart';
import 'package:pdv_app/data/dummy_data.dart';
import 'package:sqflite/sqflite.dart';

import '../model/supplier.dart';
import '../utils/db_util.dart';

class SupplierProvider with ChangeNotifier {
  late Database db;

  final List<Supplier> _items = [];

  SupplierProvider() {
    fetchSuppliers();
  }

  List<Supplier> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> fetchSuppliers() async {
    db = await DbUtil.instance.database;

    final List<Map<String, Object?>> suppliers = await db.query('suppliers');

    _items.clear();
    suppliers.forEach(
      (supplier) {
        _items.add(
          Supplier(
            id: int.parse(supplier['id'].toString()),
            name: supplier['name'] as String,
            email: supplier['email'] as String?,
            phone: supplier['phone'] as String?,
          ),
        );
      },
    );

    notifyListeners();
  }

  Future<void> addSupplier(String name, String? email, String? phone) async {
    db = await DbUtil.instance.database;

    await db.insert(
      'suppliers',
      {
        'name': name,
        'email': email,
        'phone': phone,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await fetchSuppliers();
  }
}
