import 'package:pdv_app/model/user.dart';

final List<User> usersData = [
  User(
    id: '1',
    name: 'admin',
    password: 'admin',
    role: Role.manager,
  ),
  User(
    id: '2',
    name: 'user',
    password: 'user',
    role: Role.employee,
  ),
];
