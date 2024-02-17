import 'package:flutter/cupertino.dart';
import 'package:pdv_app/data/dummy_data.dart';

import '../model/user.dart';

class UserProvider with ChangeNotifier {
  final List<User> _items = [...usersData];
  User _user = usersData[0];

  User get user => _user;

  List<User> get items => [..._items];

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}
