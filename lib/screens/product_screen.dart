import 'package:flutter/material.dart';
import 'package:pdv_app/components/category_create_form.dart';
import 'package:pdv_app/components/main_drawer.dart';
import '../components/product_item.dart';
import '../data/product.dart';
import '../functions/open_modal.dart';
import '../components/product_create_form.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  _submitCategoryForm(String form){

  }
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
    final _products = prodcutData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _actionButton(
                  icon: Icons.add,
                  label: 'Adicionar Produto',
                  context: context,
                  onPressed: () => OpenModal.openModal(
                    context,
                    const ProductCreateForm(),
                  ),
                ),
                _actionButton(
                  icon: Icons.category_outlined,
                  label: 'Adicionar Categoria',
                  context: context,
                  onPressed: () => OpenModal.openModal(
                    context,
                    CategoryCreateForm(submitForm:_submitCategoryForm),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: _products.length,
                itemBuilder: (ctx, index) {
                  return ProductItem(product: _products[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
