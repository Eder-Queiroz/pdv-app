import 'package:pdv_app/model/product.dart';

enum PaymentType {
  CASH,
  CREDIT,
  DEBIT,
  PIX,
  BILLET,
}

class Sale {
  final String id;
  final Product product;
  final int quantity;
  final PaymentType paymentType;
  final DateTime date;

  const Sale({
    required this.id,
    required this.product,
    required this.quantity,
    required this.paymentType,
    required this.date,
  });

  double get total {
    return product.preco * quantity;
  }

  String get paymentTypeString {
    switch (paymentType) {
      case PaymentType.CASH:
        return 'Dinheiro';
      case PaymentType.CREDIT:
        return 'Crédito';
      case PaymentType.DEBIT:
        return 'Débito';
      case PaymentType.PIX:
        return 'Pix';
      case PaymentType.BILLET:
        return 'Fiado';
      default:
        return 'Desconhecido';
    }
  }
}
