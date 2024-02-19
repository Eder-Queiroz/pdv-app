import 'package:flutter/material.dart';
import 'package:pdv_app/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

import '../model/taker.dart';

class TakerProvider with ChangeNotifier {
  late Database db;
  final List<Taker> _items = [];

  TakerProvider() {
    loadTakers();
  }

  List<Taker> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadTakers() async {
    db = await DbUtil.instance.database;

    final takers = await db.query('takers');

    _items.clear();
    _items.addAll(takers
        .map((taker) => Taker(
              id: int.parse(taker['id'].toString()),
              name: taker['name'] as String,
              phone: taker['phone'] as String,
            ))
        .toList());

    notifyListeners();
  }

  Future<void> createTaker(String name, String phone) async {
    db = await DbUtil.instance.database;

    final id = await db.insert('takers', {
      'name': name,
      'total_price': 0.00,
      'phone': phone,
    });

    _items.add(Taker(
      id: id,
      name: name,
      phone: phone,
    ));

    notifyListeners();
  }

  Future<void> updateTaker(int id, String name, String phone) async {
    db = await DbUtil.instance.database;

    await db.update(
        'takers',
        {
          'name': name,
          'phone': phone,
        },
        where: 'id = ?',
        whereArgs: [id]);

    final takerIndex = _items.indexWhere((taker) => taker.id == id);

    if (takerIndex >= 0) {
      _items[takerIndex] = Taker(
        id: id,
        name: name,
        phone: phone,
      );
    }

    notifyListeners();
  }
}
