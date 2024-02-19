import 'package:flutter/material.dart';
import 'package:pdv_app/components/user_form.dart';

import '../model/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  final bool isManager;
  final Function(User?) openShiftModal;

  const UserItem(
      {super.key,
      required this.user,
      required this.isManager,
      required this.openShiftModal});

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => openShiftModal(user),
              )
            : null,
      ),
    );
  }
}
