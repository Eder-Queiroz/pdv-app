import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pdv_app/components/shift_item.dart';
import 'package:pdv_app/provider/shift_provider.dart';
import 'package:pdv_app/provider/user_provider.dart';
import 'package:pdv_app/utils/colors_theme.dart';
import 'package:provider/provider.dart';

import '../components/shift_form.dart';

class ShiftPage extends StatelessWidget {
  const ShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftProvider shiftProvider = Provider.of(context);
    final UserProvider userProvider = Provider.of(context);
    final userId = userProvider.user.id;
    final items = shiftProvider.items;
    final isShiftOpen = shiftProvider.isOpenShift(userId);

    void _onSubmit(double value) {
      if (isShiftOpen) {
        shiftProvider.endShift(
            shiftId: shiftProvider.openShiftId(userId), endCash: value);
      } else {
        shiftProvider.openShift(startCash: value, userId: userId);
      }
      Navigator.of(context).pop();
    }

    void _openShiftModal() {
      showModalBottomSheet(
        context: context,
        builder: (_) {
          return ShiftForm(
            onSubmit: _onSubmit,
            isOpening: !isShiftOpen,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
      ),
      backgroundColor: ColorsTheme.primary800,
      body: Container(
        child: shiftProvider.itemsCount > 0
            ? ListView.builder(
                itemCount: shiftProvider.itemsCount,
                itemBuilder: (ctx, i) => ShiftItem(
                  shift: items[i],
                ),
              )
            : const Center(
                child: Text('Nenhum turno cadastrado!'),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openShiftModal(),
        elevation: 5,
        backgroundColor:
            !isShiftOpen ? Theme.of(context).colorScheme.secondary : Colors.red,
        child: Icon(Icons.add,
            color:
                !isShiftOpen ? Theme.of(context).primaryColor : Colors.white),
      ),
    );
  }
}
