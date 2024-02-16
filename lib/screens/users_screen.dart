import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pdv_app/components/user_item.dart';
import 'package:pdv_app/functions/open_modal.dart';
import '../components/main_drawer.dart';
import '../components/user_create_form.dart';
import '../model/user.dart';

class UsersScreen extends StatefulWidget {
  final List<User> usersData;
  const UsersScreen({super.key, required this.usersData});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late List<User> users;

  @override
  void initState() {
    super.initState();
    users = widget.usersData;
  }

  @override
  Widget build(BuildContext context) {
    void submitForm(String name, String password, Role role) {
      setState(() {
        users.add(
          User(
            id: Random().nextDouble().toString(),
            name: name,
            password: password,
            role: role,
          ),
        );
      });
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
      ),
      drawer: const MainDrawer(),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (ctx, i) => UserItem(user: users[i]),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          OpenModal.openModal(
            context,
            UserCreateForm(
              submitForm: submitForm,
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}
