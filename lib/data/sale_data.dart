import '../model/sale.dart';
import './product.dart';

List<Sale> saleDate = [
  Sale(
    id: '1',
    product: productData[0],
    date: DateTime.now().subtract(const Duration(days: 1)),
    quantity: 2,
    paymentType: PaymentType.CASH,
  ),
  Sale(
    id: '2',
    product: productData[1],
    date: DateTime.now().subtract(const Duration(days: 2)),
    quantity: 4,
    paymentType: PaymentType.CREDIT,
  ),
];
