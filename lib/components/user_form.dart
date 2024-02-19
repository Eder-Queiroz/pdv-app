import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../provider/user_provider.dart';
import '../utils/colors_theme.dart';

class UserForm extends StatefulWidget {
  final User? user;
  const UserForm({
    super.key,
    this.user,
  });

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final List<Map<String, String>> roles = [
    {'value': 'manager', 'text': 'Gerente'},
    {'value': 'employee', 'text': 'Funcionario'},
  ];
  late User? _user;

  final _formKey = GlobalKey<FormState>();
  final _formData = <String, String>{};

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  void _onSubmit(bool isUpdate, int? id) {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    try {
      final name = _formData['name']!;
      final password = isUpdate ? '' : _formData['password']!;
      final role = _formData['role']!;

      isUpdate
          ? Provider.of<UserProvider>(context, listen: false)
              .updateUser(id!, name, role)
          : Provider.of<UserProvider>(context, listen: false)
              .createUser(name, password, role);
      Navigator.of(context).pop();
    } catch (error) {
      print(error);
    }
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: _user?.name,
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
                    ),
                    const SizedBox(width: 10),
                    if (_user == null)
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Senha',
                          ),
                          obscureText: true,
                          onSaved: (password) =>
                              _formData['password'] = password ?? '',
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Informe o valor inicial';
                            }

                            return null;
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: _user?.role != null
                      ? _user!.roleValue
                      : roles[1]['value'],
                  decoration: const InputDecoration(labelText: 'Cargo'),
                  items: roles.map((role) {
                    return DropdownMenuItem(
                      value: role['value'],
                      child: Text(role['text']!),
                    );
                  }).toList(),
                  validator: (role) {
                    if (role == null) {
                      return 'Informe um fornecedor válido!';
                    }

                    return null;
                  },
                  onChanged: (role) {
                    _formData['role'] = role.toString();
                  },
                  onSaved: (role) {
                    _formData['role'] = role.toString();
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
                        _onSubmit(_user != null, _user?.id);
                      },
                      child: Text(
                        _user != null ? 'Editar' : 'Cadastrar',
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
