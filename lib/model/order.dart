import 'package:pdv_app/model/sale.dart';

enum PaymentType { cash, credit, debit, pix, borrowed }

class Order {
  final int? id;
  final int shiftId;
  final int? takerId;
  late PaymentType paymentType;
  final DateTime orderTime;
  final List<Sale>? sales;

  Order({
    this.id,
    required this.shiftId,
    this.takerId,
    required String paymentType,
    required this.orderTime,
    this.sales,
  }) {
    setRole = paymentType;
  }

  String get paymentTypeString {
    switch (paymentType) {
      case PaymentType.cash:
        return 'Dinheiro';
      case PaymentType.credit:
        return 'Crédito';
      case PaymentType.debit:
        return 'Débito';
      case PaymentType.pix:
        return 'Pix';
      case PaymentType.borrowed:
        return 'Fiado';
    }
  }

  set setRole(String paymentType) {
    switch (paymentType) {
      case 'cash':
        this.paymentType = PaymentType.cash;
        break;
      case 'credit':
        this.paymentType = PaymentType.credit;
        break;
      case 'debit':
        this.paymentType = PaymentType.debit;
        break;
      case 'pix':
        this.paymentType = PaymentType.pix;
        break;
      case 'borrowed':
        this.paymentType = PaymentType.borrowed;
        break;
    }
  }
}
