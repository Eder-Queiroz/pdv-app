import 'package:flutter/material.dart';
import 'package:pdv_app/provider/shift_provider.dart';
import 'package:pdv_app/provider/user_provider.dart';
import 'package:pdv_app/utils/app_router.dart';
import 'package:provider/provider.dart';

import '../utils/colors_theme.dart';

class MainDrawer extends StatelessWidget {
  final String router;
  const MainDrawer({super.key, required this.router});

  Widget _createItem(
      IconData icon, String label, Function() onTap, isActivated) {
    return isActivated
        ? Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Card(
              color: ColorsTheme.secondary500,
              elevation: 5,
              child: ListTile(
                leading: Icon(icon, color: Colors.white),
                title: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: onTap,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: ListTile(
              leading: Icon(icon, color: Colors.white),
              title: Text(
                label,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onTap: onTap,
            ),
          );
  }

  Widget _disableItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Card(
        color: Colors.black26,
        elevation: 5,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                leading: Icon(icon, color: Colors.white),
                title: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).user.id;
    final isOpenShift =
        Provider.of<ShiftProvider>(context).isOpenShift(userId!);

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: Text(
                'PDV',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          isOpenShift
              ? _createItem(
                  Icons.point_of_sale,
                  'Caixa',
                  () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouter.cashier);
                  },
                  router == AppRouter.home,
                )
              : _disableItem(
                  Icons.point_of_sale,
                  'Caixa',
                ),
          _createItem(
            Icons.timer,
            'Turnos',
            () {
              Navigator.of(context).pushReplacementNamed(AppRouter.shift);
            },
            router == AppRouter.shift,
          ),
          _createItem(
            Icons.local_shipping,
            "Fornecedores",
            () {
              Navigator.of(context).pushReplacementNamed(AppRouter.supplier);
            },
            router == AppRouter.supplier,
          ),
          _createItem(
            Icons.shopping_cart,
            "Produtos",
            () {
              Navigator.of(context).pushReplacementNamed(AppRouter.product);
            },
            router == AppRouter.product,
          ),
          _createItem(
            Icons.request_quote_outlined,
            "Vendas",
            () {
              Navigator.of(context).pushReplacementNamed(AppRouter.sale);
            },
            router == AppRouter.sale,
          ),
          _createItem(
            Icons.people,
            "Usuários",
            () {
              Navigator.of(context).pushReplacementNamed(AppRouter.user);
            },
            router == AppRouter.user,
          ),
          _createItem(
            Icons.person,
            "Tomadores",
            () {
              Navigator.of(context).pushReplacementNamed(AppRouter.taker);
            },
            router == AppRouter.taker,
          ),
          _createItem(Icons.exit_to_app, 'Sair', () {}, false),
        ],
      ),
    );
  }
}
