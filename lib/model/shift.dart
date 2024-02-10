class Shift {
  final String id;
  final String nome;
  final DateTime inicio;
  final DateTime? fim;
  final double saldo;
  final double? reforco;
  final double? desconto;
  final bool status;

  const Shift({
    required this.id,
    required this.nome,
    required this.inicio,
    this.fim,
    required this.saldo,
    this.reforco,
    this.desconto,
    required this.status,
  });
}
