import 'package:flutter/material.dart';
import 'package:pdv_app/components/user_form.dart';

import '../model/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  final bool isManager;

  const UserItem({super.key, required this.user, required this.isManager});

  @override
  Widget build(BuildContext context) {
    void openShiftModal() {
      showModalBottomSheet(
        context: context,
        builder: (_) => UserForm(user: user),
      );
    }

    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          user.name,
        ),
        subtitle: Text(user.roleString),
        trailing: isManager
            ? IconButton(
                icon: const Icon(Icons.edit),
                onPressed: openShiftModal,
              )
            : null,
      ),
    );
  }
}
