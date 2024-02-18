class Supplier {
  final int? id;
  final String name;
  final String? email;
  final String? phone;

  Supplier({
    this.id,
    required this.name,
    this.email,
    this.phone,
  });

  String? get getOneContact {
    if (phone != null) {
      return phone;
    } else if (email != null) {
      return email;
    }
    return null;
  }
}
