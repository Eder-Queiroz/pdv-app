import 'package:flutter/material.dart';
import 'package:pdv_app/data/dummy_data.dart';

import '../model/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [...productsData];

  List<Product> get items => [..._items];

  int get itemsCount => _items.length;
}
