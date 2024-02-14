import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/main_drawer.dart';
import '../model/sale.dart';
import '../data/sale_data.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Sale> _saleData = saleDate;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendas'),
      ),
      drawer: const MainDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.86,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: _saleData.length,
          itemBuilder: (ctx, index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: FittedBox(
                      child: Text(
                        'R\$${(_saleData[index].product.preco * _saleData[index].quantity).toStringAsFixed(2)}',
                      ),
                    ),
                  ),
                ),
                title: Text(_saleData[index].product.nome),
                subtitle: Text(
                  DateFormat('d/MM/y').format(_saleData[index].date),
                ),
                trailing: Text(_saleData[index].paymentTypeString),
              ),
            );
          },
        ),
      ),
    );
  }
}
