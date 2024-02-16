import '../model/shift.dart';
import '../model/user.dart';

final List<Shift> shiftsData = [
  Shift(
    id: 1,
    userId: 1,
    startTime: DateTime.now(),
    startCash: 100.00,
    endCash: 135.00,
    endTime: DateTime.now().add(Duration(days: 1)),
    isOpened: false,
  ),
  Shift(
    id: 2,
    userId: 1,
    startTime: DateTime.now(),
    startCash: 135.00,
  ),
];

final List<User> usersData = [
  User(
    id: 1,
    name: 'John Doe',
    role: Role.employee,
  ),
];
