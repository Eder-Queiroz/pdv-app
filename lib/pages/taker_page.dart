import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:pdv_app/components/taker_form.dart';
import 'package:pdv_app/components/taker_item.dart';
import 'package:pdv_app/utils/app_router.dart';
import 'package:provider/provider.dart';

import '../model/taker.dart';
import '../provider/taker_provider.dart';

class TakerPage extends StatelessWidget {
  const TakerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TakerProvider>(context);
    final takers = provider.items;

    void openShiftModal(Taker? taker) {
      showModalBottomSheet(
        context: context,
        builder: (_) => TakerForm(taker: taker),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomadores'),
      ),
      drawer: const MainDrawer(router: AppRouter.taker),
      body: Container(
        child: provider.itemsCount > 0
            ? ListView.builder(
                itemCount: provider.itemsCount,
                itemBuilder: (ctx, i) => TakerItem(
                  taker: takers[i],
                  openShiftModal: openShiftModal,
                ),
                padding: const EdgeInsets.all(8),
              )
            : Center(
                child: Text(
                  'Nenhum tomador cadastrado!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => openShiftModal(null),
        elevation: 5,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
