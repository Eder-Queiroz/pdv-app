import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdv_app/components/sale_item.dart';
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
          itemBuilder: (ctx, index) => SaleItem(sale: _saleData[index]),
        ),
      ),
    );
  }
}
