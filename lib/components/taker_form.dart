import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/taker.dart';
import '../provider/taker_provider.dart';
import '../utils/colors_theme.dart';

class TakerForm extends StatefulWidget {
  final Taker? taker;
  const TakerForm({super.key, this.taker});

  @override
  _TakerFormState createState() => _TakerFormState();
}

class _TakerFormState extends State<TakerForm> {
  late Taker? _taker;

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  void _onSubmit(bool isUpdate, int? id) {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    try {
      final name = _formData['name']!;
      final phone = _formData['phone']!;

      isUpdate
          ? Provider.of<TakerProvider>(context, listen: false)
              .updateTaker(id!, name, phone)
          : Provider.of<TakerProvider>(context, listen: false)
              .createTaker(name, phone);
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
  }

  @override
  void initState() {
    super.initState();
    _taker = widget.taker;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: _taker?.name,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  onSaved: (name) => _formData['name'] = name ?? '',
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return 'Informe o valor inicial';
                    }

                    return null;
                  },
                ),
                const SizedBox(width: 10),
                TextFormField(
                  initialValue: _taker?.phone,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                  ),
                  onSaved: (phone) => _formData['phone'] = phone ?? '',
                  validator: (phone) {
                    if (phone == null || phone.isEmpty) {
                      return 'Informe o valor inicial';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsTheme.secondary500,
                      ),
                      onPressed: () {
                        _onSubmit(_taker != null, _taker?.id);
                      },
                      child: Text(
                        _taker != null ? 'Editar' : 'Cadastrar',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
