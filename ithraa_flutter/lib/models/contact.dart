class Contact {
  final String name;
  final String phone;
  final String email;

  const Contact({required this.name, required this.phone, required this.email});

  factory Contact.fromMap(Map<dynamic, dynamic> data) {
    return Contact(
        name: data['name'] as dynamic,
        phone: data['phone'] as dynamic,
        email: data['email'] as dynamic);
  }

  Map<String, dynamic> toMap() =>
      {"name": name, "phone": phone, "email": email};

  factory Contact.fromJson(Map<dynamic, dynamic> data) {
    return Contact(
      name: data['name'] as dynamic,
      phone: data['phone'] as dynamic,
      email: data['email'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() =>
      {"name": name, "phone": phone, "email": email};
}
