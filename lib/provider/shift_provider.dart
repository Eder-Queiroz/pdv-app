import 'package:flutter/material.dart';
import 'package:pdv_app/data/dummy_data.dart';
import 'package:pdv_app/model/shift.dart';

class ShiftProvider with ChangeNotifier {
  final List<Shift> _items = [...shiftsData];

  List<Shift> get items {
    return [..._items].reversed.toList();
  }

  int get itemsCount => _items.length;

  int openShiftId(int userId) {
    final shiftIndex =
        _items.indexWhere((shift) => shift.userId == userId && shift.isOpened);
    return shiftIndex >= 0 ? _items[shiftIndex].id : 0;
  }

  void openShift({
    required double startCash,
    required int userId,
  }) {
    _items.add(
      Shift(
        id: _items.length + 1,
        userId: userId,
        startTime: DateTime.now(),
        startCash: startCash,
      ),
    );
    notifyListeners();
  }

  void endShift({
    required int shiftId,
    required double endCash,
  }) {
    final shiftIndex = _items.indexWhere((shift) => shift.id == shiftId);
    if (shiftIndex >= 0) {
      _items[shiftIndex] = Shift(
        id: _items[shiftIndex].id,
        userId: _items[shiftIndex].userId,
        startTime: _items[shiftIndex].startTime,
        endTime: DateTime.now(),
        startCash: _items[shiftIndex].startCash,
        endCash: endCash,
        isOpened: false,
      );
      notifyListeners();
    }
  }

  bool isOpenShift(int userId) {
    final shiftIndex =
        _items.indexWhere((shift) => shift.userId == userId && shift.isOpened);
    return shiftIndex >= 0;
  }
}
