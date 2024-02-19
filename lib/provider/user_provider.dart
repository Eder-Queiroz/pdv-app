import 'package:flutter/cupertino.dart';
import 'package:pdv_app/utils/db_util.dart';
import 'package:sqflite/sqflite.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  late Database db;

  final List<User> _items = [];
  late User _user;

  UserProvider() {
    loadUsers();
  }

  User get user => _user;

  List<User> get items => [..._items];

  int get itemsCount => _items.length;

  bool get isManager => _user.role == Role.manager;

  Future<void> loadUsers() async {
    db = await DbUtil.instance.database;

    final users = await db.query('users');

    _items.clear();
    _items.addAll(
      users.map(
        (user) => User(
          id: int.parse(user['id'].toString()),
          name: user['name'] as String,
          role: user['role'] as String,
        ),
      ),
    );

    notifyListeners();
  }

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

  Future<void> createUser(String name, String password, String role) async {
    db = await DbUtil.instance.database;

    await db.insert(
      'users',
      {
        'name': name,
        'password': password,
        'role': role,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    loadUsers();
  }

  Future<void> updateUser(int id, String name, String role) async {
    db = await DbUtil.instance.database;

    await db.update(
      'users',
      {
        'name': name,
        'role': role,
      },
      where: 'id = ?',
      whereArgs: [id],
    );

    loadUsers();
  }
}
