import 'package:flutter/material.dart';
import 'package:pdv_app/model/sale.dart';
import 'package:pdv_app/provider/cashier_provider.dart';
import 'package:provider/provider.dart';

import '../utils/colors_theme.dart';

class CashierItem extends StatelessWidget {
  final Sale sale;

  const CashierItem({super.key, required this.sale});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: ColorsTheme.primary500,
      child: ListTile(
        textColor: Colors.white,
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text(
            'x${sale.getQuantity.toString()}',
            style: const TextStyle(
              color: ColorsTheme.primary500,
            ),
          ),
        ),
        title: Text(sale.product!.name),
        subtitle: Text('R\$ ${sale.product!.price.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () => Provider.of<CashierProvider>(context, listen: false)
              .removeProduct(sale.productId),
          color: Colors.red,
        ),
      ),
    );
  }
}
