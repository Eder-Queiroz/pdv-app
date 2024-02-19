import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:pdv_app/components/user_form.dart';
import 'package:pdv_app/components/user_item.dart';
import 'package:pdv_app/model/user.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../utils/app_router.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final userItems = provider.items;

    void openShiftModal(User? user) {
      showModalBottomSheet(
        context: context,
        builder: (_) => UserForm(user: user),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários'),
      ),
      drawer: const MainDrawer(router: AppRouter.user),
      body: Container(
        child: provider.itemsCount > 0
            ? ListView.builder(
                itemCount: provider.itemsCount,
                itemBuilder: (ctx, i) => UserItem(
                  user: userItems[i],
                  isManager: provider.isManager,
                  openShiftModal: openShiftModal,
                ),
                padding: const EdgeInsets.all(8),
              )
            : Center(
                child: Text(
                  'Nenhum fornecedor cadastrado!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: provider.isManager
          ? FloatingActionButton(
              onPressed: () => openShiftModal(null),
              elevation: 5,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            )
          : null,
    );
  }
}
