import '../model/shift.dart';
import '../model/user.dart';

final List<Shift> shiftsData = [
  Shift(
    id: 1,
    userId: 2,
    startTime: DateTime.now(),
    startCash: 100.00,
    endCash: 135.00,
    endTime: DateTime.now().add(Duration(days: 1)),
    isOpened: false,
  ),
];

final List<User> usersData = [
  User(
    id: 2,
    name: 'John Doe',
    role: 'manager',
  ),
  User(
    id: 3,
    name: 'teste',
    role: 'employee',
  ),
];
