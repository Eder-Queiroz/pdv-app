import 'package:flutter/material.dart';
import 'package:pdv_app/components/product_form.dart';
import 'package:pdv_app/model/product.dart';
import '../functions/open_modal.dart';
import '../model/category.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function(String id, String name, String barcode, int stockUnit,
  double price, double costPrice, Category category) onEditProduct;
  const ProductItem({super.key, required this.product,required this.onEditProduct});

  void _onSubmit(String name, String barcode, int stockUnit,
      double price, double costPrice, Category category){
      onEditProduct(product.id,name,barcode,stockUnit,price,costPrice,category);
  }

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
          onPressed: () => OpenModal.openModal(
            context,
            ProductForm(onSubmit: _onSubmit,isEditing: true,product: product),
          ),
        ),
      ),
    );
    ;
  }
}
