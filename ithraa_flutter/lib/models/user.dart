class User {
  final String username;
  final String? type;
  final String email;
  final String? phone;
  final String? businessType;
  final String? image;
  final String? date;
  final String? major;
  final String? universityLocation;

  final String? password;
  final String? regNumber;
  final String? regFile;
  final String? contact;
  final String? website;
  final String? location;
  final int? status;

  const User({
    required this.username,
    this.type,
    required this.email,
    this.phone,
    this.businessType,
    this.image,
    this.date,
    this.major,
    this.universityLocation,
    required this.password,
    this.regNumber,
    this.regFile,
    this.contact,
    this.website,
    this.location,
    this.status,
  });

  factory User.fromMap(Map<dynamic, dynamic> data) {
    return User(
        username: data['username'] as dynamic,
        type: data['type'] as dynamic,
        email: data['email'] as dynamic,
        phone: data['phone'] as dynamic,
        businessType: data['businessType'] as dynamic,
        image: data['image'] as dynamic,
        date: data['date'] as dynamic,
        major: data['major'] as dynamic,
        universityLocation: data['universityLocation'] as dynamic,
        regNumber: data['regNumber'] as dynamic,
        regFile: data['regFile'] as dynamic,
        contact: data['contact'] as dynamic,
        website: data['website'] as dynamic,
        location: data['location'] as dynamic,
        password: data['password'] as dynamic,
        status: data['status'] as dynamic);
  }

  Map<String, dynamic> toMap() => {
        "username": username,
        "type": type,
        "email": email,
        "phone": phone,
        "businessType": businessType,
        "image": image,
        "date": date,
        "major": major,
        "universityLocation": universityLocation,
        "regNumber": regNumber,
        "regFile": regFile,
        "contact": contact,
        "website": website,
        "location": location,
        "password": password,
        "status": status,
      };

  factory User.fromJson(Map<dynamic, dynamic> data) {
    return User(
        username: data['username'] as dynamic,
        type: data['type'] as dynamic,
        email: data['email'] as dynamic,
        phone: data['phone'] as dynamic,
        businessType: data['businessType'] as dynamic,
        image: data['image'] as dynamic,
        date: data['date'] as dynamic,
        major: data['major'] as dynamic,
        universityLocation: data['universityLocation'] as dynamic,
        regNumber: data['regNumber'] as dynamic,
        regFile: data['regFile'] as dynamic,
        contact: data['contact'] as dynamic,
        website: data['website'] as dynamic,
        location: data['location'] as dynamic,
        password: data['password'] as dynamic,
        status: data['status'] as dynamic);
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "type": type,
        "email": email,
        "phone": phone,
        "businessType": businessType,
        "image": image,
        "date": date,
        "major": major,
        "universityLocation": universityLocation,
        "regNumber": regNumber,
        "regFile": regFile,
        "contact": contact,
        "website": website,
        "location": location,
        "password": password,
        "status": status,
      };
}
