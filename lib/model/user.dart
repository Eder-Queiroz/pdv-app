enum Role {
  manager,
  employee,
}

class User {
  int? id;
  String name;
  late Role role;

  User({
    this.id,
    required this.name,
    required String role,
  }) {
    setRole(role);
  }

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

  void setRole(String role) {
    switch (role) {
      case 'admin':
        this.role = Role.manager;
        break;
      case 'employee':
        this.role = Role.employee;
        break;
      default:
        this.role = Role.employee;
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
