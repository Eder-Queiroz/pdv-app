enum Role {
  manager,
  employee,
}

class User {
  int id;
  String name;
  Role role;

  User({
    required this.id,
    required this.name,
    required this.role,
  });

  String get roleString {
    switch (role) {
      case Role.manager:
        return 'Gerente';
      case Role.employee:
        return 'Funcionário';
      default:
        return 'Funcionário';
    }
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      role: json['role'],
    );
  }
}
