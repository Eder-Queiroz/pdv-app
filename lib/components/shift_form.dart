import 'package:flutter/material.dart';

import '../utils/colors_theme.dart';

class ShiftForm extends StatefulWidget {
  final void Function(double value) onSubmit;
  final bool isOpening;

  const ShiftForm({
    super.key,
    required this.onSubmit,
    this.isOpening = true,
  });

  @override
  _ShiftFormState createState() => _ShiftFormState();
}

class _ShiftFormState extends State<ShiftForm> {
  late final _isOpening;

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  @override
  void initState() {
    super.initState();
    _isOpening = widget.isOpening;
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;

    // print("isValid: $isValid");

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();
    // print("valor: ${_formData['value']}");

    widget.onSubmit(double.parse(_formData['value']!));
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
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: _isOpening ? 'Valor Inicial' : 'Valor Final',
                  ),
                  onSaved: (value) => _formData['value'] = value ?? '',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe o valor inicial';
                    }

                    final valueDouble = double.tryParse(value);

                    if (valueDouble == null || valueDouble <= 0) {
                      return 'Informe um valor válido';
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
                        _onSubmit();
                      },
                      child: Text(
                        _isOpening ? 'Abrir Turno' : 'Fechar Turno',
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
