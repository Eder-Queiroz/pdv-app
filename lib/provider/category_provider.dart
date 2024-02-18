import 'package:flutter/material.dart';
import 'package:pdv_app/data/dummy_data.dart';

import '../model/category.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _items = [...categoriesData];

  List<Category> get items => [..._items];

  int get itemsCount => _items.length;
}
