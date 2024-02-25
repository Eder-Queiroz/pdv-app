import 'package:flutter/material.dart';
import 'package:pdv_app/utils/colors_theme.dart';
import 'package:provider/provider.dart';

import '../model/taker.dart';
import '../provider/taker_provider.dart';

class SelectTakerForm extends StatefulWidget {
  final Function(Taker taker) onChange;
  const SelectTakerForm({super.key, required this.onChange});

  @override
  State<SelectTakerForm> createState() => _SelectTakerFormState();
}

class _SelectTakerFormState extends State<SelectTakerForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TakerProvider>(context);
    final takers = provider.items;

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField(
            selectedItemBuilder: (context) {
              return takers.map((taker) {
                return Text(
                  taker.name,
                  style: const TextStyle(color: Colors.white),
                );
              }).toList();
            },
            decoration: const InputDecoration(
              labelText: 'Fornecedor',
              border: OutlineInputBorder(),
              labelStyle: TextStyle(color: Colors.white),
            ),
            borderRadius: BorderRadius.circular(10),
            style: const TextStyle(color: Colors.white),
            dropdownColor: ColorsTheme.primary500,
            key: const Key('taker'),
            items: takers.map((taker) {
              return DropdownMenuItem(
                value: taker.id,
                child: Text(taker.name),
              );
            }).toList(),
            validator: (takerId) {
              if (takerId == null) {
                return 'Informe um tomador válido!';
              }

              return null;
            },
            onChanged: (takerId) {
              widget.onChange(provider.findById(takerId!));
            },
          ),
        ],
      ),
    );
  }
}
