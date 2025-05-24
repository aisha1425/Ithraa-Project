class Accomindation {
  final int id;
  final String name;
  final String? type;
  final String? description;
  final String? call;
  final String? price;
  final String? distance;

  final String? kitchen;
  final String? laundary;
  final String? parking;
  final String? bedrooms;
  final String? bathrooms;
  final String? internet;
  final String? image;
  final String userEmail;

  const Accomindation(
      {required this.id,
      required this.name,
      this.type,
      this.description,
      this.call,
      this.price,
      this.distance,
      this.kitchen,
      this.laundary,
      this.parking,
      this.bedrooms,
      this.bathrooms,
      this.internet,
      this.image,
      required this.userEmail});

  factory Accomindation.fromMap(Map<dynamic, dynamic> data) {
    return Accomindation(
      id: data['id'] as dynamic,
      name: data['name'] as dynamic,
      type: data['type'] as dynamic,
      description: data['description'] as dynamic,
      call: data['call'] as dynamic,
      price: data['price'] as dynamic,
      distance: data['distance'] as dynamic,
      laundary: data['laundary'] as dynamic,
      parking: data['parking'] as dynamic,
      bedrooms: data['bedrooms'] as dynamic,
      bathrooms: data['bathrooms'] as dynamic,
      internet: data['internet'] as dynamic,
      kitchen: data['kitchen'] as dynamic,
      image: data['image'] as dynamic,
      userEmail: data['userEmail'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "type": type,
        "description": description,
        "call": call,
        "price": price,
        "distance": distance,
        "laundary": laundary,
        "parking": parking,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "internet": internet,
        "kitchen": kitchen,
        "image": image,
        "userEmail": userEmail,
      };

  factory Accomindation.fromJson(Map<dynamic, dynamic> data) {
    return Accomindation(
      id: data['id'] as dynamic,
      name: data['name'] as dynamic,
      type: data['type'] as dynamic,
      description: data['description'] as dynamic,
      call: data['call'] as dynamic,
      price: data['price'] as dynamic,
      distance: data['distance'] as dynamic,
      laundary: data['laundary'] as dynamic,
      parking: data['parking'] as dynamic,
      bedrooms: data['bedrooms'] as dynamic,
      bathrooms: data['bathrooms'] as dynamic,
      internet: data['internet'] as dynamic,
      kitchen: data['kitchen'] as dynamic,
      image: data['image'] as dynamic,
      userEmail: data['userEmail'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "description": description,
        "call": call,
        "price": price,
        "distance": distance,
        "laundary": laundary,
        "parking": parking,
        "bedrooms": bedrooms,
        "bathrooms": bathrooms,
        "internet": internet,
        "kitchen": kitchen,
        "image": image,
        "userEmail": userEmail,
      };
}
