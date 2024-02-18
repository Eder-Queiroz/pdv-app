import 'package:flutter/material.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            product.name,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
          leading: SizedBox(
            width: 80,
            height: 36,
            child: Card(
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  child: Text(
                    'R\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Image.network(
            product.urlImage ??
                "https://dpteurope-18521.kxcdn.com/emipro_theme_base/static/src/img/product_slider/product-not-found.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
