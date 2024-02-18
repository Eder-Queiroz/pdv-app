import 'package:flutter/material.dart';
import 'package:pdv_app/components/main_drawer.dart';
import 'package:pdv_app/components/product_grid.dart';
import 'package:pdv_app/utils/app_router.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  Widget _actionButton({
    required IconData icon,
    required String label,
    required BuildContext context,
    required Function() onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: const Size(180, 40),
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        label,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      drawer: const MainDrawer(
        router: AppRouter.product,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _actionButton(
                icon: Icons.add,
                label: 'Adicionar Produto',
                context: context,
                onPressed: () => {
                  Navigator.of(context).pushNamed(AppRouter.productForm),
                },
              ),
              _actionButton(
                  icon: Icons.category_outlined,
                  label: 'Adicionar Categoria',
                  context: context,
                  onPressed: () => {})
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Expanded(
            child: ProductGrid(),
          ),
        ],
      ),
    );
  }
}
