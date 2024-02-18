import 'package:flutter/material.dart';
import 'package:pdv_app/model/supplier.dart';

class SupplierItem extends StatelessWidget {
  final Supplier supplier;
  const SupplierItem({super.key, required this.supplier});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          supplier.name,
        ),
        subtitle: Text(supplier.getOneContact ?? 'Sem contato'),
        trailing: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {},
        ),
      ),
    );
  }
}
