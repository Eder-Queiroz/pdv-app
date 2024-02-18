import 'package:flutter/cupertino.dart';
import 'package:pdv_app/data/dummy_data.dart';
import 'package:pdv_app/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  late Database db;

  final List<User> _items = [...usersData];
  User _user = usersData[0];

  User get user => _user;

  List<User> get items => [..._items];

  Future<bool> login(Map<String, Object> userData) async {
    db = await DbUtil.instance.database;

    final user = await db.query(
      'users',
      where: 'name = ? and password = ?',
      whereArgs: [userData['name'], userData['password']],
    );

    if (user.isNotEmpty) {
      setUser(User(
        id: user[0]['id'] as int,
        name: user[0]['name'] as String,
        role: user[0]['role'] as String,
      ));
      return true;
    }

    return false;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void addUser() async {
    db = await DbUtil.instance.database;

    await db.insert(
      'users',
      {
        'name': 'admin',
        'password': 'admin',
        'role': 'admin',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
