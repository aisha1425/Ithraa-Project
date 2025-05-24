class Transport {
  final int? id;
  final String name;
  final String type;
  final String description;
  final String cost;
  final String distance;
  final String availability;
  final String userEmail;

  const Transport(
      {this.id,
      required this.name,
      required this.type,
      required this.description,
      required this.cost,
      required this.distance,
      required this.availability,
      required this.userEmail});

  factory Transport.fromMap(Map<dynamic, dynamic> data) {
    return Transport(
        id: data['id'] as dynamic,
        name: data['name'] as dynamic,
        type: data['type'] as dynamic,
        description: data['description'] as dynamic,
        cost: data['cost'] as dynamic,
        distance: data['distance'] as dynamic,
        availability: data['availability'] as dynamic,
        userEmail: data['userEmail'] as dynamic);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "description": description,
        "cost": cost,
        "distance": distance,
        "availability": availability,
        "userEmail": userEmail
      };

  factory Transport.fromJson(Map<dynamic, dynamic> data) {
    return Transport(
        id: data['id'] as dynamic,
        name: data['name'] as dynamic,
        type: data['type'] as dynamic,
        description: data['description'] as dynamic,
        cost: data['cost'] as dynamic,
        distance: data['distance'] as dynamic,
        availability: data['availability'] as dynamic,
        userEmail: data['userEmail'] as dynamic);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "description": description,
        "cost": cost,
        "distance": distance,
        "availability": availability,
        "userEmail": userEmail
      };
}
