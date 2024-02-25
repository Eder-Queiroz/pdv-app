import 'package:flutter/material.dart';
import 'package:pdv_app/components/display.dart';
import 'package:pdv_app/components/select_taker_form.dart';
import 'package:provider/provider.dart';

import '../model/taker.dart';
import '../provider/cashier_provider.dart';
import '../provider/order_provider.dart';
import '../provider/shift_provider.dart';
import '../provider/user_provider.dart';
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
    final userId = Provider.of<UserProvider>(context).user.id;
    final shiftId = Provider.of<ShiftProvider>(context).openShiftId(userId!);

    void onChangeTaker(Taker taker) {
      provider.setTakerSelected = taker;
    }

    void changePaymentType(String paymentType) {
      provider.paymentType = paymentType;
    }

    void onSell() {
      provider.sell(provider.items, shiftId!);

      Provider.of<OrderProvider>(context, listen: false).loadOrders();

      Navigator.of(context).pop();
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
            crossAxisAlignment: CrossAxisAlignment.end,
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
              const SizedBox(
                height: 20,
              ),
              if (provider.paymentType == 'borrowed')
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: SelectTakerForm(onChange: onChangeTaker),
                ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: onSell,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsTheme.secondary500,
                  ),
                  child: const Text(
                    "Finalizar",
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
