class Policy {
  final String name;
  final String details;

  const Policy({required this.name, required this.details});

  factory Policy.fromMap(Map<dynamic, dynamic> data) {
    return Policy(
        name: data['name'] as dynamic, details: data['details'] as dynamic);
  }

  Map<String, dynamic> toMap() => {"name": name, "details": details};

  factory Policy.fromJson(Map<dynamic, dynamic> data) {
    return Policy(
      name: data['name'] as dynamic,
      details: data['details'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {"name": name, "details": details};
}
