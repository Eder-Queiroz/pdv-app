enum Role {
  manager,
  employee,
}

class User {
  final String id;
  final String name;
  final String password;
  final Role role;

  User({
    required this.id,
    required this.name,
    required this.password,
    required this.role,
  });

  String get roleToString {
    switch (role) {
      case Role.manager:
        return 'gerente';
      case Role.employee:
        return 'funcionário';
    }
  }
}
