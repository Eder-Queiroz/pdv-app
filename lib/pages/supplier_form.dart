import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/supplier_provider.dart';
import '../utils/colors_theme.dart';

class SupplierForm extends StatefulWidget {
  const SupplierForm({super.key});

  @override
  _SupplierFormState createState() => _SupplierFormState();
}

class _SupplierFormState extends State<SupplierForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    try {
      final name = _formData['name']!;
      final email = _formData['email'];
      final phone = _formData['phone'];

      Provider.of<SupplierProvider>(context, listen: false)
          .addSupplier(name, email, phone);
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Fornecedor'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nome é obrigatório';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _formData['name'] = value!;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            onSaved: (email) {
                              _formData['email'] = email ?? '';
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Telefone'),
                            onSaved: (phone) {
                              _formData['phone'] = phone ?? '';
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsTheme.secondary500,
                      ),
                      onPressed: _onSubmit,
                      child: const Text(
                        'Salvar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
