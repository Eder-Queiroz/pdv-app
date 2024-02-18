import 'package:flutter/material.dart';
import 'package:pdv_app/utils/app_router.dart';

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

  @override
  Widget build(BuildContext context) {
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
          _createItem(Icons.exit_to_app, 'Sair', () {}, false),
        ],
      ),
    );
  }
}
