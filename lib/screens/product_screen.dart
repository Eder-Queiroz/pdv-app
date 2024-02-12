import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdv_app/components/category_create_form.dart';
import 'package:pdv_app/components/main_drawer.dart';
import '../components/product_item.dart';
import '../functions/open_modal.dart';
import '../components/product_create_form.dart';
import '../model/category.dart';
import '../model/product.dart';

class ProductScreen extends StatefulWidget {
  final List<Product> prodcutsData;
  const ProductScreen({super.key, required this.prodcutsData});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late List<Product> _productsData;

  @override
  void initState() {
    super.initState();
    _productsData = widget.prodcutsData;
  }

  void _onCreateProduct(String name, String barcode, int stockUnit,
      double price, double costPrice, Category category) {
    final newProduct = Product(
      id: Random().nextDouble().toString(),
      nome: name,
      cod_barras: barcode,
      unidade: stockUnit,
      preco: price,
      preco_custo: costPrice,
      categoria: category,
    );

    _productsData.add(newProduct);

    Navigator.of(context).pop();
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
                    ProductCreateForm(onSubmit: _onCreateProduct),
                  ),
                ),
                _actionButton(
                  icon: Icons.category_outlined,
                  label: 'Adicionar Categoria',
                  context: context,
                  onPressed: () => OpenModal.openModal(
                    context,
                    const CategoryCreateForm(),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                itemCount: _productsData.length,
                itemBuilder: (ctx, index) {
                  return ProductItem(product: _productsData[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
