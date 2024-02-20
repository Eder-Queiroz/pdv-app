import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';

import '../utils/app_router.dart';

class CashierPage extends StatelessWidget {
  const CashierPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caixa'),
      ),
      drawer: const MainDrawer(router: AppRouter.cashier),
      body: const Center(
        child: Text('Caixa'),
      ),
    );
  }
}
