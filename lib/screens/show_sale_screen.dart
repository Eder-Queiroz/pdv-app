import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/sale.dart';

class ShowSaleScreen extends StatelessWidget {
  const ShowSaleScreen({super.key});

  Widget _createInfo(IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Sale sale = ModalRoute.of(context)!.settings.arguments as Sale;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Venda'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _createInfo(Icons.shopping_bag, sale.product.nome),
                _createInfo(Icons.attach_money,
                    'R\$ ${sale.product.preco.toStringAsFixed(2)}'),
                _createInfo(
                    Icons.money, 'R\$ ${sale.total.toStringAsFixed(2)}'),
                _createInfo(
                  Icons.access_time,
                  DateFormat("dd/MM/y").format(sale.date),
                ),
                _createInfo(
                    Icons.production_quantity_limits, sale.quantity.toString()),
                _createInfo(Icons.payment, sale.paymentTypeString),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
