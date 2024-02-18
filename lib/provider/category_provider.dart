import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../model/category.dart';
import '../utils/db_util.dart';

class CategoryProvider with ChangeNotifier {
  late Database db;

  final List<Category> _items = [];

  List<Category> get items => [..._items];

  CategoryProvider() {
    loadCategories();
  }

  int get itemsCount => _items.length;

  Future<void> loadCategories() async {
    db = await DbUtil.instance.database;
    final List<Map<String, dynamic>> categories = await db.query("categories");
    _items.clear();
    categories.forEach((category) {
      _items.add(Category(
        id: category["id"],
        name: category["name"],
      ));
    });
    notifyListeners();
  }

  Future<void> createCategory(String name) async {
    db = await DbUtil.instance.database;

    await db.insert(
      "categories",
      {
        "name": name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    loadCategories();
  }
}
