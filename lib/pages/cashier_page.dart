import 'package:flutter/material.dart';
import 'package:pdv_app/components/display.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:provider/provider.dart';

import '../components/cashier_item.dart';
import '../components/search_bar_code.dart';
import '../provider/cashier_provider.dart';
import '../utils/app_router.dart';
import '../utils/colors_theme.dart';

class CashierPage extends StatelessWidget {
  const CashierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CashierProvider>(context);
    final items = provider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Caixa'),
      ),
      drawer: const MainDrawer(router: AppRouter.cashier),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Display(value: provider.total),
              const SizedBox(
                height: 20,
              ),
              const SearchBarCode(),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: provider.itemsCount > 0
                    ? ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (ctx, i) => CashierItem(sale: items[i]),
                      )
                    : Center(
                        child: Text(
                          'Adicione um item!',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (provider.itemsCount > 0) {
                          Navigator.of(context)
                              .pushNamed(AppRouter.cashierPayment);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsTheme.secondary500,
                      ),
                      child: const Text(
                        "Pagamento",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
