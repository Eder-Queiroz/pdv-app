import 'package:flutter/material.dart';
import 'package:pdv_app/components/shift_item.dart';
import 'package:pdv_app/provider/shift_provider.dart';
import 'package:provider/provider.dart';

class ShiftPage extends StatelessWidget {
  const ShiftPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ShiftProvider shiftProvider = Provider.of(context);
    final items = shiftProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Turnos'),
      ),
      body: Expanded(
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
    );
  }
}
