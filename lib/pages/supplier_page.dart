import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:pdv_app/components/supplier_item.dart';
import 'package:pdv_app/provider/supplier_provider.dart';
import 'package:pdv_app/utils/app_router.dart';
import 'package:provider/provider.dart';

class SupplierPage extends StatelessWidget {
  const SupplierPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supplierProvider = Provider.of<SupplierProvider>(context);
    final supplierItems = supplierProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Fornecedores'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouter.supplierForm);
            },
          ),
        ],
      ),
      drawer: const MainDrawer(router: AppRouter.supplier),
      body: Container(
        child: supplierProvider.itemsCount > 0
            ? ListView.builder(
                itemCount: supplierProvider.itemsCount,
                itemBuilder: (ctx, i) =>
                    SupplierItem(supplier: supplierItems[i]),
                padding: const EdgeInsets.all(8),
              )
            : Center(
                child: Text(
                  'Nenhum fornecedor cadastrado!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
      ),
    );
  }
}
