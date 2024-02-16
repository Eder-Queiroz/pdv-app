import 'package:flutter/material.dart';

import '../model/user.dart';

class UserCreateForm extends StatefulWidget {
  final Function(String, String, Role) submitForm;
  const UserCreateForm({super.key, required this.submitForm});

  @override
  _UserCreateFormState createState() => _UserCreateFormState();
}

class _UserCreateFormState extends State<UserCreateForm> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  Role _selectedRole = Role.manager;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      width: double.infinity,
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: "Nome",
                        ),
                        controller: _nameController,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Senha",
                        ),
                        controller: _passwordController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cargo",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<Role>(
                          isExpanded: true,
                          alignment: Alignment.center,
                          menuMaxHeight:
                              MediaQuery.of(context).size.height * 0.3,
                          elevation: 4,
                          value: _selectedRole,
                          items: Role.values.map<DropdownMenuItem<Role>>(
                            (Role role) {
                              return DropdownMenuItem<Role>(
                                value: role,
                                child: Text(
                                  role.name == "manager"
                                      ? "Gerente"
                                      : "Funcionário",
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (Role? newValue) {
                            setState(
                              () {
                                _selectedRole = newValue!;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        widget.submitForm(
                          _nameController.text,
                          _passwordController.text,
                          _selectedRole,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "Salvar",
                        style: TextStyle(color: Colors.white),
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
