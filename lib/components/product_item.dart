import 'package:flutter/material.dart';
import 'package:pdv_app/model/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text(
                'R\$ ${product.preco.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(product.nome),
        subtitle: Text(product.cod_barras),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () => null,
        ),
      ),
    );
    ;
  }
}
