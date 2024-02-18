import 'package:flutter/material.dart';
import 'package:pdv_app/model/shift.dart';
import 'package:sqflite/sqflite.dart';
import 'package:pdv_app/utils/db_util.dart';

class ShiftProvider with ChangeNotifier {
  late Database db;

  final List<Shift> _items = [];

  ShiftProvider() {
    fetchShifts();
  }

  List<Shift> get items {
    return [..._items].reversed.toList();
  }

  int get itemsCount => _items.length;

  int? openShiftId(int userId) {
    final shiftIndex =
        _items.indexWhere((shift) => shift.userId == userId && shift.isOpened);
    return shiftIndex >= 0 ? _items[shiftIndex].id! : null;
  }

  Future<void> fetchShifts() async {
    db = await DbUtil.instance.database;

    final List<Map<String, Object?>> shifts = await db.rawQuery(
        'SELECT s.*, u.name FROM shifts as s INNER JOIN users as u ON s.user_id = u.id');

    print(shifts);

    _items.clear();
    shifts.forEach((shift) {
      _items.add(Shift(
        id: int.parse(shift['id'].toString()) as int,
        userId: int.parse(shift['user_id'].toString()) as int,
        name: shift['name'] as String,
        startTime: DateTime.parse(shift['start_time'] as String),
        endTime: shift['end_time'] != null
            ? DateTime.parse(shift['end_time'] as String)
            : null,
        startCash: double.parse(shift['start_cash'].toString()),
        endCash: double.parse(shift['start_cash'].toString()),
        isOpened: shift['is_opened'] == 1,
      ));
    });

    notifyListeners();
  }

  Future<void> openShift({
    required double startCash,
    required int userId,
  }) async {
    db = await DbUtil.instance.database;

    final shift = Shift(
      userId: userId,
      startTime: DateTime.now(),
      startCash: startCash,
      isOpened: true,
    );

    await db.insert(
      'shifts',
      {
        'user_id': shift.userId,
        'start_time': shift.startTime.toIso8601String(),
        'start_cash': shift.startCash.toStringAsFixed(2),
        'is_opened': shift.isOpened ? 1 : 0,
      },
    );

    await fetchShifts();
  }

  void endShift({
    required int shiftId,
    required double endCash,
  }) async {
    db = await DbUtil.instance.database;

    await db.update(
      'shifts',
      {
        'end_time': DateTime.now().toIso8601String(),
        'end_cash': endCash.toStringAsFixed(2),
        'is_opened': 0,
      },
      where: 'id = ? AND is_opened = 1',
      whereArgs: [shiftId],
    );

    await fetchShifts();
  }

  bool isOpenShift(int userId) {
    final shiftIndex =
        _items.indexWhere((shift) => shift.userId == userId && shift.isOpened);
    return shiftIndex >= 0;
  }
}
