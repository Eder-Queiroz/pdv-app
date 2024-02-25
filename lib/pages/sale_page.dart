import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:pdv_app/components/order.dart';
import 'package:pdv_app/utils/app_router.dart';
import 'package:provider/provider.dart';

import '../provider/order_provider.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final orders = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendas'),
      ),
      drawer: const MainDrawer(router: AppRouter.sale),
      body: Container(
        child: provider.itemsCount > 0
            ? ListView.builder(
                itemCount: provider.itemsCount,
                itemBuilder: (ctx, i) => OrderWidget(order: orders[i]),
              )
            : Center(
                child: Text(
                  'Nenhuma venda cadastrada!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
      ),
    );
  }
}
