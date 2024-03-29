import 'package:flutter/material.dart';

import '../utils/app_router.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget _createItem(IconData icon, String label, Function() onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('PDV'),
            automaticallyImplyLeading: false,
          ),
          _createItem(
            Icons.access_time_filled,
            "Turnos",
            () => Navigator.of(context).pushReplacementNamed(AppRouter.home),
          ),
          const Divider(),
          _createItem(
            Icons.shopping_basket,
            "Produtos",
            () => Navigator.of(context).pushReplacementNamed(AppRouter.product),
          ),
          const Divider(),
          _createItem(
            Icons.point_of_sale,
            "Vendas",
            () => Navigator.of(context).pushReplacementNamed(AppRouter.sales),
          ),
          const Divider(),
          _createItem(
            Icons.person,
            "Usuários",
            () => Navigator.of(context).pushReplacementNamed(AppRouter.users),
          ),
        ],
      ),
    );
  }
}
