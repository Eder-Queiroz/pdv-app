import 'package:flutter/material.dart';
import 'package:pdv_app/provider/cashier_provider.dart';
import 'package:provider/provider.dart';

import '../utils/colors_theme.dart';

class SearchBarCode extends StatefulWidget {
  const SearchBarCode({super.key});

  @override
  State<SearchBarCode> createState() => _SearchBarCodeState();
}

class _SearchBarCodeState extends State<SearchBarCode> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};

  _onSubmit() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    final barCode = _formData['barCode'] as String;

    Provider.of<CashierProvider>(context, listen: false).addProduct(barCode);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Informe um código de barras';
                }

                if (value.length < 13) {
                  return 'Código de barras inválido';
                }

                return null;
              },
              onSaved: (barCode) {
                _formData['barCode'] = barCode ?? '';
              },
              decoration: const InputDecoration(
                labelText: 'Cod. Barras',
                border: OutlineInputBorder(),
                fillColor: Colors.white,
                filled: true,
              ),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsTheme.secondary500),
              elevation: MaterialStateProperty.all(5),
              minimumSize: MaterialStateProperty.all(
                const Size(50, 50),
              ),
            ),
            onPressed: _onSubmit,
            icon: const Icon(Icons.search),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
