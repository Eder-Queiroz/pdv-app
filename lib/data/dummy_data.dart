import '../model/shift.dart';
import '../model/supplier.dart';
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

final List<Supplier> supplierData = [
  Supplier(
    id: 1,
    name: 'Supplier 1',
    email: 'teste@mail.com',
    phone: '(34) 99999-9999',
  ),
  Supplier(
    id: 2,
    name: 'Supplier 2',
    email: 'teste2@gmail.com',
    phone: '(34) 99999-9999',
  ),
  Supplier(
    id: 2,
    name: 'Supplier 3',
    email: 'teste3@gmail.com',
  ),
];
