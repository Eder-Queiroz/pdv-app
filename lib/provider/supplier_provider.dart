import 'package:flutter/material.dart';
import 'package:pdv_app/data/dummy_data.dart';

import '../model/supplier.dart';

class SupplierProvider with ChangeNotifier {
  final List<Supplier> _items = [...supplierData];

  List<Supplier> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  void addSupplier(String name, String? email, String? phone) {
    final newSupplier = Supplier(
      id: DateTime.now().millisecondsSinceEpoch,
      name: name,
      email: email,
      phone: phone,
    );
    _items.add(newSupplier);
    notifyListeners();
  }
}
