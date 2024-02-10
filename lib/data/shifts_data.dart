import '../model/shift.dart';

List<Shift> shiftsData = [
  Shift(
    id: '1',
    nome: 'Eder',
    inicio: DateTime.now().subtract(const Duration(days: 1)),
    fim: DateTime.now(),
    saldo: 200,
    reforco: 50,
    desconto: 20,
    status: false,
  ),
  Shift(
    id: '2',
    nome: 'Eder',
    inicio: DateTime.now().subtract(const Duration(days: 2)),
    fim: DateTime.now().subtract(const Duration(days: 1)),
    saldo: 200,
    reforco: 50,
    desconto: 20,
    status: false,
  ),
];
