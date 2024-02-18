import 'package:flutter/material.dart';
import 'package:pdv_app/components/product_item.dart';
import 'package:pdv_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

import '../model/product.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    final List<Product> productsItem = provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: provider.itemsCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) =>
          ProductItem(product: productsItem[index]),
    );
  }
}
