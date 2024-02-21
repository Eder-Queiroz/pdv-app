import 'package:flutter/material.dart';
import 'package:pdv_app/components/display.dart';
import 'package:provider/provider.dart';

import '../components/main_drawer.dart';
import '../provider/cashier_provider.dart';
import '../utils/app_router.dart';
import '../utils/colors_theme.dart';

class CashierPaymentPage extends StatelessWidget {
  const CashierPaymentPage({super.key});

  Widget _paymentCard(IconData icon, String title, String type, bool isActive,
      Function(String) changePaymentTyme, BuildContext context) {
    return Card(
      color: isActive ? ColorsTheme.secondary500 : ColorsTheme.primary500,
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: Theme.of(context).textTheme.titleLarge),
          onTap: () {
            changePaymentTyme(type);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CashierProvider>(context);

    void changePaymentType(String paymentType) {
      provider.paymentType = paymentType;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Display(value: provider.total),
              const SizedBox(
                height: 20,
              ),
              _paymentCard(
                Icons.money,
                'Dinheiro',
                'cash',
                provider.paymentType == 'cash',
                changePaymentType,
                context,
              ),
              _paymentCard(
                Icons.credit_card,
                "Cartão de crédito",
                'credit',
                provider.paymentType == 'credit',
                changePaymentType,
                context,
              ),
              _paymentCard(
                Icons.credit_score,
                "Cartão de débito",
                'debit',
                provider.paymentType == 'debit',
                changePaymentType,
                context,
              ),
              _paymentCard(
                Icons.pix,
                "PIX",
                'pix',
                provider.paymentType == 'pix',
                changePaymentType,
                context,
              ),
              _paymentCard(
                Icons.person,
                "Fiado",
                'borrowed',
                provider.paymentType == 'borrowed',
                changePaymentType,
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
