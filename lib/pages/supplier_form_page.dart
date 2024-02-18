import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/supplier.dart';
import '../provider/supplier_provider.dart';
import '../utils/colors_theme.dart';

class SupplierFormPage extends StatefulWidget {
  const SupplierFormPage({super.key});

  @override
  _SupplierFormPageState createState() => _SupplierFormPageState();
}

class _SupplierFormPageState extends State<SupplierFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  _onSubmit(bool isEdit, int? id) {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    try {
      final name = _formData['name']!;
      final email = _formData['email'];
      final phone = _formData['phone'];

      isEdit
          ? Provider.of<SupplierProvider>(context, listen: false)
              .updateSupplier(id!, name, email, phone)
          : Provider.of<SupplierProvider>(context, listen: false)
              .addSupplier(name, email, phone);

      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final supplier = ModalRoute.of(context)?.settings.arguments as Supplier?;

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
                      initialValue: supplier?.name,
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
                            initialValue: supplier?.email,
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
                            initialValue: supplier?.phone,
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
                      onPressed: () =>
                          _onSubmit(supplier != null, supplier?.id),
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
