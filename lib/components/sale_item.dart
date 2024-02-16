import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdv_app/utils/app_router.dart';

import '../model/sale.dart';

class SaleItem extends StatelessWidget {
  final Sale sale;

  const SaleItem({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                'R\$${(sale.product.preco * sale.quantity).toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(sale.product.nome),
        subtitle: Text(
          DateFormat('d/MM/y').format(sale.date),
        ),
        trailing: Text(sale.paymentTypeString),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRouter.showSale,
            arguments: sale,
          );
        },
      ),
    );
  }
}
